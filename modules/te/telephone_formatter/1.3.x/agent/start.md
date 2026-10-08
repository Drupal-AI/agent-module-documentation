<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# telephone_formatter — agent start

Adds one field formatter, `telephone_formatter` (label "Formatted telephone"), for core
`telephone` fields. It parses the stored number with Google's libphonenumber and re-emits it
in International / E164 / National / RFC3966 format, optionally wrapped in a `tel:` link.
Depends on core `telephone` + the `giggsey/libphonenumber-for-php` library. Configured per
field on **Manage display** — there is no admin settings page (`configure` is null). Invalid
numbers fall back to the raw value.

- Apply the formatter + its `format` / `link` / `default_country` settings → [configure/telephone_formatter.md](configure/telephone_formatter.md)
- The formatter plugin + the reusable `telephone_formatter.formatter` service → [plugins/telephone_formatter.md](plugins/telephone_formatter.md)
