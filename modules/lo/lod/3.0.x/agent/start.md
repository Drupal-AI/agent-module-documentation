<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Linked Open Data (LOD) — agent index

Provides **JSON-LD export plugin scaffolding and standard JSON-LD output** for content (publish entities as
Linked Open Data). Requires PHP 8.1. Depends on core `serialization`, `views`. Provides permissions. Version
**3.0.0**. Core `^10||^11`.

Decoupled/data-publishing — **exposes content as JSON-LD**: ensure only **public** content is exposed (respect
content access — restricted content is a disclosure risk). No access role beyond permission.
