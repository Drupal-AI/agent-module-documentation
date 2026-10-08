<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — raw_formatter

The module declares one theme hook in `raw_formatter_theme()`:

- Hook: `raw_formatter`
- Template: `raw-formatter.html.twig`
- Variable: `raw_value` — the JSON-encoded, token-replaced, tag-stripped field value (a string).

Default template body is a single line:

```twig
{{ raw_value|raw }}
```

`|raw` disables auto-escaping, so `raw_value` is printed as-is (the "raw value" behavior).

## Override it

Copy `raw-formatter.html.twig` into your theme's `templates/` directory and adjust. To make
output escaped/safe, drop the `|raw` filter (`{{ raw_value }}`) so Twig auto-escapes the value.
The variable is always a `json_encode()`d string, so escaped output shows the JSON as text.

There is no formatter settings form and no config schema; behavior is fixed in
`RawValueFormatter::viewElements()`, so template override is the only supported customization
point.
