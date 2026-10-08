<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Meta Relation Node (emr_node) — agent index

Submodule of **emr** (project `entity_meta_relation`). Node integration for EMR.
Version **8.x-1.9**. Core `^10 || ^11`. Depends on `node`, `emr`.

**The revision handling earns the module.** When a node is revised its related meta entities must be
revised with it, or an old revision shows *today's* metadata — which makes revision history a lie
for anything metadata-driven. Getting that right across nodes, translations and moderation states
is genuinely hard.

Configuration is **per content type** — the right granularity, so adding a meta type to Articles
does not add it to Basic pages.

Anything building on EMR for node content depends on this, not on `emr` alone.