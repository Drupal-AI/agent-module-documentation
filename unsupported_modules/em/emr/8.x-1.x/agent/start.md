<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Meta Relation (emr) — agent index

Attaches separately-stored **`entity_meta` entities** to content, **revisioned in step with the
host**. Project `entity_meta_relation`, module **`emr`**. Version **8.x-1.9**.
Core `^9 || ^10 || ^11`.

Submodules: `emr_node` (node integration), `entity_meta_audio`, `_speed`, `_visual`, `_force`,
`_example` (**read this one** when writing a meta type).

**Three things fields do not give:** reuse across content types without duplicating field sets;
revision-correct history (an old revision shows the metadata it *had*); and separability, so a
module adds a meta type without touching the content model.

**The revision behaviour justifies the complexity** — "what did this page's SEO metadata say when
it was published" is genuinely hard with plain fields once revisions and translations are involved,
and it is exactly what an editorial audit asks.

From the OpenEuropa ecosystem — heavily revisioned, metadata-driven sites.