# Simple Search Form — agent index

Provides one Block plugin `simple_search_form_block`: a GET-method search input + submit that
redirects to `action_path?get_parameter=<value>`. No configure route (config lives on the block
instance), no permissions, no Drush. Optional integrations: Search API + Search API Autocomplete.

- **Place & configure the block; every setting key and its meaning** →
  [configure/block.md](configure/block.md)
- **Search API Autocomplete wiring; the `simple_search_form` View-tag auto-guess; lazy builder & caching** →
  [api/integration.md](api/integration.md)

Key facts:
- Block plugin id `simple_search_form_block`; settings stored on the `block` config entity under `settings` (schema `block.settings.simple_search_form_block`).
- Required settings: `action_path` (must start with `/`, `?`, or `#`) and `get_parameter`.
- Form is `method="get"`, no token; submit navigates to `action_path?get_parameter=<typed>`.
- Input types: `search`, `textfield`, and `search_api_autocomplete` (only when that module is enabled).
- Rendered via lazy builder `simple_search_form.lazy_builder:getForm`; adds `url.query_args:<param>` cache contexts when `input_keep_value` / `preserve_url_query_parameters` are used.
