<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Source Directory adds a migrate **source plugin** that reads a directory of files, so a folder of documents, images or HTML becomes migration rows without a CSV listing them first.

---

Migrate's source plugins cover databases, CSV, JSON, XML and URLs; the filesystem itself is a gap. Importing a folder of a thousand PDFs therefore starts with generating a manifest — a script producing a CSV of filenames, which then has to be regenerated whenever the folder changes. This plugin removes that step: point a migration at a directory and each file becomes a row, with its path and metadata available as source properties for the process pipeline to map onto a file or media entity. The module is small — `src/Plugin` plus `config/schema` — with core `migrate` as its only dependency and no routes, permissions or configuration UI, which is right for a plugin consumed from migration YAML. Core requirement is `^9 || ^10 || ^11`. Two practical notes: the directory is read at migration time, so a source that changes between a `migrate:status` and a `migrate:import` will behave accordingly; and the directory paths are set in the migration definition itself, so they are part of the migration config rather than a runtime input.

---

- Import a folder of PDFs as media entities.
- Migrate a directory of images into Drupal.
- Avoid generating a CSV manifest of files.
- Import legacy HTML files as nodes.
- Read filenames as migration source rows.
- Map file paths onto file entities.
- Import documents from a mounted share.
- Re-run an import as a folder grows.
- Use file metadata in a process pipeline.
- Migrate assets alongside a content migration.
- Import a photo archive.
- Build a media library from a directory.
- Combine directory source with a lookup migration.
- Import files from an export dump.
- Skip files by extension in the pipeline.
- Track imported files in the migrate map.
- Support a phased asset migration.
- Import a folder produced by another system.
