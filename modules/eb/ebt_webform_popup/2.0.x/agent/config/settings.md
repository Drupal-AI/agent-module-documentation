<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Popup settings widget, preprocess & rendering

There is no site-wide config object for this block. Every option is stored per instance in the
`field_ebt_settings` value and edited through the widget below. Global EBT defaults (button colors,
breakpoints) come from `ebt_core.settings`.

## Widget `ebt_settings_webform_popup`

`src/Plugin/Field/FieldWidget/EbtSettingsWebformPopupWidget.php` (id `ebt_settings_webform_popup`,
field type `ebt_settings`) **extends** `EbtSettingsBasicButtonWidget` from `ebt_basic_button` (which
itself extends `ebt_core`'s `EbtSettingsDefaultWidget`), so it inherits the full button + design
options form. In `formElement()` it removes the `add_nofollow` and `open_in_new_tab` link toggles,
forces `pass_options_to_javascript` = TRUE (hidden), and adds:

| Setting key | Element | Default | Effect |
|---|---|---|---|
| `button_text` | textfield | `Contact Us` | **Required.** Label rendered inside the trigger link (weight -10). |
| `popup_settings.popup_width` | number | `400` | **Required.** Dialog width (px stripped before use). |
| `popup_settings.form_height` | number | *(empty)* | Optional; empty = height `auto`. *(Note: preprocess actually reads `popup_settings.popup_height` for the dialog height, so this widget field does not currently drive the dialog height.)* |
| `popup_settings.popup_title` | textfield | *(empty)* | Optional dialog title; empty = use the Webform's name. |
| `popup_settings.popup_type` | radios | `modal` | `modal` (blocks page) or `dialog` (non-blocking) → `data-dialog-type`. |
| `popup_settings.popup_styles` | radios | `default` | Single option `default` (styling hook, no effect yet). |

`design_options` is reweighted to -12 and a "Button Styles:" heading is inserted. `massageFormValues()`
defaults each row's `ebt_settings` to `[]` and flattens the inherited `link_options` sub-array up onto
`ebt_settings` (so `alignment`, `shape`, `size`, `custom_class_name`, colors, etc. live at the top
level for the trigger button).

## Preprocess — `EbtWebformPopupHooks::preprocessBlock()`

`src/Hook/EbtWebformPopupHooks.php` (`#[Hook('preprocess_block')]`, invoked via the `LegacyHook`
shim in `ebt_webform_popup.module`). Runs only for blocks whose `#block_content` bundle is
`ebt_webform_popup`. It:

1. Attaches `webform/webform.ajax` (`$variables['#attached']['library'][]`) — required so the
   `use-ajax` link opens the form dialog (see drupal.org/node/3456067).
2. Sets `$variables['form_url']` = the referenced Webform's `->toUrl()` (from
   `field_ebt_webform_popup_form[0]['#webform']`).
3. Computes `$block_class` — `block-revision-id-<id>` for inline blocks, else
   `ebt-block-<plugin_id>` (sanitized).
4. `$variables['button_styles']` ← `ebt_basic_button.generate_custom_css`
   `->generateFromSettings($ebt_settings[0]['ebt_settings'], $block_class)` — a `<style>` string for
   the button color/background/hover.
5. Builds `$data_dialog_options` (`width` from `popup_width` with `px` stripped; `height` = `auto`
   or `popup_height`; a fixed `classes.ui-dialog = ui-dialog-webform-popup`; `title` from
   `popup_title` if set), JSON-encodes it into `$variables['data_dialog_options']`.
6. Sets `$variables['data_dialog_type']` from `popup_type` (default `modal`) and
   `$variables['button_text']` from `button_text` (default `Contact Us`).

Note: the separate site-wide `styles` variable (the EBT design-box CSS) is set by **`ebt_core`**'s
own `hook_preprocess_block` via `ebt_core.generate_css`, not by this module.

## Templates

`templates/block--block-content--ebt-webform-popup.html.twig` and
`…block--inline-block--ebt-webform-popup.html.twig` are near-identical (the inline one adds a
`block-revision-id-…` class). They build the wrapper class list from the `ebt_settings` alignment /
shape / size / stretched flags, read `custom_class_name` into `button_custom_classes`, attach
`ebt_basic_button/ebt_basic_button_view`, and render:

```twig
<a href="{{ form_url }}"
   class="use-ajax ebt-basic-button ebt-webform-popup {{ button_custom_classes }}"
   data-dialog-type="{{ data_dialog_type }}"
   data-dialog-options="{{ data_dialog_options }}">
  {{ button_text }}
</a>
{{ content|without('field_ebt_settings', 'field_ebt_webform_popup_form') }}
```

`button_text`, `form_url`, `data_dialog_type`, `data_dialog_options` and `button_custom_classes` are
printed through Twig auto-escaping. The templates end with `{{ styles|raw }}` and
`{{ button_styles|raw }}` (the two generated `<style>` strings). The Webform itself is loaded by
core's AJAX dialog from `form_url` when the button is clicked.

## Operate it

Nothing to configure globally. To change appearance or behaviour, edit a Webform Popup block and use
the **Settings** field: pick the Webform, set button text, popup width/title, and Modal vs Dialog.
Button colors/shape/size come from the inherited EBT Basic Button controls; the design box
(margins/padding/border/background) from EBT Core's shared design options.
