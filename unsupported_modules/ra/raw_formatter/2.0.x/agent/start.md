<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Raw formatter (raw_formatter) — agent index

Version **2.0.x** (release 2.0.2). Provides one field formatter, "Raw Value" (plugin id `raw`),
registered **only for the `metatag` field type**. It `json_decode`s the field value, runs
`token->replace()` per value, strips tags with a regex, `json_encode`s the map, and prints it
**unescaped** via the `raw_formatter` theme hook (`{{ raw_value|raw }}`). Meant to expose raw
values in Services / REST Export views. No settings form, no config UI, no permissions, no Drush.

**Operate it:** enable the module (deps: `field`, `metatag`), then on a Metatag field's
"Manage display" pick the **Raw Value** format. No further configuration.

**Caution (by design):** output is emitted with `|raw`, so the field value is rendered
unescaped, and the regex tag-strip is not a robust sanitizer. Only apply this formatter to
Metatag fields whose value is set by trusted editors. Not a defect — it is the module's stated
"raw value" purpose, gated by the site builder choosing this formatter.

- Theme/template override (the `raw_formatter` theme hook): [theming/raw_formatter.md](theming/raw_formatter.md)
