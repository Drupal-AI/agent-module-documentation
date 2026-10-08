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
- `tmgmt_content` — content-entity source → [../../modules/tmgmt_content/1.18.x/agent/start.md](../../modules/tmgmt_content/1.18.x/agent/start.md)
- `tmgmt_local` — in-Drupal human translation → [../../modules/tmgmt_local/1.18.x/agent/start.md](../../modules/tmgmt_local/1.18.x/agent/start.md)
- `tmgmt_file` — XLIFF/HTML file export/import translator → [../../modules/tmgmt_file/1.18.x/agent/start.md](../../modules/tmgmt_file/1.18.x/agent/start.md)

Other submodules (not documented here): `tmgmt_locale` (locale-string source),
`tmgmt_config` (config-entity source), `tmgmt_language_combination` (language-abilities field).
