<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chunker (chunker) — agent index

Field formatter that splits a long HTML body into sectioned wrapper elements based on its inline
h2/h3 headings. A basic D9+ successor to the D7 Chunker text filter by dman; here it is a **field
formatter**, not a filter. Version 2.0.0. Core `^9 || ^10 || ^11`. Package "Fantastic Semantic Markup".

## At a glance
- **Dependencies:** Drupal core only (no `dependencies:` in `chunker.info.yml`, no composer.json).
- **Field formatter:** `ChunkerFormatter` (plugin id `chunker`) for field types `text_long`,
  `text_with_summary`. `src/Plugin/Field/FieldFormatter/ChunkerFormatter.php`.
- **Config schema:** `field.formatter.settings.chunker` in `config/schema/chunker.schema.yml`
  (keys: `start_level`, `section_tag`, `section_class`, `permalink_string`).
- **No** routes, services, permissions, hooks, install file, libraries, or global settings route.
  All configuration is per field display (Manage display).
- **Rendering:** re-sectioned markup is emitted via `#type => processed_text` with the field's own
  text format, so escaping matches the core default text formatter.
- **Tests:** `tests/src/Kernel/ChunkerFormatterTest.php` (expected-output examples).

## Solution docs
- Formatter behaviour, settings, and how to enable: [agent/fields/formatter.md](fields/formatter.md)
