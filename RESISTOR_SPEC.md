# Resistor Component Specification

Altium Designer component standard for SMD chip resistors.  
Import script: `Import.pas` — input format: ASCII `.txt`.

---

## SCH Symbol

Applies to **all** resistor packages. All dimensions in mm, on a **0.5 mm metric grid**.

### Geometry

| Element | Parameter | Value (mm) | Value (mil) |
|---|---|---|---|
| Pin 1 | Location X | -4.50 | -177.17 |
| Pin 2 | Location X | +4.50 | +177.17 |
| Both pins | Location Y | 0 | 0 |
| Both pins | Length | 3.00 | 118.11 |
| Both pins | Type | Passive | — |
| Both pins | Rotation | 0° / 180° | — |
| Rectangle | Width (X) | 3.00 | 118.11 |
| Rectangle | Height (Y) | 1.00 | 39.37 |
| Rectangle | Centre | 0, 0 | 0, 0 |

### Style

| Property | Value |
|---|---|
| Line colour | Black (`$000000`) |
| Rectangle fill | Light grey (`#D3D3D3`) |
| Rectangle border | Small (5 mil) |
| Pin designators | Hidden |
| Pin names | Hidden |

### Visible Parameters

Positioned below the component body, centre-aligned.

| Parameter | Y (mm) | Y (mil) | Justification |
|---|---|---|---|
| MPN | -1.00 | -39.37 | TopCenter |
| DES | -2.50 | -98.43 | TopCenter |

**DES format:** `RES - <value> <power> <tolerance> - <package>`  
**Example:** `RES - 100R 0.25W 1% - 0603`

### Hidden Parameters

| Parameter | Example |
|---|---|
| Manufacturer | Vishay |
| Datasheet | https://... |

### Font (all parameters)

| Property | Value |
|---|---|
| Name | Arial |
| Size | 6 (Height token: 60) |
| Bold | Yes |
| Italic | No |
| Underline | No |
| Colour | Black (`$000000`) |

---

## PCB Footprint

IPC-7351 Nominal land pattern, reflow soldering.  
All coordinates in mm (script input in mils = mm ÷ 0.0254).

### Layers

| Layer | Altium keyword | Content |
|---|---|---|
| Top copper | `Top` | SMD pads |
| Silkscreen | `TopOverlay` | 2 tick marks (line width 5 mil) |
| Courtyard | `Mechanical15` | Courtyard rectangle + centre marker |
| Assembly | `Mechanical13` | Component body outline |

### Centre Marker (Mechanical15, all packages)

| Element | Dimension |
|---|---|
| Cross arm length | ±0.50 mm (±19.69 mil) each axis |
| Circle radius | 0.25 mm (9.84 mil) |
| Line width | 2 mil |

### 0402 (1005M)

| Feature | X (mm) | Y (mm) |
|---|---|---|
| Pad centre | ±0.52 | 0 |
| Pad size | 0.54 | 0.64 |
| Silkscreen extent | ±0.15 | ±0.40 |
| Courtyard | ±0.97 | ±0.52 |
| Assembly | ±0.50 | ±0.25 |

### 0603 (1608M)

| Feature | X (mm) | Y (mm) |
|---|---|---|
| Pad centre | ±0.75 | 0 |
| Pad size | 0.75 | 1.00 |
| Silkscreen extent | ±0.30 | ±0.60 |
| Courtyard | ±1.40 | ±0.75 |
| Assembly | ±0.80 | ±0.45 |

### 0805 (2012M)

| Feature | X (mm) | Y (mm) |
|---|---|---|
| Pad centre | ±1.00 | 0 |
| Pad size | 0.90 | 1.45 |
| Silkscreen extent | ±0.40 | ±0.85 |
| Courtyard | ±1.75 | ±0.95 |
| Assembly | ±1.00 | ±0.60 |

### 1206 (3216M)

| Feature | X (mm) | Y (mm) |
|---|---|---|
| Pad centre | ±1.50 | 0 |
| Pad size | 1.00 | 1.80 |
| Silkscreen extent | ±0.65 | ±1.05 |
| Courtyard | ±2.35 | ±1.15 |
| Assembly | ±1.60 | ±0.80 |

### Pad properties

| Property | Value |
|---|---|
| Shape | Rectangular |
| Layer | Top (SMD) |
| Solder mask expansion | 0 (manual) |
| Paste mask expansion | 0 (manual) |

---

## Generating a New Resistor

Use the `/resistor` skill:

```
/resistor <MPN> <value> <power> <tolerance> <package>
```

**Example:**
```
/resistor RCS0603100RFKEC 100R 0.25W 1% 0603
```

This generates `Components\<MPN>.txt`. Delete any existing output files in `Libs\`, then run the import script in Altium Designer via **DXP → Run Script → Import**.

## Project Folder Layout

```
altium-script-test-1\
    Components\          ← all component txt source files live here
        RCS0603100RFKEC.txt
        RCS06031K00FKEA.txt
        ...
    Libs\                ← generated output (SchLib, PcbLib, LibPkg)
        RCS0603100RFKEC.SchLib
        RCS0603100RFKEC.PcbLib
        RCS0603100RFKEC.LibPkg
        ...
    Import.pas
    ImportForm.pas
    ImportForm.dfm
```
