Tokens in Views Filter Criteria adds a "Use tokens" checkbox to Views string, numeric, date, datetime, combine, list-field and geofield-proximity filters, so a filter's value can contain replacement tokens (e.g. `[current-user:uid]`, `[site:name]`) that are resolved at query time.

---

The module decorates a set of core (and contrib) Views filter plugins by defining replacement plugins of the *same plugin id* in `src/Plugin/views/filter/token/` — `string`, `numeric`, `date`, `datetime`, `combine`, `list_field`, `geofield_proximity_filter` — and swapping the core plugin's class for its own via `hook_views_plugins_filter_alter()`. Each replacement subclass mixes in `TokensFilterTrait` (or `TokensDateFilterTrait` / `TokensGeofieldFilterTrait`), which adds a `use_tokens` option (default FALSE), a "Use tokens" checkbox plus a token-browser link to the filter's options form, and a `preQuery()` that calls `replaceTokens()` on the value when the box is ticked. Tokens are resolved with the core `token` service against the `view` and `current-page` token types (with `clear => TRUE`, so unknown tokens become empty). Because Drupal's config-schema discovery lets the last-loaded schema win, the module injects the `use_tokens` boolean into each affected filter schema at runtime through `hook_config_schema_info_alter()` rather than shipping overriding schema files. It also provides its own tiny plugin type (`plugin.manager.token_views_filter`, discovery dir `Plugin/views/filter/token`) so other modules can register token-aware replacements for additional filter ids by defining a plugin with the same id, extending the original filter, implementing `TokenViewsFilterPluginInterface`, and using `TokensFilterTrait`. There is no admin settings page — configuration is entirely per-filter inside each View. This gives you dynamic, context-aware filter values (a lightweight alternative to contextual filters/relationships) without writing custom Views handlers.

---

- Filter a View to the current user's own content with a value like `[current-user:uid]`.
- Show "my" items in a block View by tokenising an author/uid filter, no contextual filter needed.
- Filter by the current page's node id using `current-page` tokens.
- Insert the site name or other global tokens into a string filter value.
- Restrict a listing by the logged-in user's email, name, or role via user tokens.
- Use a token in a numeric filter's min/max to compare against a dynamic threshold.
- Tokenise a date/datetime filter so "since [current-user:last-login]" style ranges work.
- Provide per-user dashboards from a single View instead of one View per role.
- Filter a combine filter's value with a token spanning multiple fields.
- Tokenise a list-field (options) filter value.
- Feed a geofield proximity filter an origin from a token (requires the geofield submodule support).
- Build a "content I created this week" block by combining a tokenised author filter with a date filter.
- Avoid duplicating Views by making one View adapt to whoever is viewing it.
- Tokenise the value of a grouped/exposed filter's individual group items.
- Replace a hand-written `hook_views_query_alter()` with a configurable tokenised filter.
- Populate a filter from a request/query token on the current page.
- Register a token-aware replacement for a contrib filter id via the module's plugin manager.
- Extend the module to a new filter type by subclassing the original filter and using `TokensFilterTrait`.
- Clear (blank out) a filter when its token has no value, thanks to `clear => TRUE` replacement.
- Drive "related content" style listings from tokens of the entity being viewed.
- Keep filter logic in the Views UI (checkbox + token browser) rather than in code.
- Personalise search/listing pages without exposing extra filters to end users.
- Combine tokenised filters with exposed filters for mixed static/dynamic filtering.
- Use `[current-user:field_*]` tokens to filter by a value stored on the viewer's profile.
