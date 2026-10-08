<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig Extensions — agent index

Registers four `twig.extension` services adding seven Twig filters. No config, routes,
permissions, or Drush. Just enable and use the filters in templates.

- **Every filter: signature, arguments, return, requirements** → [api/filters.md](api/filters.md)

Key facts:
- Services (`twig_extensions.services.yml`): `ArrayExtension` (`shuffle`), `DateExtension`
  (`time_diff`, needs `string_translation` + `datetime.time`), `IntlExtension` (`localizeddate`,
  `localizednumber`, `localizedcurrency`), `TextExtension` (`truncate`, `wordwrap`).
- Intl filters require the PHP `intl` extension (throw `RuntimeException` otherwise).
- Filters return plain strings/values and do **not** mark output safe — normal Twig
  autoescaping applies (no raw/`|raw` behavior, no code evaluation).
