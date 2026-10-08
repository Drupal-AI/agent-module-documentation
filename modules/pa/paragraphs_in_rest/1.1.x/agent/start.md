<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs in REST — agent index

A **custom normalizer that serializes nested Paragraphs (entity-reference-revisions) inline in REST**. Depends
on core `rest`, `paragraphs`. Version **1.1.0-beta1**. Core `^10||^11`.

Decoupled/integration — the REST resource enforces the **parent's access** and paragraphs inherit it, so inline
data matches what the parent exposes; still review **field-level** access / exposed fields. No access role of
its own.
