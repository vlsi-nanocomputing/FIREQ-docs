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

### 2. RealDigital RFSoC4x2 Board

* **Overview & Documentation**: Refer to the official [RealDigital RFSoC4x2 Page](https://www.realdigital.org/hardware/rfsoc-4x2) and the [RFSoC-PYNQ Getting Started Guide](https://www.rfsoc-pynq.io/rfsoc_4x2_getting_started.html).
* **Status**: **TBD**

---

## RF Data Converter Configuration & MTS Overview (ZCU216 Reference)

The FIREQ firmware configures the onboard Zynq UltraScale+ RF Data Converter (RFDC) IP block for high-speed signal generation and acquisition on the **ZCU216** board, leveraging **Multi-Tile Synchronization (MTS)** ([PG269: Zynq UltraScale+ RF Data Converter LogiCORE IP Product Guide](https://docs.amd.com/r/en-US/pg269-rf-data-converter/Multi-Tile-Synchronization)) to maintain phase coherence across multiple converter tiles.

Below is the detailed clocking and sampling rate summary for the active tiles:

### RF-ADC Tiles (Acquisition)

| Tile | Sampling Rate ($F_s$) | Max $F_s$ | Reference Clock | PLL Ref Clock | Fabric Clock | Clock Source | Distribute Clock |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **ADC 224** | **2.33472 GSPS** | 2.500 GSPS | 2334.720 MHz | — | 583.680 MHz | Tile225 | Off |
| **ADC 225** | **2.33472 GSPS** | 2.500 GSPS | 491.520 MHz | 245.76 MHz | 583.680 MHz | Tile225 | **PLL Output (Distributor)** |
| **ADC 226** | **2.00000 GSPS** | 2.500 GSPS | 2000.000 MHz | — | 0.0 MHz | Tile226 | Off |
| **ADC 227** | **2.00000 GSPS** | 2.500 GSPS | 2000.000 MHz | — | 0.0 MHz | Tile227 | Off |

* **PLL Summary**: ADC 225 VCO is configured at **9338.88 MHz** ($M=4, R=2$, Fb Div $= 38$).

### RF-DAC Tiles (Signal Generation)

| Tile | Sampling Rate ($F_s$) | Max $F_s$ | Reference Clock | PLL Ref Clock | Fabric Clock | Clock Source | Distribute Clock |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **DAC 228** | **9.33888 GSPS** | 10.000 GSPS | 9338.880 MHz | — | 583.680 MHz | Tile229 | Off |
| **DAC 229** | **9.33888 GSPS** | 10.000 GSPS | 491.520 MHz | 245.76 MHz | 583.680 MHz | Tile229 | **PLL Output (Distributor)** |
| **DAC 230** | **9.33888 GSPS** | 10.000 GSPS | 9338.880 MHz | — | 0.0 MHz | Tile230 | Off |
| **DAC 231** | **6.40000 GSPS** | 10.000 GSPS | 6400.000 MHz | — | 0.0 MHz | Tile231 | Off |

* **PLL Summary**: DAC 229 VCO is configured at **9338.88 MHz** ($M=1, R=2$, Fb Div $= 38$).
---

## SD Card Image Flashing

To run FIREQ, your Micro-SD card (16 GB or larger) must be flashed with the appropriate PYNQ Linux image.

1. **Download the Linux Image**:
	 * **For RFSoC4x2**: Download the official PYNQ v??? image from [PYNQ Boards](http://www.pynq.io/boards.html).
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

### 1. Deployment to Target Board
Transfer the `FIREQ-Server` project folder along with the FPGA overlay artifacts (`.bit` and matching `.hwh` files) onto the target Linux filesystem:

```bash
scp -r /path/to/FIREQ-Server xilinx@<board-ip>:/home/xilinx/
```

> **Note**: Ensure that the target FPGA `.bit` and matching `.hwh` hardware handoff files reside under `/home/xilinx/` or inside the project root directory.

### 2. Environment Setup & SSH Access

1. Connect to the board via SSH:

```bash
ssh xilinx@<board-ip>
```
2. Acquire root privileges (required for PYNQ direct memory-mapped access and hardware registers):


```bash
sudo -i
```
3. Activate the system PYNQ virtual environment:

```bash
source /etc/profile.d/pynq_venv.sh
```
4. Install/update server dependencies if needed:


```bash
cd /home/xilinx/FIREQ-Server
pip install -r requirements.txt
```

### 3. Interactive Startup Sequence
Launch the server using the main entry point script:


```bash
python API.py
```

Upon execution, `API.py` starts an interactive prompt setup:

- **Logging level**: Type `debug` or press `Enter` for default `info`.
- **Overlay filename**: Enter the bitstream filename relative to `/home/xilinx/` (press `Enter` for default `overlay.bit`). The matching `.hwh` file must reside in the same directory.
- **Server host**: Define the listening interface (press `Enter` for `0.0.0.0` to bind all network interfaces).
- **Server port**: Define the TCP port (press `Enter` for `5000`).
- **Auth token**: Define the secret security token (press `Enter` for default `"fireq"`).
Once inputs are accepted, `FIREQServer` loads the FPGA overlay, initializes memory-mapped registers, binds the socket, and launches the worker threads (`ReceiveWorker` and `SendWorker`).

> To stop the server safely without leaving hardware registers in uninitialized states, press `Ctrl+C` (`KeyboardInterrupt`).

## Client Execution & Workflow
Once the server is running on the board, launch the client on your local workstation.

1. **Launch the FIREQ Client**:
Open a terminal in your local `FIREQ-Client` directory and run:


```bash
python run_client.py
```
2. **Execute an Experiment**:
Pass a YAML experiment configuration file (e.g., a Rabi oscillation sequence):


```bash
run_yaml experiments/Rabi.yaml
```
3. **Inspect Output**:
The client communicates with the server via the binary TCP protocol, applies the parameters, triggers execution, receives raw DMA acquisition streams, and generates plots and data files in your output directory.

## Where to Go Next?
Depending on your task, refer to the following documentation sections:

- **[Project Information](project_info.md)**: Background, publications, contribution info.
- **[FIREQ-Server Documentation](repos/FIREQ-Server/docs/index.md)**: Network communication protocol, server API.
- **[FIREQ-Client Documentation](repos/FIREQ-Client/docs/index.md)**: Guide on writing custom YAML experiment definitions, using the Python API, CLI tools, and automated plotting options.
- **[FPGA Firmware & Modules](repos/FIREQ/docs/index.md)**: Deep dive into the Vivado overlay architecture, IP block definitions (Generators, Timing, Acquisition units), and Register Maps.


