# Getting Started

This guide provides a step-by-step entry point for bringing up the FIREQ platform and running your first experiment.

## High-Level Workflow

1. Review the overall system architecture in the [Index](index.md).
2. Configure and deploy the target hardware using the steps below.
3. Refer to the [Server Documentation](components/server.md) for environment setup, deployment, and service configuration.
4. Use the [Client Documentation](components/client.md) for local installation, API guidelines, and experiment execution.
---

## Quick Start Guide

### 1. Board Setup
Prepare the target hardware (e.g., ZCU216 evaluation board). 
TO DO

### 2. SD Card Setup
Flash the Linux image onto the micro-SD card and ensure the necessary runtime dependencies and FPGA bitstreams are copied over.
TO DO

### 3. Connection & Network
Establish network access to the board (via SSH or Ethernet) and verify that the target IP address is reachable from your host PC.
TO DO

### 4. First Run
1. Start the [FIREQ-Server](components/server.md) process on the board.
```bash
python API.py
```
2. Launch the [FIREQ-Client](components/client.md) on your host PC:
```bash
python run_client.py
```
3. run an [experiment](repos/FIREQ-Client/docs/usage.md) with `run_yaml experiments/Rabi.yaml`,
4. wait for the acquisition to complete,
5. inspect the generated output files.
