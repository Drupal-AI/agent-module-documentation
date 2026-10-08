<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# E-mail Formatter (email_formatter) — agent index

A single field formatter for **core's Email field** that renders the address as an optional
`mailto:` link with truncation, an escaped text prefix, an admin-HTML prefix, and one of nine
hard-coded Font Awesome icons (optionally itself a `mailto:` link). Package **`Fields`**. Depends
only on core **`field`**. Core requirement `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
Version dir **2.0.x** (installed `2.0.0-rc3`).

- **The formatter, all six settings, config schema, how to enable it, and caveats** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `EmailFormatter` (id **`email_formatter`**, label *"E-mail formatter (with
  options)"*), `src/Plugin/Field/FieldFormatter/EmailFormatter.php`, extending core
  `FormatterBase`. `field_types = { "email" }` — targets **core Email fields only**.
- **No** routes, permissions, services, hooks beyond `hook_help` / `hook_install`, Drush, submodules,
  libraries, or site-wide config. Selected and configured per view-display on *Manage display*.
- Provides config schema for the formatter settings:
  `config/schema/email_formatter.schema.yml`
  (`field.formatter.settings.[email_formatter]`).

## Mechanism (from source)

- `viewElements()` loops the field items, reads `$item->getValue()['value']` (the address), and
  assembles a `#markup` string: optional `fas fa-<icon> fa-fw` icon (optionally a `Link` to
  `mailto:<address>`), then the address text (optionally truncated + `&hellip;`, optionally a
  `mailto:` `Link`), prefixed by escaped `text` and admin-filtered `HTML`.
- `settingsForm()` renders the six settings; `settingsSummary()` builds the one-line summary;
  `defaultSettings()` and the legacy `hook_field_formatter_info()` in `.module` both declare
  defaults.

## Settings (`defaultSettings()`)

`mailto` (TRUE), `truncate` (40), `text` (''), `HTML` (''), `icon` (`none`), `iconlink` (TRUE).
Keys, behavior, the truncation quirk, the broken Custom-HTML option, and a config-export example
are in [fields/formatter.md](fields/formatter.md).

## Requirements note

The icon option only shows a glyph if a Font Awesome library/module supplies the `fas fa-*` CSS
(README recommends `drupal/fontawesome` 8.x-2.x+). The module itself declares no library.
