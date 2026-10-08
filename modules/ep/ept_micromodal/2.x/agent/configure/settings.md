<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `ept_settings_micromodal` widget — modal options

`Drupal\ept_micromodal\Plugin\Field\FieldWidget\EptSettingsMicromodalWidget` (annotation id
`ept_settings_micromodal`, field type `ept_settings`). Extends ept_core's `EptSettingsDefaultWidget`,
so it inherits the whole EPT **Design options** panel (ID/anchor + additional classes, margin / border
/ padding boxes, border color/style/radius, background color, background media image/video + overlay,
edge-to-edge, container width, spacing) and adds the Micromodal controls on top. There is **no module
settings page** — all configuration is per-paragraph, on the paragraph edit form's **Settings** tab
(set as the `field_ept_settings` widget in the default form display).

The widget's `formElement()`
(`src/Plugin/Field/FieldWidget/EptSettingsMicromodalWidget.php:25`) first sets a hidden
`pass_options_to_javascript = TRUE`, then adds the fields below. Values are stored on the paragraph's
`field_ept_settings` under `ept_settings`, and (because `pass_options_to_javascript` is TRUE) ept_core
copies the whole `ept_settings` array to
`drupalSettings.eptMicromodal['paragraph-id-<id>'].options` at view time — see
[../theme/rendering.md](../theme/rendering.md).

## Options added by this widget

All keys live under `ept_settings`.

| `ept_settings` key | `#type` | Default | Meaning / where used |
|---|---|---|---|
| `pass_options_to_javascript` | hidden | `TRUE` | Signals ept_core to attach the `ept_settings` array to `drupalSettings`. |
| `button_text` | textfield | `Open` (translated) | Label of the trigger element. Printed in the template's trigger `<a>`/`<button>`. |
| `button_type` | select (`link`, `button`) | `link` | Chooses the trigger markup: `link` → `<a href="javascript:;">`, `button` → `<button>`. |
| `close_button_text` | textfield (**required**) | `Close` (translated) | Label of the footer close button (`<button class="modal__btn">`). |
| `disable_scroll` | checkbox | (unset / NULL) | Passed to `MicroModal.init({disableScroll})` — disables page scrolling while the modal is open. **The only key the JS reads.** |
| `display_close_icon` | checkbox | `TRUE` | When on (or undefined, for legacy paragraphs), the template renders the header "X" close button (`<button class="modal__close">`). |

## `massageFormValues()`

Only guarantees each delta has an `ept_settings` key: `$value += ['ept_settings' => []];`
(`EptSettingsMicromodalWidget.php:79`). No transformation or filtering happens here — the parent
class handles the design_options structure.

## Install update

`ept_micromodal_update_9001()` (`ept_micromodal.install`) loads every existing `ept_micromodal`
paragraph and sets `ept_settings['display_close_icon'] = TRUE`, so paragraphs created before that key
existed keep showing the close icon.

## Reading / writing in PHP

The value is a nested array under `field_ept_settings…ept_settings`. Example — a button trigger with
scroll locked and no header "X":

```php
$paragraph->field_ept_settings->ept_settings = [
  'pass_options_to_javascript' => TRUE,
  'button_text'        => 'Read the privacy policy',
  'button_type'        => 'button',
  'close_button_text'  => 'Close',
  'disable_scroll'     => 1,
  'display_close_icon' => 0,
  // 'design_options' => [...]  // inherited ept_core keys (margins/background/etc.)
];
$paragraph->save();
```

## Who can set these

Anyone with permission to edit the paragraph (i.e. edit the host content — a privileged authoring
task). `button_type` is a constrained select and `disable_scroll` / `display_close_icon` are
checkboxes; `button_text` and `close_button_text` are free text but are printed by Twig with normal
auto-escaping (no `|raw`). The inherited ept_core design values are rendered as an inline `<style>`
via ept_core's `GenerateCSS`, which `Html::escape()`s each value.
