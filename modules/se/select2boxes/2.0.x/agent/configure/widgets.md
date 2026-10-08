# Widgets & configuration

## Field widgets

Set on an entity's *Manage form display*:

| Widget id | Field types | Notes |
|---|---|---|
| `select2boxes_autocomplete_single` | `entity_reference` | extends `OptionsSelectWidget`; flattens multi-bundle options; supports auto-create |
| `select2boxes_autocomplete_multi` | `entity_reference` (multi) | AJAX autocomplete; supports **preload** option |
| `select2boxes_autocomplete_list` | `list_integer`, `list_float`, `list_string`, `language_field` | list/options fields |

All add attributes `data-select2-autocomplete-list-widget`, `class=select2-widget`, and disable core
autocomplete; the `select2boxes/widget` library provides the JS. Min-search-length is applied from
global config via `MinSearchLengthTrait`.

## Global settings form

Route `select2boxes.config_form` → `/admin/config/user-interface/select2boxes`, permission
`administer site configuration`. Config object `select2boxes.settings`:

| Key | Default | Effect |
|---|---|---|
| `select2_global` | false | Apply Select2 to every `<select>` via `template_preprocess_select` |
| `disable_for_admin_pages` | false | When global, skip admin routes (checks `router.admin_context`) |
| `limited_search` | – | Hide the search box until the list is long enough |
| `minimum_search_length` | – | Threshold list length for showing the search box |
| `provider` | `cdn` | Only `cdn` is offered |
| `version` | `4.0.5` | One of 4.0.1–4.0.5 (`Select2BoxesConfigForm::$allowedVersions`) |
| `url` | `https://cdnjs.cloudflare.com/ajax/libs/select2` | CDN base; final asset URLs are `"$url/$version/js/select2.full.min.js"` etc. built in `hook_library_info_build` |

`hook_page_attachments_alter` also preloads `select2boxes/widget` when `big_pipe` is enabled.

## Per-widget third-party settings (`hook_field_widget_third_party_settings_form`)

Stored under `field.widget.third_party.select2boxes`:

- **Multi entity-reference** (`select2boxes_autocomplete_multi`): `enable_preload` +
  `preload_count` (blank = preload all).
- **Single / list** widgets: `enable_flags` — only offered for `language_field`/`language`/`country`
  field types **and** when the `flags` module is enabled; renders flag icons. Auto-create fields skip
  the extra options.
- **Address widgets** (`address_default`, `address_country_default`, `address_zone_default`, only when
  `address` is enabled): `enable_select2` toggle; `hook_field_widget_form_alter` then passes the field
  name to `drupalSettings.addressFieldsSelect2` for the JS.

## Auto-create entity references

`AutoCreationProcessTrait::processAutoCreation()` is wired as the element `#value_callback` on the single
widget when the field's handler settings enable `auto_create`; on submit it creates the referenced
entity (via `EntityCreationTrait`) so editors can add new terms inline. The element gets
`data-auto-create-entity=enabled` for the JS.

## Traits (reusable helpers in `src/`)

`MinSearchLengthTrait`, `FlatteningOptionsTrait`, `AutoCreationProcessTrait` (+ `EntityCreationTrait`),
`PreloadBuildTrait`.
