<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create & manage Custom Formatters

Manage at **admin/structure/formatters** (`entity.formatter.collection`, permission
`administer custom formatters`). *Add formatter* → pick an engine → write the code/config → save. The
formatter then appears in Field UI *Manage display* for its declared field types.

## Routes

| Route | Path | Access |
|---|---|---|
| `entity.formatter.collection` | `/admin/structure/formatters` | `administer custom formatters` |
| `custom_formatters.add_page` | `/admin/structure/formatters/add` | `administer custom formatters` |
| `custom_formatters.add` | `/admin/structure/formatters/add/{formatter_type}` | `administer custom formatters` |
| `entity.formatter.edit_form` | `/admin/structure/formatters/manage/{formatter}` | `formatter.update` |
| `entity.formatter.delete_form` | `.../{formatter}/delete` | `formatter.delete` |
| `custom_formatters.settings_form` | `/admin/structure/formatters/settings` | `administer custom formatters` |
| `entity.formatter_setting.*` | `.../{formatter}/settings/...` | `formatter.update` / `formatter_setting.*` |

(The entity access handlers grant everything to holders of `administer custom formatters`.)

## The `formatter` config entity

Config prefix `custom_formatters.formatter.<id>`. Exported keys (`config_export`):

| Key | Meaning |
|---|---|
| `id` | Machine name. |
| `label` | Human label (shown as the formatter option in Manage display). |
| `type` | Engine plugin id: `php`, `twig`, `html_token`, `formatter_preset`. |
| `description` | Admin description. |
| `field_types` | Array of field type ids the formatter applies to (limits where it appears). |
| `data` | The engine payload — PHP code, Twig template, HTML+Token markup, or preset config. |

The entity is a `ConfigEntityBundleBase` with `bundle_of = formatter_setting`, and
`calculateDependencies()` (via `FormatterDependencyBuilder`) adds config/module dependencies (e.g. the
field types, wrapped preset formatter, token module).

## Engines (the `type` value)

| `type` | What `data` holds | Notes |
|---|---|---|
| `php` | Bare PHP (no `<?php` tags) | **`eval()`ed** at render; receives `$items`, `$langcode`, `$settings`, `$raw_settings`; return markup or an array, or echo. |
| `twig` | A Twig template string | Rendered via the `twig` service; vars `items`, `langcode`, `entity`, `settings`, `raw_settings`. |
| `html_token` | HTML with `[tokens]` | Token-replaced (needs `token`; `field_tokens` for field-level tokens). |
| `formatter_preset` | Config selecting an existing formatter + locked settings | Wraps a core/contrib formatter as a reusable preset. |

## Per-instance settings

Because a formatter is the bundle of the `FormatterSetting` content entity, you can add fields to a
formatter (its *Manage fields* / *Manage form display* tabs). When the formatter is chosen on a *Manage
display* screen, those fields render inline and their values reach the engine as:

- `$settings['field_name']` — rendered through the field's view display.
- `$raw_settings['field_name']` (PHP) / `raw_settings.field_name` (Twig) / `[formatter_setting:field:raw]`
  (HTML+Token) — the unformatted `getString()` value.

Shipped examples live in `config/optional/` (e.g. `example_twig_title`, `example_html_token_image`,
`example_php_image`, `example_preset_img_thumb`) and are installed if their dependencies are met.

## Drush (create a simple Twig formatter)

```bash
ddev drush php:eval '\Drupal::entityTypeManager()->getStorage("formatter")->create([
  "id" => "my_bold_text", "label" => "Bold text", "type" => "twig",
  "field_types" => ["string"], "data" => "<strong>{{ items.0.value }}</strong>",
])->save();'
```

> Writing/importing a `php`/`twig` formatter is arbitrary code execution — treat it as a trusted-admin
> operation.
