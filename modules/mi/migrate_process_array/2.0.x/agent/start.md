<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Process Array — agent index

Five Migrate **process plugins** for working with array values in a migration `process:` pipeline.
Core `^9.3 || ^10 || ^11`. Package Migration. No config UI, no permissions, no dependencies declared
in info.yml (uses core `migrate` classes). Version **2.0.2**.

Developer/migration feature — transforms values during import under the migration's control; no runtime,
content, or access role. All plugins coerce scalars to a one-element array and return NULL on empty
input or empty result.

Plugin ids: `array_intersect`, `array_diff`, `array_filter`, `deepen`, `extract_single`.

- agent/plugins/process.md — each plugin id, its config keys, behavior, and a YAML `process:` example.
