Admin UI for the Flags module: create, edit, and delete the country→flag and language→flag mapping config entities without writing config by hand.

---

Flags UI adds an administration section at *Configuration → Regional and language → Flags* (`/admin/config/regional/flags`, the `configure` route `flags.menu`) with two entity list pages and full add/edit/delete forms for the base module's mapping config entities: `country_flag_mapping` (under `/admin/config/regional/flags/countries`) and `language_flag_mapping` (under `/admin/config/regional/flags/languages`). Each mapping record ties a `source` code (a country or language code) to a `flag` (the territory flag code to display), overriding the default identity mapping used by `flags.mapping.country` / `flags.mapping.language`. All pages require the base module's `administer flag mapping` permission (list pages via `_permission`, add/edit/delete via the `country_flag_mapping`/`language_flag_mapping` entity access handler, which also checks that permission). The module provides only forms and routes — no new permissions, schema, or plugin types of its own. Depends on `flags`.

---

- Remap a language code to a different territory's flag (e.g. `en` → GB) through the UI.
- Remap a country code to an alternative flag where the ISO code and sprite differ.
- List all configured country-to-flag overrides.
- List all configured language-to-flag overrides.
- Add a new mapping override without editing YAML.
- Edit an existing mapping override.
- Delete a mapping override to fall back to the default code→flag behavior.
- Delegate flag-mapping management to non-developers with the right permission.
- Produce exportable configuration entities for deployment across environments.
- Correct flags for locales whose language code has no matching flag sprite.
- Point a regional language variant at its country's flag (e.g. `pt-br` → BR).
- Review at a glance which codes have custom flag mappings via the list pages.
- Restrict flag-mapping edits to trusted roles with `administer flag mapping`.
- Set up mappings once and reuse them across flags_country/flags_language/flags_languagefield.
- Fix an incorrect default flag rendering for a specific country code.
- Manage both country and language flag overrides from one admin section.
- Add mappings for custom/added languages that have no default flag.
- Remove obsolete overrides to restore default flag behavior.
