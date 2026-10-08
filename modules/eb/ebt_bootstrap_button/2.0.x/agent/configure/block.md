<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure & use the Bootstrap Button block

No dedicated settings form (`configure: null`). Configuration is (a) the shipped block type + fields
and (b) global defaults inherited from EBT Core.

## Install / enable

`composer require drupal/ebt_core` is pulled by the dependency; then
`drush en ebt_bootstrap_button -y` (enables `ebt_core` too). EBT Core expects an `Image` media type to
exist. On this site the EBT field-storage/ebt_core chain was not fully installed, so the module fails
to enable — this doc is from on-disk source.

## Block type and fields

`config/install` creates block content type `ebt_bootstrap_button` with:
- `field_ebt_bootstrap_button_link` — core **Link** field (`type: link`, storage cardinality 1). The
  field config sets it **required** (`required: true`), with `link_type: 17` (URL — internal or
  external) and `title: 2` (link text required). It supplies the button's target URL and text.
- `field_ebt_settings` — `ebt_settings` field type (provided by `ebt_core`), edited with the
  `ebt_settings_bootstrap_button` widget below; not required.

Form display (`core.entity_form_display…default.yml`): link uses `link_default`, settings use
`ebt_settings_bootstrap_button`. View display (`core.entity_view_display…default.yml`): link uses the
`link` formatter (label hidden, `trim_length: 800`, `url_only: false`), settings use
`ebt_settings_default`.

Create instances at *Content → Block library → Add custom block → EBT Bootstrap Button*, or add an
inline block in Layout Builder. Placement/creation uses core block content + Layout Builder
permissions — this module adds none of its own.

Troubleshooting (README): if the Field Layout module forces Layout Builder onto the block type,
disable it at `/admin/structure/block/block-content/manage/ebt_bootstrap_button/display/default`.

## Widget settings (`ebt_settings_bootstrap_button`)

`EbtSettingsBootstrapButtonWidget::formElement()` calls the ebt_core parent, then adds these keys,
all stored under `field_ebt_settings.0.ebt_settings`:

| Setting | Type | Default |
|---|---|---|
| `open_in_new_tab` | checkbox | off |
| `add_nofollow` | checkbox | off |
| `alignment` | radios left/center/right | `left` |
| `button_type` | radios (primary, secondary, success, danger, warning, info, light, dark, link) | `primary` (**required**) |
| `outline_button` | checkbox | off |
| `active_button` | checkbox | off |
| `disable_button` | checkbox | off |
| `size` | radios size-default/btn-sm/btn-lg | `size-default` |
| `stretched` | checkbox | off (legacy `ept_settings.stretched`/misspelled `stetched` read for back-compat) |
| `custom_class_name` | textfield | empty |

`custom_class_name` runs `\Drupal\ebt_core\Helper\EbtGenericValidator::validateClassElement` as an
`#element_validate` callback. `massageFormValues()` just ensures each value has an `ebt_settings` key.
The design-layer options (CSS box, background, container width, colours/breakpoints) come from the
ebt_core parent widget.

## Global defaults (EBT Core)

Primary/secondary colours and mobile/tablet/desktop breakpoints are set once in EBT Core at
*Configuration → Content authoring → Extra Block Types (EBT) settings* and applied across EBT blocks.

## Install/uninstall logic (`ebt_bootstrap_button.install`)

- `ebt_bootstrap_button_update_9101()` — loads `FieldConfig` for
  `block_content.ebt_bootstrap_button.field_ebt_bootstrap_button_link` and sets it required (skips if
  absent).
- `ebt_bootstrap_button_uninstall()` — deletes the `ebt_bootstrap_button` block content type, but
  **only** if no `block_content` entities of that type remain; otherwise it logs a notice and keeps
  the type.
