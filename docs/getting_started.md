# Getting Started
 
Welcome to the FIREQ platform! This quick-start guide provides everything you need to set up your RFSoC board, configure hardware clocking and RF parameters, flash the OS, deploy the server environment, and run your first quantum experiment.

> **Project Information & Publications**:  
> For complete details about the FIREQ project architecture, hardware goals, team, and scientific publications/papers, please visit the **[Project Info](project_info.md)** page.

---

## Supported Hardware & Board Setup

FIREQ currently supports two Xilinx RFSoC platforms: the **ZCU216** evaluation board and the **RFSoC4x2** board.

### 1. Xilinx ZCU216 Evaluation Board

* **Overview & Documentation**: Refer to the official [AMD/Xilinx ZCU216 Product Page](https://www.xilinx.com/products/boards-and-kits/zcu216.html) and the [RF DC Evaluation Tool Guide](https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/246153525/RF+DC+Evaluation+Tool+for+ZCU216+board+-+Quick+start).
* **Active Channels**:
	* **RF-DAC Channels**: DAC 228 (Channels 0 and 1) and DAC 229 (Channel 0).
	* **RF-ADC Channels**: ADC 224 (Channel 0) and ADC 225 (Channel 0).
* **Breakout Board**: Requires the [XM655](https://docs.amd.com/r/en-US/ug1390-zcu216-eval-bd/XM650/XM655-Balun-Add-on-Cards-for-RFSoC-EVM) breakout board to interface with the RF-DAC and RF-ADC channels via HC2 and SSMP connectors.
* **Clocking Daughterboard [CLK104](https://docs.amd.com/r/en-US/ug1437-clk104/Introduction)**:
	* The dedicated synthesizers **LMX2594 ADC** and **LMX2594 DAC** on the CLK104 board provide low-jitter RF sampling clocks for the RFSoC ADCs and DACs.
	* The main RF output (Port A) of each synthesizer uses a **Carlisle SSMP loopback cable (TM40-0153)** to connect directly to the RF sampling clock input connectors on the ZCU216 EVM.

### 2. RFSoC4x2 Board

* **Overview & Documentation**: Refer to the official [RealDigital RFSoC4x2 Page](https://www.realdigital.org/hardware/rfsoc-4x2) and the [RFSoC-PYNQ Getting Started Guide](https://www.rfsoc-pynq.io/rfsoc_4x2_getting_started.html).
* **Active Channels**:
	* **RF-DAC Channels**: DAC 228 (Channel 0) and DAC 230 (Channel 0)
	* **RF-ADC Channels**: ADC 224 (Channel 0) and ADC 226 (Channel 0)
---

## RF Data Converter Configuration & MTS Overview (ZCU216 Reference)

The FIREQ firmware configures the onboard Zynq UltraScale+ RF Data Converter (RFDC) IP block on the **ZCU216** board for high-speed signal generation and acquisition. The setup leverages **Multi-Tile Synchronization (MTS)** following AMD/Xilinx guidelines ([PG269](https://docs.amd.com/r/en-US/pg269-rf-data-converter/Multi-Tile-Synchronization)) to maintain phase coherence across converter tiles.

### Key Highlights
* **Active Channels**: DAC 228 (Ch 0 & 1), DAC 229 (Ch 0), ADC 224 (Ch 0), and ADC 225 (Ch 0).
* **Sampling Frequencies**:
  * **RF-DACs**: Operating at **9.33888 GSPS**.
  * **RF-ADCs**: Operating at **2.33472 GSPS**.
  * **Fabric Clock**: All AXI Stream interfaces and custom IP blocks operate at **583.68 MHz**.
* **Clock Distribution**: Provided by the CLK104 daughterboard into master distribution nodes **ADC Tile 225** and **DAC Tile 229** (both with PLL VCO set at **9338.88 MHz**).

> **Full Hardware Specifications & RFDC Tables**: For the complete tile tables, reference clock dividers, and physical XDC constraints (`PL_SYSREF` / `PL_CLK`), refer to the **[ZCU216 Overlay Documentation](repos/FIREQ/docs/modules/overlay_zcu216.md)**.

> **Note:** The RF-DAC sampling frequency (**9.33888 GSPS**) and fabric clock (**583.68 MHz**) specified
> above also apply to the **RFSoC4x2** platform, with the RF-ADC sampling
> frequency set to **4.66944 GSPS**.


## SD Card Image Flashing

To run FIREQ, your Micro-SD card (16 GB or larger) must be flashed with the appropriate PYNQ Linux image.

1. **Download the Linux Image**:
	 * **For RFSoC4x2**: Download the official PYNQ v3.0.1 image from [PYNQ Boards](http://www.pynq.io/boards.html).
	 * **For ZCU216**: Use our custom pre-configured FIREQ ZCU216 [image](https://drive.google.com/file/d/1SGH7_pw0L9ww165A97FIzp7Xo3PNwCV2/view?usp=sharing)

2. **Flash the Micro-SD Card**:
	 * Insert the Micro-SD card into your host workstation.
	 * Use a disk imaging utility like **Win32DiskImager** or **BalenaEtcher**.
	 * Select the downloaded `.img` file, choose the Micro-SD target drive, and click **Write**.

3. **Boot Mode Configuration**:
	 * Insert the flashed Micro-SD card into the RFSoC board slot.
	 * **ZCU216**: Set the 4-position DIP switch (`SW2`) to **SD Boot Mode** (`Pos 1 = ON`, `Pos 2..4 = OFF`).
	 * **RFSoC4x2**: Set the boot mode slider switch to **SD**.

---

## Server Deployment & Execution

The server runs on the Linux system of the RFSoC board. From your local
workstation, clone the server repository and copy it to the board:

```bash
git clone https://github.com/vlsi-nanocomputing/FIREQ-Server.git
scp -r FIREQ-Server xilinx@<board-ip>:/home/xilinx/
```

As an alternative, when the board has network access to GitHub, connect to the
board and clone the repository directly there:

```bash
ssh xilinx@<board-ip>
cd /home/xilinx
git clone https://github.com/vlsi-nanocomputing/FIREQ-Server.git
exit
```

The prepackaged overlays are located in:

* `FIREQ-Server/overlays/zcu216` for the ZCU216
* `FIREQ-Server/rfsoc4x2_overlay/rfsoc4x2` for the RFSoC4x2

Each directory contains the matching `.bit` and `.hwh` files. 

### Board-side startup

Connect to the board and activate the PYNQ environment:

```bash
ssh xilinx@<board-ip>
sudo -i
source /etc/profile.d/pynq_venv.sh
cd /home/xilinx/FIREQ-Server
```

Install or update server dependencies when necessary:

```bash
pip install -r requirements.txt
```

Start the interactive server entry point:

```bash
python start_server.py
```

When prompted, set the address and port before starting the server. Bind the
server to all board interfaces and choose a port reachable by the client (the
defaults shown below are suitable for a direct board connection):

```text
# Insert server host (press Enter for "0.0.0.0")
0.0.0.0
# Insert server port (press Enter for "5000")
5000
```

The client must use the board's reachable IP address, not `0.0.0.0`, and the
same port selected here.

When prompted for the overlay filename, enter the `.bit` filename relative to
`/home/xilinx/` (for example, `FIREQ.bit`). The matching `.hwh` file must have
the same base name and be in the same directory.

## Client Execution & Workflow
Once the server is running on the board, launch the client on your local workstation.

### Local client setup

Copy or clone the client repository on the local workstation and open a
terminal in that directory:

```bash
git clone https://github.com/vlsi-nanocomputing/FIREQ-Client.git
cd FIREQ-Client
```

Create the virtual environment and install the dependencies listed in
`requirements.txt`:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

On Windows PowerShell, activate the environment with:

```powershell
.\.venv\Scripts\Activate.ps1
```

Before launching the client, open `run_client.py` and set the server address
and port to match the board configuration:

```python
SERVER_IP = "<board-ip>"
SERVER_PORT = 5000
```

Start the client:

```bash
python run_client.py
```

The client uses the values configured above when it connects to the server.

### Example usage: ZCU216 loopback

For the ZCU216 example, connect **DAC 228 channel 0** to **ADC 224 channel 0**
using the board's RF breakout/daughter-board setup. The first experiment uses
the loopback configuration:

At the client prompt, run:

```text
run_yaml experiments/loopback.yaml
```

The client stores the experiment output in
`experiment_output/<experiment_name>/experiment_<timestamp>/`. After the
experiment completes, open a second terminal in the `FIREQ-Client` directory,
activate the virtual environment, and start the plotter:

```bash
python run_plotter.py
```

At the plotter prompt, use the output directory to display and save the 2D plot:

```text
plot_2d experiment_output/<experiment_name>/experiment_<timestamp> save
```

```{figure} ../graphics/zcu216_loopback.png
:alt: ZCU216 loopback connection using the daughter board
:align: center

ZCU216 loopback setup using the daughter board.
```

### Example usage: RFSoC4x2 loopback

For the RFSoC4x2 example, connect **DAC 228 channel 0** to **ADC 224 channel 0**.
Use the same workflow:

At the client prompt, run:

```text
run_yaml experiments/loopback.yaml
```

The output is stored in
`experiment_output/<experiment_name>/experiment_<timestamp>/`. After the
experiment completes, start the plotter from a second terminal in the
`FIREQ-Client` directory:

```bash
python run_plotter.py
```

Then use the plotter prompt:

```text
plot_2d experiment_output/<experiment_name>/experiment_<timestamp> save
```

```{figure} ../graphics/rfsoc4x2_loopback.png
:alt: RFSoC4x2 loopback connection
:align: center

RFSoC4x2 loopback setup.
```


## Where to Go Next?
Depending on your task, refer to the following documentation sections:

- **[Project Information](project_info.md)**: Background, publications, contribution info.
- **[FIREQ-Server Documentation](repos/FIREQ-Server/docs/index.md)**: Network communication protocol, server API.
- **[FIREQ-Client Documentation](repos/FIREQ-Client/docs/index.md)**: Guide on writing custom YAML experiment definitions, using the Python API, CLI tools, and automated plotting options.
- **[FPGA Firmware & Modules](repos/FIREQ/docs/index.md)**: Deep dive into the Vivado overlay architecture, IP block definitions (Generators, Timing, Acquisition units), and Register Maps.


