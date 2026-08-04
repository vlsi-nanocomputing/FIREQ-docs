# Welcome to FIREQ

The FPGA Instrumentation for Readout and Qubit control (FIREQ) is a flexible platform for quantum-control experiments built around RFSoC hardware. It combines a high-level interface, a runtime service, and custom firmware into a unified workflow for generating signals, acquiring data, and coordinating complex experiment sequences with low latency.

![FIREQ System Overview](../graphics/fireq_architecture.png)

---

## What is FIREQ?

FIREQ is composed of three main components:

* **[Client](repos/FIREQ-Client/docs/index.md)**: Python-based interface used to define experiments, submit commands, and manage execution.
* **[Server](repos/FIREQ-Server/docs/index.md)**: Backend service running on the target platform (supports ZCU216), exposing functionality to the client.
* **[Firmware](repos/FIREQ/docs/index.md)**: Low-level hardware implementation responsible for acquisition, generation, triggering, and timing.

---

## Documentation Index

Explore the documentation sections to get started or dive deep into specific components:

* **[Getting Started & Quick Start](getting_started.md)**: Board setup, SD card preparation, and your first experiment run.
* **[Client Documentation](repos/FIREQ-Client/docs/index.md)**: Experiment definitions, plotting, and command reference.
* **[Server Documentation](repos/FIREQ-Server/docs/index.md)**: Deployment, Hardware API/Driver layer, and runtime usage.
* **[Firmware Documentation](repos/FIREQ/docs/index.md)**: FPGA architecture, AXI interfaces, and register mapping.
* **[Project Info & Paper](project_info.md)**: Publications, repository links, and support channels.

```{toctree}
:maxdepth: 2
:hidden:

getting_started
repos/FIREQ-Client/docs/index
repos/FIREQ-Server/docs/index
repos/FIREQ/docs/index
project_info
