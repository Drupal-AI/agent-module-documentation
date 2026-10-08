# tmgmt_content — agent start

TMGMT source submodule. Registers the **`content`** source plugin
(`Drupal\tmgmt_content\Plugin\tmgmt\Source\ContentEntitySource`, namespace
`Plugin/tmgmt/Source`) that exposes translatable **content entities** (nodes, terms, media,
blocks — anything with core `content_translation`) to TMGMT, and writes accepted translations
back as core entity translations. Part of the `tmgmt` project. Depends on `tmgmt`,
`content_translation`, `block`. No config UI of its own (`configure: null`).

Key facts:
- Source plugin id: **`content`** — used as `$job->addItem('content', $entity_type, $entity_id)`.
- Settings object `tmgmt_content.settings` with `embedded_fields`: reference fields whose
  targets (e.g. paragraphs) are pulled into the same job so nested content translates together.
- Field handling is pluggable via `Drupal\tmgmt_content\FieldProcessorInterface`
  (`DefaultFieldProcessor`, `LinkFieldProcessor`, `PathFieldProcessor`, `MetatagsFieldProcessor`).
- Adds the entity **Translate** tab/overview via `TmgmtContentRouteSubscriber`; preview route
  `/tmgmt/content/preview/{tmgmt_job_item}/{view_mode}`.
- To build/extend TMGMT source plugins in general, see the parent:
  [../../../../1.18.x/agent/plugins/tmgmt.md](../../../../1.18.x/agent/plugins/tmgmt.md).
- To create/request jobs in code, see [../../../../1.18.x/agent/api/tmgmt.md](../../../../1.18.x/agent/api/tmgmt.md).
