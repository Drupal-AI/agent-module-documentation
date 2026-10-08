# tmgmt — agent start

Translation Management Tool: a framework that collects translatable text into **jobs**
(`tmgmt_job` + `tmgmt_job_item` content entities), sends them to a **provider**
(`tmgmt_translator` config entity, from a `Plugin\tmgmt\Translator`), and offers a **review UI**
to accept the returned translation. Sources (`Plugin\tmgmt\Source`) expose the text.
Depends on core `language`, `views`, `block`, `options`. Config UI: **Admin → Translation**
(`/admin/tmgmt`); global settings route `tmgmt.settings` (`/admin/tmgmt/settings`).

- Create a provider, request a translation job, use the review UI → [configure/tmgmt.md](configure/tmgmt.md)
- Translator + Source plugin types — add a provider or source → [plugins/tmgmt.md](plugins/tmgmt.md)
- Drive jobs/items in code (entities + services) → [api/tmgmt.md](api/tmgmt.md)
- Checkout, request-translation, and data-item hooks → [hooks/tmgmt.md](hooks/tmgmt.md)

Core submodules (documented separately, nested under this project):
- `tmgmt_content` — content-entity source → [../../modules/tmgmt_content/1.19.x/agent/start.md](../../modules/tmgmt_content/1.19.x/agent/start.md)
- `tmgmt_local` — in-Drupal human translation → [../../modules/tmgmt_local/1.19.x/agent/start.md](../../modules/tmgmt_local/1.19.x/agent/start.md)
- `tmgmt_file` — XLIFF/HTML file export/import translator → [../../modules/tmgmt_file/1.19.x/agent/start.md](../../modules/tmgmt_file/1.19.x/agent/start.md)

Other submodules (not documented here): `tmgmt_locale` (locale-string source),
`tmgmt_config` (config-entity source), `tmgmt_language_combination` (language-abilities field).

## Diff 1.18.x → 1.19.x

Maintenance release (`8.x-1.19`, packaged 2026-08-27) — ~15 issues, no API/route/permission or
entity-schema changes. Same `core_version_requirement: ^10.3 || ^11`, same plugin types, same
Job/JobItem/Message/RemoteMapping/Translator entities. Notable changes:

- **New:** job item is auto-deleted when its corresponding source entity is deleted.
- **New:** "purge continuous jobs item" management for continuous jobs; the `tmgmt.settings`
  object now also carries `purge_continuous`, `purge_continuous_aborted`, `purge_stale`, and
  `field_length_overflow_policy` (configurable fallback for translations that overflow a column,
  default `needs_review`).
- **Fix:** non-translatable fields no longer exported when a bundle isn't content-translation
  enabled; filtering job items by type no longer crashes; "Data too long for column 'message'"
  handled; `JobItem::acceptTranslation()` failure handling improved; fewer "Source was updated…"
  messages; continuous-job endless-loop with `content_translation_outdated` fixed.
- **Compat:** PHP 8.5 (removed deprecated `(boolean)` cast); a general performance fix.
