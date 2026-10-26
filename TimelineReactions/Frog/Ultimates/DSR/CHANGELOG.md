# DSR Draws release notes

## 2026-10-26

- Add an **Open AnyoneCore roster** button above the draw settings so party roles can be checked and corrected before using role-based guidance.
- Keep Wyrmsbreath and Eyes pairing logic unchanged; the reported mismatches were traced to party roster assignments.
- Validate the saved menu action and exported Lua syntax. Opening the roster uses the existing AnyoneCore manual roster window.

## 2026-10-25

### Strength of the Ward

- Add roster-based initial triangle spread guidance for all eight roles. Detect the safe axis from Spiral Thrust casts, apply the G1 NW-to-S / G2 N-to-SE split, and clear each player's guidance after their Lightning Storm hit.
- Calibrate DPS spread positions against debug-log snapshots, placing them approximately 20.22 yalms from arena centre while preserving separation and charge-lane clearance.
- Capture all three defamation markers using marker ID 330. Wait for the complete assignment before displaying defamation or unmarked stack guidance.
- Guide marked players to relative south, east or west; offset east and west 1.5 yalms towards relative south. Compare all three marked players before choosing an eligible destination, then lock and reserve that destination for the mechanic to prevent reassignment as players move.
- Keep these draws under the existing P2 Strength menu setting. Retain tank knight-tether guidance and unmarked DPS/healer stack guidance. No Conviction tower tether is added.

### Shared profile maintenance

- Include Wyrmsbreath 1 anchor/flexer guidance that refreshes cached assignments when the replay player or roster changes and rejects same-element or non-anchor destinations.
- Start the MCH P2 opener hold on countdown, with release 13 seconds after countdown completion; retain the full-P1 pull fallback.
- Synchronize the existing shared utility and job-specific reactions from the maintained local Draws profile. Initial Strength spread reactions are shared through Draws; superseded DPS-only copies have been deleted.

### Validation

- Isolated checks cover all 32 initial spread role/rotation combinations, charge-lane clearance and a minimum 6.5-yalm separation.
- Wyrmsbreath checks cover 120 colour/role cases, including replay-player changes.
- Defamation checks cover 24 player/rotation cases, fixed destinations and assignment retention when another marked player moves closer.
- In-game replay confirmation remains necessary for visual timing and live ACR hold behaviour.
