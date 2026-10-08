<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extended Date/Time Format (edtf) — agent index

Adds an **`edtf` field type** that stores dates as an EDTF string (ISO 8601-2 / LoC datetime
standard): varying precision plus **uncertain, approximate, partial, seasonal and interval**
dates. Parsing/validation/humanizing is delegated to the **`professional-wiki/edtf` ^3** PHP
library (composer `require`; no external service, no HTTP). Package `Field types`. Core
`^9 || ^10 || ^11`, PHP `>=8.1`. License GPL-2.0-or-later. Version-dir 1.0.x (release 1.0.0-beta4).

- **The field type, widget, validation and storage** → [fields/field-type.md](fields/field-type.md)
- **The two display formatters (Plain, EDTF Humanizer)** → [fields/formatters.md](fields/formatters.md)
- **Tokens, Twig filters and the `Helper` service** → [api/tokens-twig.md](api/tokens-twig.md)

## What it actually is

- One **field type**: `EDTF` (id **`edtf`**, `category = "date_time"`,
  `default_widget = "edtf_widget"`, `default_formatter = "edtf_humanizer"`) in
  `src/Plugin/Field/FieldType/EDTF.php`. Single `char(255)` `value` column; no config schema, no
  config/install.
- One **widget**: `EDTFDefaultFieldWidget` (id **`edtf_widget`**) — a textfield that validates the
  entered string with the library parser and blocks invalid EDTF on save.
- Two **formatters**: `EDTFHumanizerFormatter` (id **`edtf_humanizer`**) and `EDTFPlainFormatter`
  (id **`edtf_plain`**).
- One **service**: `edtf.twig_extension` (`TwigEDTFExtension`) registering 6 Twig filters.
- A static helper `Drupal\edtf\Helper` wrapping the library parser/humanizer.
- Token integration in `edtf.tokens.inc` (`year`, `year_period`, `humanized` per edtf field).

## Provides / does not provide

- No routes, **no permissions**, no menu links, no Drush commands, no settings form (`configure` is
  null), no submodules.
- `edtf_install()` (`edtf.module`) sets module weight to 1 so its tokens win over the `tokens`
  module.
- Only requirement is the `professional-wiki/edtf` Composer library; **no Drupal module
  dependencies** (token/Twig usage is optional core integration).

## Install

```bash
composer require drupal/edtf   # pulls professional-wiki/edtf ^3
drush en edtf -y
```

Then add an "Extended Date/Time Format" field to any bundle and pick a widget/formatter on the
Manage form display / Manage display pages.
