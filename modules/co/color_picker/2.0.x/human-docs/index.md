# Color Picker — manual setup guide

**Color Picker** (`color_picker`) provides a single Form API element,
`#type => 'color_picker'` — a text input constrained to 6-digit hex colours, with an
attached JavaScript/CSS library that renders a row of selectable colour swatches. It's
a developer building block: a reusable colour-selection widget for your custom forms,
settings pages, block configuration, Layout Builder, or any other module that needs a
hex-colour input without shipping its own JavaScript.

There is no admin UI, no settings, no permissions, and no field type — the module
exists purely to give the Forms API a colour element you can drop into a render array.
You supply a comma-separated list of hex codes in `#color_values`, and the element
renders those as clickable swatches next to a pattern-validated text input (`#rrggbb`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — [`api/element.md`](../agent/api/element.md)
documents every element property.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — Color Picker has no admin page and nothing to configure. It only becomes
useful when a form uses the `color_picker` element.

## How to use it

Use it like any Form API element in a custom form or render array:

```php
$form['colour'] = [
  '#type' => 'color_picker',
  '#title' => $this->t('Colour'),
  '#color_values' => '#000000,#ffffff,#ff0000', // comma-separated hex swatches
  '#default_value' => '#000000',
  '#required' => TRUE,
];
```

- **`#color_values`** — a comma-separated list of hex codes rendered as selectable
  swatches. Use it to offer a curated palette (for example brand colours) rather than
  free-form entry.
- The input enforces a 6-hex-digit pattern (`#rrggbb`) on the client side. Because
  that's only a client-side hint, **validate the value server-side too** if you rely
  on the format.
- The submitted value is the plain `#rrggbb` string — treat it as a normal text input.

Common uses: a "pick an accent colour" option in theme or block settings, a curated
palette for editors, a highlight-colour control on a call-to-action block, or a colour
input in a multistep or entity form.
