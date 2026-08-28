# FIREQ Documentation

This repository contains the central documentation site for **FIREQ**.

**FIREQ** stands for *FPGA Instrumentation for Readout and Qubit control*. It is
a modular RFSoC-based platform for quantum-control experiments, integrating a
Python client, a runtime server, and FPGA firmware for signal generation, data
acquisition, and low-latency experiment orchestration.

The published documentation is available at:

https://fireq-docs.polito.it

## Documentation structure

The FIREQ documentation is organized as a central Sphinx project that integrates
content from the FIREQ component repositories:

- [`FIREQ-Client`](https://github.com/vlsi-nanocomputing/FIREQ-Client): Python client interface.
- [`FIREQ-Server`](https://github.com/vlsi-nanocomputing/FIREQ-Server): server-side runtime and hardware control layer.
<!---- [`FIREQ`](https://github.com/vlsi-nanocomputing/FIREQ): FPGA firmware and RFSoC hardware logic.-->

The central documentation source is located in:

```text
docs/
```

During the documentation build, component documentation is staged under:

```text
docs/repos/
```

This directory is generated automatically and should not be edited manually.

## Repository layout

```text
FIREQ-docs/
├── docs/                    Sphinx documentation source
│   ├── _static/             Static assets, logos, and custom CSS
│   ├── index.md             Documentation landing page
│   ├── getting_started.md   Getting started guide
│   ├── project_info.md      Project information and references
│   └── repos/               Generated component documentation staging area
├── graphics/                Shared figures used by the documentation
├── scripts/                 Documentation synchronization scripts
├── fireq-release.yaml       Integrated documentation release manifest
├── requirements.txt         Python documentation dependencies
└── README.md
```

## Building the documentation locally

Clone this repository next to the FIREQ component repositories:

```text
Development/
├── FIREQ-docs/
├── FIREQ-Client/
├── FIREQ-Server/
└── FIREQ/
```

Create and activate a Python virtual environment:

```bash
cd FIREQ-docs
python -m venv .venv
source .venv/bin/activate
```

Install the documentation dependencies:

```bash
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

Synchronize the component documentation:

```bash
./scripts/sync_component_docs.sh
```

Build the HTML documentation:

```bash
rm -rf _build
python -m sphinx -b html docs _build/html
```

Preview the site locally:

```bash
python -m http.server 8000 --directory _build/html
```

Then open:

```text
http://localhost:8000
```

## Integrated release manifest

The file:

```text
fireq-release.yaml
```

defines which revision of each FIREQ component repository is integrated into the
documentation build.

Each component can point to a branch, tag, or commit SHA.

## Deployment

The documentation is built automatically using GitHub Actions.

The public GitHub Pages site is deployed only when the `main` branch of this
repository is updated. Other documentation-related branches and component
repository dispatches are used to build preview artifacts.

## Contributing

Documentation improvements should be made either:

- directly in this repository for project-level pages by creating a docs/** branch
- in the relevant component repository for client, server, or firmware-specific
  documentation.

Generated content under `docs/repos/` should not be edited manually.