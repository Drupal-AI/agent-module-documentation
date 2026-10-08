<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `ept_settings_timeline` widget — per-paragraph settings

`Drupal\ept_timeline\Plugin\Field\FieldWidget\EptSettingsTimelineWidget` (annotation id
`ept_settings_timeline`, field type `ept_settings`). Extends ept_core's `EptSettingsDefaultWidget`,
so it inherits the whole EPT **Design options** panel (ID/anchor, margin/border/padding boxes, border
color/style/radius, background color, background media image/video + overlay, edge-to-edge, container
width, spacing). There is **no module settings page** — all configuration is per-paragraph, on the
paragraph edit form's **Settings** tab (set as the `field_ept_settings` widget in the default form
display; see [../fields/paragraph-types.md](../fields/paragraph-types.md)).

Unlike its siblings (e.g. `ept_slideshow`'s dozens of Flexslider options), this widget adds almost
nothing of its own — the timeline layout is fixed CSS, not JS-driven.

## What `formElement()` adds

`formElement()` (`src/Plugin/Field/FieldWidget/EptSettingsTimelineWidget.php:25`) calls
`parent::formElement()` then adds exactly two elements:

| `ept_settings` key | `#type` | Value / options | Notes |
|---|---|---|---|
| `pass_options_to_javascript` | `hidden` | `#value => TRUE` | Signals ept_core to copy the `ept_settings` array to `drupalSettings` at view time (see [../theme/rendering.md](../theme/rendering.md)). The timeline JS side is not actually used, but the flag is set for family consistency. |
| `styles` | `radios` | single option `simple_vertical` → "Simple vertical"; `#default_value` `simple_vertical`; **`#disabled => TRUE`** | Predefined layout style. There is only one style, and the control is disabled, so this is effectively a constant. The wrapper template reads it to build the `ept-timeline-<styles>` class and to `attach_library` the matching CSS. |

Because `styles` is a disabled single-option radios, an editor cannot change it through the form; the
stored value is always `simple_vertical`.

## `massageFormValues()`

Only guarantees each delta has an `ept_settings` key: `$value += ['ept_settings' => []];`
(`EptSettingsTimelineWidget.php:50`). No transformation or filtering happens here.

## Reading / writing in PHP

The value is a nested array under `field_ept_settings…ept_settings`:

```php
$paragraph->field_ept_settings->ept_settings = [
  'pass_options_to_javascript' => TRUE,
  'styles' => 'simple_vertical',
  // 'design_options' => [...]  // inherited ept_core keys (margins/background/etc.)
];
$paragraph->save();
```

## Who can set these

Anyone with permission to edit the paragraph (i.e. edit the host content — a privileged authoring
task). The only widget-specific control is the disabled `styles` radios (constrained input). The
inherited ept_core design values are rendered as an inline `<style>` via ept_core's `GenerateCSS`,
which `Html::escape()`s each value before emitting it — no request data reaches that block.
