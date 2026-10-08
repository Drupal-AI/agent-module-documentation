<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `curated_color_picker` Form API element

`src/Element/CuratedColorPicker.php` — `#[FormElement('curated_color_picker')]`, a final class
**extending core `Select`**. Use it on any Drupal form (config forms, custom forms) to get the
swatch popover without the field system. Because it extends `Select`, standard `#title`,
`#description`, `#title_display`, `#required`, `#empty_option`, `#empty_value`, validation and
theming all apply.

## Element properties (`getInfo()`)

| Property | Type | Default | Meaning |
|---|---|---|---|
| `#palette_id` | string | `''` | Machine id of the palette to load. Empty ⇒ element renders as a plain select (no processing). |
| `#allowed_groups` | string[] | `[]` | Restrict to these group names; empty ⇒ all colors. Include `_ungrouped` (`CuratedColorItem::UNGROUPED_KEY`) to also allow colors in no group. |
| `#display_groups` | bool | `TRUE` | Render group sections in the popover. |
| `#show_label` | bool | `TRUE` | Show the selected color's label on the trigger. |
| `#labels` | array | `[]` | Override JS UI strings: `select`, `clear`, `noSelection`, `open`. |
| `#default_value` | string | — | Initially selected color key. |
| `#required` | bool | `FALSE` | Non-required elements get a prepended empty option so the value can be cleared. |

## Processing (`processPickerOverlay()`, a `#process` callback)

Runs after `Select`'s own callbacks:

1. Returns early if `#palette_id` is empty or the palette doesn't load.
2. Loads `$palette->getColors()`, filters by `#allowed_groups` (`filterColors()`), then keeps only
   **enabled** colors as offerable `#options`.
3. **Retains a disabled current value**: if the currently-selected key names a real (even disabled)
   color, it's re-injected into `#options` and offered in the overlay so an existing selection
   stays valid and doesn't trip Select's "illegal choice" validation. Once the value is saved away
   from it, it drops out on the next build.
4. For non-required elements, prepends an empty option (`#empty_option` or "- None -").
5. Sets `#options` (so core Select validation only accepts these keys), derives the ordered popover
   group list (`resolvePickerGroups()`, respecting the filter), assigns a unique wrapper id, adds
   class `curated-colors-picker-select`, and **attaches library `curated_colors/picker`** plus
   `drupalSettings.curatedColors.pickers[<wrapper>]` = `{paletteId, displayGroups, showLabel,
   colors, groups, labels}`.

The JS overlay (`js/curated-colors-picker.js`) enhances the select; without JS the plain
`<select>` still works.

## Example

```php
$form['accent'] = [
  '#type' => 'curated_color_picker',
  '#title' => $this->t('Accent color'),
  '#palette_id' => 'brand',
  '#allowed_groups' => ['Primary', 'Gradients'],   // or ['_ungrouped', ...]
  '#display_groups' => TRUE,
  '#show_label' => TRUE,
  '#default_value' => $config->get('accent') ?? '',
  '#empty_option' => $this->t('— None —'),
  '#required' => FALSE,
  '#labels' => [
    'select' => $this->t('Apply'),
    'clear' => $this->t('Remove'),
    'noSelection' => $this->t('No color selected'),
    'open' => $this->t('Choose a color'),
  ],
];
```

The submitted value is the color **key** string (or `''`). Resolve it against the palette yourself
(e.g. via the `curated_colors.palette_resolver` service — see
[resolver-event.md](resolver-event.md)) if you need its hex/label/CSS.
