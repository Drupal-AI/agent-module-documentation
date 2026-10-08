<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Fire Brigade (wisski_fire_brigade) — agent index

Submodule of **wisski**. Maintenance and repair — its own description: *"A module attempting to
extinguish the ever burning WissKI fire."* Version **8.x-4.3**. Core `>=10.4 <12`.

**The candour is the useful signal.** A system spanning Drupal, a triple store, a pathbuilder
mapping and several external authority services has many ways to become inconsistent. Read this as
a statement about **operating** WissKI: it needs someone who understands its internals available to
it.

**Back up before running any repair against a triple store.** Repairs modify data already in an
unexpected state, and fixing a symptom can destroy the evidence of the cause. Work on a copy,
understand what a repair does first, and **record what was run** — an undocumented repair is later
indistinguishable from corruption.