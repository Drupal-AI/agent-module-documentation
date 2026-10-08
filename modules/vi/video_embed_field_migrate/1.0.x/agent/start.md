<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Video Embed Field Migrate (video_embed_field_migrate) — agent index

Drush migration: Video Embed Field → core Media oEmbed. Version **1.0.0**. Depends on `media`.

- **Command**: `drush vef_migrate <refFieldName> [refFieldLabel]` (`VideoEmbedFieldMigrateCommands`).
  Steps: `preFlight()` → `findFieldsToMigrate()` → create `remote_video` media type + reference fields
  → `migrateField()` per value.
- **No web surface**: no routes/forms/controllers. CLI-only, trusted-operator tool. Reads local
  profile config YAML via `file_get_contents`. No SSRF/XSS/SQLi/access surface.
- **Advice**: run once against a backup; abandon on error.
