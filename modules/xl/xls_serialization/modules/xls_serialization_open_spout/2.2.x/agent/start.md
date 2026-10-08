<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Serialization (Excel using OpenSpout library) (xls_serialization_open_spout) — agent index

Submodule of **xls_serialization**. Replaces the `xlsx` encoder with an OpenSpout-based
one for faster, lower-memory Excel exports. Enabling it is the whole configuration — no
UI, config, or permissions. Depends on the `xls_serialization` module and the external
`openspout/openspout` (^4) library. Core `^10 || ^11`. License GPL-2.0-or-later. Version 2.2.0.

- How the decorator swaps the XLSX backend + trade-offs → [api/xls_serialization_open_spout.md](api/xls_serialization_open_spout.md)
- Base encoder / formats / Views options live in the parent module → [../../../../2.2.x/agent/start.md](../../../../2.2.x/agent/start.md)
