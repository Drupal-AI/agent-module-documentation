<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Print area block (`print_area`)

Placeable block that renders a Print button/link targeting a CSS selector on the page.

- Plugin id: `print_area`
- Class: `Drupal\area_print\Plugin\Block\PrintArea` (extends `BlockBase`)
- Admin label: "Print area"; category: "System"
- Place it like any block (needs core **Block** module; requires the *Administer blocks* permission).

## Configuration form

The block config form (`buildConfigurationForm`) exposes:

| Field | Setting key | Type | Notes |
|-------|-------------|------|-------|
| Button text | `label` | textfield (core block label) | Label field re-titled "Button text"; `label_display` is hidden. |
| Type | `type` | radios `link` / `button` | Default `link`. |
| Target css selector | `css_selector` | textfield | Placeholder `main#main`; the element whose contents get printed. |

`defaultConfiguration()` → `['css_selector' => 'main', 'type' => 'link']`.
`blockSubmit()` copies all submitted values straight into `$this->configuration`.

## What it renders

`build()` returns the render element:

```php
return [
  '#type' => 'print_area_button',
  '#value' => \Drupal::token()->replace($this->configuration['label']),
  '#css_selector' => $this->configuration['css_selector'],
  '#as_link' => $this->configuration['type'] == 'button' ? FALSE : TRUE,
];
```

Note: `build()` sets `#value`, but the render element's `preRender` outputs `#label` (see
[api/render-element.md](../api/render-element.md)). Because `#label` is not passed, the button
currently shows the default text `Print` regardless of the "Button text" setting. The label is
token-replaced before being assigned to the (unused) `#value`.

## Config schema

`block.settings.print_area` (in `config/schema/area_print.schema.yml`) adds:

- `css_selector` — string, "Css Selector"
- `type` — string, "Render as button or link"

(Plus the standard `block_settings` keys, including `label`, inherited from the base type.)

## Update hook

`area_print_update_10000()` (in `area_print.install`) migrates blocks stored under the old
`css_id` setting to the new selector form: `css_selector = '#' . css_id`. Run via `drush updatedb`.
