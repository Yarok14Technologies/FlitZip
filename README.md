# Flitzip
 Verilog implementation of Flitzip data compression module.

---

# FlitZip – Hardware Compression / Decompression Modules (Verilog)

FlitZip is a Verilog-based hardware design project implementing lightweight **compression and decompression logic** using comparator-based encoding, priority encoding, and bit manipulation blocks.
The design is suitable for **NoC flit compression**, **data-path optimization**, or **low-latency hardware pipelines**.

---

## 📁 Project Structure

```
FlitZip/
│
├── 2by1Mux.v                 # 2:1 multiplexer
├── bitstrip.v                # Bit stripping logic
├── CompMAX.v                 # Maximum comparator
├── CompMIN.v                 # Minimum comparator
├── compressor.v              # Top-level compressor module
├── decompressor.v            # Top-level decompressor module
├── en_table.v                # Encoding table logic
├── minmax.v                  # Min–max evaluation block
├── prio_encoder.v            # Priority encoder
├── sign-ext.v                # Sign extension logic
├── small_comb.v              # Small combinational helper logic
├── subtractor.v              # Subtractor module
├── testbench.v               # Simulation testbench
│
├── comp_behav                # Behavioral comparator simulation file
├── flits                      # Sample input flits / data
│
├── compressor-schematic.pdf  # Compressor block-level schematic
├── decompressor-schematic.pdf# Decompressor block-level schematic
│
└── README.md                 # Project documentation
```

---

## 🧠 Design Overview

FlitZip implements a **hardware-efficient compression–decompression pipeline** optimized for:

* Reduced data width transmission
* Low combinational delay
* Modular RTL design
* Easy integration into NoC / SoC datapaths

### Core Concepts

* **Comparator-based encoding**
* **Priority encoding for bit selection**
* **Min–Max based data normalization**
* **Sign extension and reconstruction**

---

## 🧩 Key Modules

| Module           | Description                   |
| ---------------- | ----------------------------- |
| `compressor.v`   | Top-level compression logic   |
| `decompressor.v` | Top-level decompression logic |
| `CompMAX.v`      | Finds maximum value           |
| `CompMIN.v`      | Finds minimum value           |
| `prio_encoder.v` | Encodes highest-priority bit  |
| `bitstrip.v`     | Removes redundant bits        |
| `sign-ext.v`     | Sign extension logic          |
| `subtractor.v`   | Arithmetic subtraction        |
| `2by1Mux.v`      | 2-to-1 multiplexer            |
| `en_table.v`     | Encoding lookup logic         |

---

## 🧪 Simulation & Testing

* `testbench.v` contains the testbench for functional verification.
* Behavioral outputs can be verified using waveform viewers (GTKWave, Questa, etc.).
* `comp_behav` contains behavioral reference logic.

### Example Simulation (ModelSim / Questa)

```bash
vlog *.v
vsim testbench
run -all
```

---

## 📐 Schematics

* `compressor-schematic.pdf` – High-level compressor architecture
* `decompressor-schematic.pdf` – Decompression data flow

These help visualize how submodules are interconnected.

---

## 🧩 Tools & Compatibility

* Written in **Verilog HDL**
* Compatible with:

  * ModelSim / Questa
  * Vivado Simulator
  * Icarus Verilog
  * Verilator (with minor tweaks)

---

## 🚀 Future Improvements

* Parameterized data width
* Pipeline optimization
* Power-aware compression modes
* AXI-stream wrapper integration

---

## 📜 License

This project is intended for **educational and research use**.
Add a license file if you plan to distribute or commercialize.

---

