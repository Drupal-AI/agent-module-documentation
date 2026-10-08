<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translation template extractor (potx) — agent index

Extracts translatable strings from Drupal source into Gettext `.pot` templates (or `.po`
files). Two entry points: a **Drush command** and a **web form**. Depends on core `locale`.
No configure route, no config, no permissions of its own (the UI reuses core's
`translate interface` permission).

- **`drush potx` — modes, options, where files land** → [drush/potx.md](drush/potx.md)
- **The Extract web form (route, path, how to pick a component)** →
  [configure/extract-form.md](configure/extract-form.md)
- **The `potx.inc` extraction API (functions, constants) other tools call** →
  [api/extractor.md](api/extractor.md)

Key facts:
- Drush: `drush potx [single|multiple|core]` with `--modules`, `--files`, `--folder`, `--api`,
  `--language`, `--translations`. Default mode `single`. Output written as `.pot` files to the
  **current working directory**.
- Web UI: route `potx.extract_translation` at
  `/admin/config/regional/translate/extract` (Extract tab), permission `translate interface`.
- API version constant `POTX_API_CURRENT = 8`; extraction functions live in `potx.inc`.
