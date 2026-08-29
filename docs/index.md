# Welcome to FIREQ

FIREQ stands for *FPGA Instrumentation for Readout and Qubit control*. It is a flexible platform for quantum-control experiments built around RFSoC hardware.

FIREQ combines a high-level Python client, a runtime server, and custom HDL
firmware into a unified workflow for signal generation, data acquisition, and
low-latency experiment orchestration.

## FIREQ Architecture at a glance

```{figure} ../graphics/fireq_architecture.png
:alt: FIREQ system overview
:class: fireq-architecture
:align: center

High-level FIREQ workflow across client, server, and RFSoC firmware.
```

## Platform components

::::{grid} 1 1 3 3
:gutter: 3

:::{grid-item-card} FIREQ-Client
:class-card: fireq-component-card
:link: repos/FIREQ-Client/docs/index
:link-type: doc

Python-based interface used to define experiments, submit commands, and manage
execution.
:::

:::{grid-item-card} FIREQ-Server
:class-card: fireq-component-card
:link: repos/FIREQ-Server/docs/index
:link-type: doc

Backend service running on the target platform, exposing FIREQ functionality to
the client.
:::

:::{grid-item-card} FIREQ Firmware
:class-card: fireq-component-card
:link: repos/FIREQ/docs/index
:link-type: doc

Low-level hardware implementation responsible for acquisition, generation,
triggering, and timing.
:::

::::

## Documentation index

::::{grid} 1 1 2 2
:gutter: 3

:::{grid-item-card} Getting Started & Quick Start
:class-card: fireq-doc-card
:link: getting_started
:link-type: doc

Board setup, SD card preparation, and first experiment execution.
:::

:::{grid-item-card} Client Documentation
:class-card: fireq-doc-card
:link: repos/FIREQ-Client/docs/index
:link-type: doc

Experiment definitions, plotting, and command reference.
:::

:::{grid-item-card} Server Documentation
:class-card: fireq-doc-card
:link: repos/FIREQ-Server/docs/index
:link-type: doc

Deployment, hardware API/driver layer, and runtime usage.
:::

:::{grid-item-card} Firmware Documentation
:class-card: fireq-doc-card
:link: repos/FIREQ/docs/index
:link-type: doc

FPGA architecture, AXI interfaces, and register mapping.
:::

:::{grid-item-card} Project Info & Paper
:class-card: fireq-doc-card
:link: project_info
:link-type: doc

Publications, repository links, and support channels.
:::

::::

```{toctree}
:maxdepth: 2
:hidden:

getting_started
repos/FIREQ-Client/docs/index
repos/FIREQ-Server/docs/index
repos/FIREQ/docs/index
Project Info <project_info>
```