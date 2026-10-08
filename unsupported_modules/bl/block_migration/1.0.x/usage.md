Drush-based tooling to export and import custom `block_content` entities (with all translations) between Drupal sites as YAML files.

---

Block Migration fills a gap in Drupal's deployment workflow: Configuration Management moves block *placement* and settings, but custom block *content* is a content entity that config export ignores. This module ships two Drush commands — `bm-export` and `bm-import` — that serialize each reusable custom block to one YAML file per language and recreate it on another site keyed by UUID. Export is a self-contained custom service (`BlockContentExporter`) that auto-detects every non-base field on any block bundle and serializes it by field type (text keeps `value`+`format`, entity references keep `target_id` only, links keep uri/title/options, etc.); import parses the YAML back, groups files by UUID, and creates or updates block entities and their translations, with a safe mode that skips existing blocks and an `--override` mode that updates them. The module requires `single_content_sync` (its YAML shape is compatible) but performs entity creation directly. All operations are CLI-only; there are no web routes, permissions, or admin UI.

---

- Export all custom blocks of all bundles in all languages to a directory: `drush bm-export /path/to/output`.
- Export a specific set of blocks by internal ID: `drush bm-export /path --ids=54,55,72`.
- Export only certain block bundles: `drush bm-export /path --bundle=basic,banner,footer`.
- Export only selected languages: `drush bm-export /path --languages=ca,es`.
- Export blocks whose label matches a wildcard pattern: `drush bm-export /path --label="HOME*"` or `--label="*footer*"`.
- Preview an export without writing any files: `drush bm-export /path --dry-run`.
- Avoid clobbering previously exported files: `drush bm-export /path --no-overwrite`.
- Combine filters for precise selection: `drush bm-export /path --bundle=basic --languages=ca,es --label="*2024*"`.
- Back up specific blocks before editing them: `drush bm-export /tmp/backup --ids=54,55,56`.
- Import new blocks safely, skipping any that already exist (default): `drush bm-import /path/to/yaml`.
- Import and update existing blocks in place: `drush bm-import /path/to/yaml --override`.
- Deploy block content from dev to production via version control (commit the YAML, `git pull`, then `bm-import`).
- Sync block content across multisite installations by exporting once and importing into each site.
- Restore block content from a YAML backup after accidental edits or deletion.
- Move multilingual blocks between environments while preserving every translation (one file per langcode, grouped by UUID on import).
- Migrate blocks that use arbitrary custom fields (text, string, boolean, integer/decimal/float, datetime, list, link) without configuring field mappings.
- Ship block content as default content inside a custom install profile or module by committing exported YAML alongside code.
- Seed a fresh environment with a curated set of homepage/banner blocks using label-pattern filtering.
- Audit or diff block content between sites by exporting both and comparing the generated YAML.
