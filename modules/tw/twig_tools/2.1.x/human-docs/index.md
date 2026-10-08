# Twig Tools — manual setup guide

**Twig Tools** (`twig_tools`) adds a set of extra Twig filters to Drupal's theme
layer so themers can sanitize class arrays, convert values, and convert colors
directly in templates — no preprocess hook required. If you have ever written a
small preprocess function just to clean up a list of CSS classes or reformat a
date for display, these filters let you keep that logic right next to the markup
that uses it.

There is nothing to configure: enabling the module registers all the filters
globally, and they become available in every Twig template site‑wide. The module
has no settings page, no routes, no permissions, and no dependencies beyond
Drupal itself.

The filters come in three groups. **Sanitize** cleans up CSS class arrays —
`clean_class_array` turns arbitrary strings into valid class names,
`remove_empty` drops falsy values, `array_unique` de‑duplicates, and
`scrub_class_array` does all three at once. **Convert** casts and transforms
values — `boolean`, `integer`, `float`, `string`, `md5`, `json_decode`,
`date_from_format` (reformat a date, with optional timezone conversion), and
`base64_encode` / `base64_decode`. **Color** converts between formats —
`rgb_to_hex`, `css_rgb_to_hex`, `hex_to_rgb`, and `hex_to_css_rgb`.

This guide is written for a **human** using the theme layer. If you want a terse,
token‑cheap filter reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs — the full filter table lives at
[`agent/theming/filters.md`](../agent/theming/filters.md).

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Twig Tools has no admin UI. Its filters live in the theme layer and are
used inside `.html.twig` template files.

## How to use it

Use each filter with the standard Twig `{{ value|filter_name }}` syntax. A few
examples:

```twig
{# Clean, de-dupe, and drop empties from a classes array #}
<div class="{{ ['Card', 'card--Blue', '', 'Card']|scrub_class_array|join(' ') }}">
{# => class="card card--blue" #}

{# Reformat a date string #}
{{ '2024-01-15'|date_from_format('Y-m-d', 'd/m/Y') }}   {# => 15/01/2024 #}

{# Decode JSON stored in a field #}
{% set data = node.field_json.value|json_decode(true) %}

{# Convert a hex color to a CSS rgb() string #}
{{ '#3366cc'|hex_to_css_rgb }}                          {# => rgb(51, 102, 204) #}
```

The filters return an empty result rather than throwing on invalid input (for
example `rgb_to_hex` with out‑of‑range values). For the complete list of filters,
their arguments, and more examples, see
[`agent/theming/filters.md`](../agent/theming/filters.md).
