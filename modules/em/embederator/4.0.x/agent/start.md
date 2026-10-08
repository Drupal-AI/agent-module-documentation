# Embederator — agent index

Manage reusable third-party embeds as entities. `embederator_type` (config bundle) holds the shared
markup (a `text_format` value) or an SSI URL; each `embederator` (fieldable content entity) supplies
per-instance token values (base field `embed_id`, plus any fields you add). Rendered markup is
token-replaced then output as `full_html`. No global config page (`configure` null). Provides a config
schema and permissions; no Drush, no new plugin types.

- **Bundles, markup vs SSI, tokens, the field formatter (load styles), templates, alter hooks** →
  [configure/embeds.md](configure/embeds.md)
- **Programmatic rendering: `embederator.render` / `embederator.utilities` services, the lazyload
  controller, and the three alter hooks** → [api/services.md](api/services.md)

Permissions: `view / add / edit / delete embederator entity` gate content instances;
`administer embederator types` gates the bundle config (raw-markup authoring).

Key facts:
- Bundle markup stored on `embederator.embederator_type.<id>` (`embed_markup.value` + `.format`, or
  `embed_url` when `use_ssi` is true); rendered via `EmbederatorRender::generateElement()` which hardcodes
  `#type => processed_text, #format => 'full_html'`.
- Tokens: `[embederator:embed_id]` and `[embederator:<added_field>]`, replaced by `Token::replace()`
  (sanitizes replacement values by default).
- Formatter `embederator_default` is applicable only to the `embed_id` base field; load styles:
  `''` (direct), `lazy`, `noquery`, `iframe`.
- Lazyload/iframe route: `/embederator/lazyload/{embederator}/{settings_json}` (`_entity_access:
  embederator.view`).
