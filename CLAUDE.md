# altium-script-test-1 — Project Context

Altium Designer schematic library component files, generated in a custom ASCII import format
and loaded into Altium via `Import.pas`.

---

## Component file format (ASCII)

Files live in `Components/<MPN>.txt`. Structure:

```
StartFootprints
  Footprint (Name "...")
  Pad / PadShape / Line / Arc / EndPad / EndFootprint blocks
EndFootprints

StartComponents
  Component / Description / Comment / Parameter / Pin / Line / Rectangle / Footprint lines
  EndComponent
EndComponents
```

Key rules:
- All coordinates in **mils** (1mm = 39.3701 mil). Round to 2 d.p.
- Grid: **1mm metric** (39.37 mil). Never use 0.5mm grid for ICs.
- Pin length: **5mm = 196.85 mil**
- PinType values: `IO`, `Input`, `Output`, `Passive`, `Power`, `OpenCollector`, `OpenEmitter`, `HiZ`
  — `IO` not `Bidirectional` (importer falls to Passive for unknown types)
- `ISch_Pin` has no FontID property — pin font is set by Altium library defaults after import

---

## SCH symbol conventions

### Capacitors / resistors (passives)
- IEC parallel-plate symbol for capacitors, rectangle for resistors
- 2-pin, PartCount 1, DesPrefix C? / R?
- Pin locations: ±216.54 (caps), ±177.17→update to ±216.54 for all packages (see pending)
- MPN param Y: **-78.74** | DES param Y: **-137.80**
- Plate lines (caps): `Start -19.69, -59.06 End -19.69, 59.06` (and mirror)
- Pin inner end touches plate at ±19.69 (no gap)

### ICs / microcontrollers
- PartCount 2: **Part A** = GPIO/Logic/SWD/RF, **Part B** = Power (VDD/VSS)
- DesPrefix U?
- Pin pitch: **3mm = 118.11 mil**
- Body width: ±10mm (±393.70 mil) Part A, ±8mm (±314.96 mil) Part B
- Pin tip X: ±15mm Part A (±590.55 mil), ±13mm Part B (±511.81 mil)
- Layout formula:
  - `body_hH = (N_max // 2 + 1) × 118.11` (half-height in mil)
  - `y_top = body_hH - 118.11` (topmost pin, both sides top-aligned)
  - `y_MPN = -(body_hH_A + 118.11)`, `y_DES = -(body_hH_A + 236.22)`
- Pins organised by function (not physical package sequence)
- Part A LEFT: PortA, C, D, E, H (sorted by port+number)
- Part A RIGHT: PortB + NRST/OSC/RF/antenna/SWD (PB sorted first, then specials alpha)
- Part B LEFT: VBAT, VDD×N, VDDA, VDDRF, VDDSMPS, VDDUSB
- Part B RIGHT: VSS, VSSRF, VSSSMPS, VFBSMPS, VLXSMPS, VCAP
- STM32 pin data: fetch XML from `raw.githubusercontent.com/STMicroelectronics/STM32_open_pin_data/master/mcu/<MPN>.xml`

---

## Skills (slash commands)

| Command | Purpose |
|---|---|
| `/capacitor <MPN> <cap> <V> <tol> <diel> <pkg>` | Generate a KEMET MLCC cap component file |
| `/resistor <MPN> <R> <W> <tol> <pkg>` | Generate a Vishay chip resistor component file |
| `/chip <MPN> <package> <datasheet_url>` | Generate an STM32 (or similar) IC component file |

Skills are in `.claude/commands/`.

---

## Import.pas notes

- `SY_AddPin` at ~line 753: parses Pin lines and creates `ISch_Pin` objects
- PinType case: `'IO'` → `eElectricIO` (line 767) — this is the correct string
- `ISch_Pin` has no `NameFontId` / `DesignatorFontId` / `FontID` property — removing these was correct
- `SY_GetFont(Height, Angle, FontName, Bold, Italic, Underline)` → TFontID — valid for text/param objects

---

## Component library contents (as of 2026-05-11)

| Type | Count | Status |
|---|---|---|
| KEMET C1002 MLCC caps (0402/0603/0805/1206) | ~1664 | All files exist; see pending below |
| Vishay RCS0603 resistors | ~673 | Generated, committed |
| STM32WB/WBA microcontrollers | 31 | Generated, committed |

---

## Pending work

### 1. Capacitor files — symbol not fully consistent across packages

The 0402 test batch (~50 files, C0402C*.txt) has the correct final spec:
- Plate lines ±59.06 Y, pin tips at ±216.54, MPN Y=-78.74, DES Y=-137.80

The remaining 0603/0805/1206 files still have:
- Plate lines ±29.53 Y (old height)
- Pin tips at ±255.91 (0603), etc. — pushed out correctly for 5mm but from original position
- MPN Y=-39.37, DES Y=-98.43 (old positions)

**To fix:** run a batch update script on all non-0402 capacitor files to bring them in line with the 0402 spec. Also apply plate/MPN/DES changes to the remaining C0402C files not yet in the test batch.

### 2. STM32 IC files — 30 files need regeneration

All 31 files were committed. `STM32WB15CCU6` was regenerated with the correct spec (3mm pitch, 1mm grid, IO pintype). The other 30 still have:
- `PinType Bidirectional` (importer falls to Passive — wrong)
- 100-mil pin pitch (not 3mm metric)
- Body heights not on 1mm grid

**To fix:** regenerate all 31 chips using the `/chip` skill. Pin data is available from ST's open_pin_data GitHub repo.

### 3. Resistor skill — pin length not updated

`resistor.md` still specifies 3mm (118.11 mil) pins and ±177.17 tip locations.
The actual resistor component files were updated to 5mm pins.
**To fix:** update `resistor.md` to match the capacitor skill (196.85 length, ±216.54 tips, -78.74/-137.80 params).
