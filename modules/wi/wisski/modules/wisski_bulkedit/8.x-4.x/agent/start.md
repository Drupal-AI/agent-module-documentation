<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Bulk Edit (wisski_bulkedit) — agent index

Submodule of **wisski**, under the project's **`legacy/`** directory. Bulk updates entities from
**CSV**. Version **8.x-4.3**. Core `>=10.4 <12`.

Corrections in research collections arrive in batches — a specialist's spreadsheet of four hundred
re-attributions, a reconciliation run's two thousand identifiers. CSV is the format the people
producing them work in.

**Two safeguards to insist on:** back up the triple store (a bulk edit is not straightforwardly
undoable), and run against a **copy with a sample** first. The failure mode is not an error
message — it is several thousand records quietly updated with the wrong value in the right field.

**Legacy directory** — establish the current recommended path before building a workflow on it.