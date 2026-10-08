# xls_serialization_open_spout — agent start

Submodule of **xls_serialization**. Replaces the `xlsx` encoder with an OpenSpout-based
one for faster, lower-memory Excel exports. Enabling it is the whole configuration — no
UI, config, or permissions. Depends on the `xls_serialization` module and the external
`openspout/openspout` (^4) library.

- How the decorator swaps the XLSX backend + trade-offs → [api/xls_serialization_open_spout.md](api/xls_serialization_open_spout.md)
- Base encoder / formats / Views options live in the parent module → `modules/xls_serialization/2.1.x/agent/start.md`
