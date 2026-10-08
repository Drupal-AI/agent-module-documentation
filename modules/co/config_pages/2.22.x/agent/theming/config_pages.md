# Theming — Twig function & Token access

## Twig: `config_pages_field()`

The module registers a Twig extension (`config_pages.twig_extension`,
`Drupal\config_pages\Twig\ConfigPagesExtension`) exposing one function:

```twig
{{ config_pages_field('my_settings', 'field_hero') }}
{{ config_pages_field('my_settings', 'field_hero', 'teaser') }}   {# optional view mode, default 'full' #}
```

`config_pages_field(config_page_type, field_name, view_mode = 'full')` returns the render array
for that field on the current-context singleton (it delegates to
`config_pages.loader::getFieldView()`, so cache metadata is attached automatically). The list of
functions is alterable via `hook_config_pages_functions_alter()` (module and theme).

## Templates & theme hook

The `config_pages` entity is themeable: `hook_theme()` defines a `config_pages` template
(`templates/`), with `config_pages_preprocess_config_pages()` exposing field variables and
`config_pages_theme_suggestions_config_pages()` adding per-bundle suggestions
(`config_pages__{bundle}`). Use **Manage display** on the type to configure view modes; a
`full` view mode is installed by default (`core.entity_view_mode.config_pages.full`).

## Token: `config_page` token type

`config_pages.tokens.inc` implements `hook_token_info()`/`hook_tokens()` and registers a
`config_page` token type. For every config page **type** whose `token` flag is enabled, a token
is generated so you can reference its field values, e.g.:

```
[config_page:my_settings:field_phone]
```

Only types with **token** turned on (type edit form → the `token` setting) appear. Under the
hood the replacement loads the page with `config_pages_config()` and delegates to core's entity
token generation for the `config_pages` entity.

## Rendering as a block

A `config_pages_block` block plugin (`Plugin/Block/ConfigPagesBlock`) renders a chosen config
page type in a chosen view mode (schema `block.settings.config_pages_block`:
`config_page_type`, `config_page_view_mode`). A `config_pages_values_access` **condition**
plugin (`Plugin/Condition/ConfigPagesValueAccess`) can gate other blocks on a config page
field value (`config_page_field`, `operator`, `condition_value`).
