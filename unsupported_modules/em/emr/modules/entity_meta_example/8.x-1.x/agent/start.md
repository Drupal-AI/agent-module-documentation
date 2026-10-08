<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Meta Example (entity_meta_example) — agent index

Submodule of **emr**. A **worked meta entity** related to nodes, parenting four demonstration
types. Version **8.x-1.9**. Core `^10 || ^11`. Depends on `emr`.

Nested: `entity_meta_audio`, `entity_meta_speed`, `entity_meta_visual`, `entity_meta_force` —
deliberately abstract names, showing that several meta types coexist on one host and configure
independently.

**Read it before writing a meta type.** The interfaces alone do not convey how the pieces fit —
entity definition vs relationship configuration vs where revision behaviour comes from.

**Do not enable in production** — it contributes meaningless meta types that will end up in
configuration.