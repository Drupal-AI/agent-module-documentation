# Tokens in Views Filter Criteria — agent index

Adds a **"Use tokens"** checkbox to Views filters so a filter value can contain tokens
(`[current-user:uid]`, `[site:name]`, …) resolved at query time against the `view` and
`current-page` token types. Depends on `token`. No admin settings page — config is per-filter,
stored as `use_tokens: true` (plus the tokenised `value`) inside each View. Decorates core
filter plugins by class-swapping same-id plugins.

- **Turn tokens on for a filter / where `use_tokens` is stored / how resolution works** →
  [configure/use-tokens.md](configure/use-tokens.md)
- **Add token support to another filter id (own plugin) or register via the manager** →
  [plugins/token-filter.md](plugins/token-filter.md)

Key facts:
- Supported filter ids (replacement plugins in `Plugin/views/filter/token`): `string`, `numeric`, `date`, `datetime`, `combine`, `list_field`, `geofield_proximity_filter`.
- Stored config: within `views.view.<id>` → the filter handler gains `use_tokens: true` alongside its `value`.
- Mechanism: `hook_views_plugins_filter_alter()` swaps the core filter class for the module's; `TokensFilterTrait::preQuery()` runs `token->replace($value, ['view'=>...], ['clear'=>TRUE])`.
- `use_tokens` schema is injected at runtime via `hook_config_schema_info_alter()` (not a static schema override).
- Plugin type: manager `plugin.manager.token_views_filter`, interface `TokenViewsFilterPluginInterface`, trait `TokensFilterTrait`.
