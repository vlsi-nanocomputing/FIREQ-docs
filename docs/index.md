# Welcome to FIREQ

The FPGA Instrumentation for Readout and Qubit control (FIREQ) is a flexible platform for quantum-control experiments built around RFSoC hardware. It combines a high-level interface, a runtime service, and custom firmware into a unified workflow for generating signals, acquiring data, and coordinating complex experiment sequences with low latency.

<!-- EXAMPLE OF IMAGE HERE: High-level system block diagram or FIREQ logo -->
![FIREQ System Overview](../graphics/fireq_system_overview.png)

## What is FIREQ?

FIREQ is composed of three main components:

- **Client**: the Python-based interface used to define experiments, submit commands, and manage execution.
- **Server**: the backend service that runs on the target platform and exposes the required functionality to the client. It fully supports the ZCU216 evaluation board.
- **Firmware**: the hardware implementation responsible for acquisition, generation, triggering, and timing.

Together, these components provide a complete environment for running experiments in a structured and reproducible way.

## Getting Started

First, for a global overview of FIREQ and its capabilities, read our instrumentation paper introducing the system:
> **[Insert Paper Title Here]** *(Authors et al., 2026)* — [Link to Paper/DOI](#)

A typical workflow is:

1. Review the overview of the system.
2. Refer to the firmware documentation for hardware-specific details.
3. Deploy and operate the server.
4. Configure and run the client.

## Quick Start

This section will provide a concise entry point for the first setup steps of the platform.

- **Board setup**: preparation of the target hardware and initial configuration
- **SD card setup**: flashing and boot image preparation
- **Connection**: establishing access to the board and runtime environment
- **First run**: launching the server and starting a first experiment

To be completed with the final step-by-step instructions for hardware setup and initial bring-up.

## Documentation

The documentation is organized as follows:

- **[Client Documentation](components/client.md)**: for experiment setup, commands, plots, and output handling.
- **[Server Documentation](components/server.md)**: for deployment, environment setup, and runtime usage.
- **[Firmware Documentation](components/firmware.md)**: for hardware-specific details and implementation guidance.

```{toctree}
:maxdepth: 2
:hidden:

components/client
components/server
components/firmware
```

## Project Links

You can find more information and project resources here:

- **GitHub repository**: [https://github.com/vlsi-nanocomputing/](https://github.com/vlsi-nanocomputing/)
- **Project group website**: [https://qnano.polito.it/](https://qnano.polito.it/)

## Contact

If you have questions, feedback, or need support, please contact the FIREQ development team through the project channels listed above or through the repository issue tracker.

This documentation is intended to provide a practical entry point for both new users and experienced developers working with FIREQ.