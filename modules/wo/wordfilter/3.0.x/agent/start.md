# Wordfilter — agent index

Replaces banned/keyword words with configurable substitution text via reusable
`wordfilter_configuration` entities and a pluggable process type. Applied as a text-format filter,
on node/comment base fields, or via a `processed_text` render element. Config UI:
`entity.wordfilter_configuration.collection` (*Config → Content authoring → Wordfilter
configurations*). Depends on core `filter`. Provides config schema, permissions, and one plugin
type; no Drush.

- **Create/apply configurations: the entity, the `wordfilter` filter, node/comment binding, permissions** →
  [configure/configurations.md](configure/configurations.md)
- **The `wordfilter_process` plugin type + the two shipped processes; how to add your own** →
  [plugins/process.md](plugins/process.md)

Key facts:
- Config entity `wordfilter_configuration`: `process_id` + `items[]` (each `filter_words`,
  `substitute`, `delta`). Shipped processes: `default` (direct regex), `token` (token-aware).
- Filter plugin id `wordfilter` (TYPE_TRANSFORM_IRREVERSIBLE); settings key
  `active_wordfilter_configs`. Also applied via `hook_entity_display_build_alter` (node
  title/body, comment subject/body) and `template_preprocess_comment`, using each type's
  `third_party.wordfilter.active_wordfilter_configs`.
- Permissions: `administer wordfilter configurations` (`restrict access: true`),
  `access wordfilter configurations page`, dynamic `administer wordfilter configuration <id>`.
- Safety: filter words + substitution run through `Xss::filterAdmin()`; token process additionally
  runs `token->replace()`; node title render path uses autoescaped Twig (`{{ filtered|nl2br }}`).
