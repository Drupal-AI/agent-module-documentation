<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations Export (annotations_export) — agent index

Drush export of assembled annotation context as markdown or an Obsidian vault. Depends on `annotations`, `annotations_context`. CLI-only (no routes/permissions).

## Provides

- **Drush** `annotations_export.drush_commands` (`AnnotationsExportCommands`): `annotations:export` (alias `ann:ex`). Options: `--format=markdown|obsidian`, `--output`, `--target`, `--entity-type`, `--annotation-types`, `--ref-depth` (0–2), `--inc-meta`, `--inc-refs`, `--strip-headings`. Markdown defaults to stdout; `--output` required for obsidian.
- **Service** `annotations_export.obsidian_vault_writer` (`ObsidianVaultWriter`) — `write($payload, $outputDir): int`. One `.md` per target: `buildFrontmatter()` (YAML: target/entity_type/bundle/aliases/tags) + `buildBody()` (annotation values + fields + a Relationships section of `- [[dest_id]] via \`field\``).

## Notes for agents

- Runs as a privileged CLI caller: assembles with no account filter, so **all** annotation types are included unless `--annotation-types` limits them.
- Output paths are operator-supplied Drush arguments; target IDs come from config entity IDs (`entity_type__bundle`). No web-facing file-write surface.
