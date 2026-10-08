<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ebt_webform_popup` block content type

## Install & enable

```bash
composer require drupal/ebt_webform_popup
drush en ebt_webform_popup -y
drush cr
```

Pulls in `ebt_basic_button`, `ebt_core`, `paragraphs` and `webform`. There is **no settings route**
(`configure` is null) and **no `.install`** file — nothing blocks installation, and there are no
`hook_requirements`/`hook_uninstall` of its own. All behaviour is per-instance on the block edit
form. EBT Core's own install may require a Media "image" type (a family-wide requirement), but this
submodule adds none.

## The bundle

`config/install/block_content.type.ebt_webform_popup.yml` defines block content type
**`ebt_webform_popup`** ("EBT Webform Popup"), `revision: 0`. Create instances at
**Structure → Block layout → Custom block library → Add custom block → EBT Webform Popup**, then
place the block in a region or add it inside a **Layout Builder** section. Because it can render as
both a `block_content` block and an inline block, there are two templates (see
[settings.md](../config/settings.md)).

## Fields (installed config)

| Field | Type | Required | Notes |
|---|---|---|---|
| `field_ebt_webform_popup_form` | `webform` entity reference (`webform_entity_reference_select` widget) | **yes** | Cardinality 1. Handler `default:webform`, `target_bundles: null` (any Webform). The admin/editor picks which form the popup shows. |
| `field_ebt_settings` | `ebt_settings` (`ebt_settings_webform_popup` widget) | no | Button text, popup dimensions/title/type + the shared EBT button and design settings (see settings doc). |

The `ebt_settings` field type, its storage, and the `ebt_settings_default` view formatter all come
from **`ebt_core`**, not this module. The `field_ebt_webform_popup_form` storage
(`field.storage.block_content.field_ebt_webform_popup_form.yml`) is `type: webform`, provided by the
Webform module.

## Form display

`config/install/core.entity_form_display.block_content.ebt_webform_popup.default.yml`:
- `info` (the block description/label) as `string_textfield`, weight -5.
- `field_ebt_webform_popup_form` with the `webform_entity_reference_select` widget (weight 27,
  `default_data: true`).
- `field_ebt_settings` with the `ebt_settings_webform_popup` widget (weight 28).

## View display

`config/install/core.entity_view_display.block_content.ebt_webform_popup.default.yml` renders
`field_ebt_webform_popup_form` with `webform_entity_reference_entity_view` (`source_entity: true`)
and `field_ebt_settings` with `ebt_settings_default`, both label-hidden. The visible markup, however,
is produced by the module's **Twig templates**, which pull the fields out of `content`, drop
`field_ebt_settings` and `field_ebt_webform_popup_form` from the default render
(`content|without(...)`), and instead output a `use-ajax` trigger link built from the preprocessed
variables. See [settings.md](../config/settings.md).
