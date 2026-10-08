<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Obfuscate — agent index

Hides email addresses from spam-bots via four delivery paths sharing two methods
(`html_entity`, `rot_13`). System-wide method at `/admin/config/obfuscate`
(`obfuscate.settings:obfuscate.method`, default `html_entity`). Depends on core `field` + `filter`.
Not encryption — an obfuscation aid.

- **The settings form, the method config, and the `administer obfuscate` permission** →
  [configure/settings.md](configure/settings.md)
- **The field formatter and the text filter (what they do, settings, plugin ids)** →
  [plugins/formatter-and-filter.md](plugins/formatter-and-filter.md)
- **The `obfuscate_mail` service, the Twig filter/function, and the two method classes for
  programmatic use** → [api/service-and-twig.md](api/service-and-twig.md)

Key facts:
- Config UI route `obfuscate.obfuscate_config_form` (`/admin/config/obfuscate`), perm
  `administer obfuscate`.
- Methods (`ObfuscateMailFactory`): `html_entity` → `ObfuscateMailHtmlEntity` (random HTML-entity
  encoding), `rot_13` → `ObfuscateMailROT13` (ROT13 + reversed-text, JS un-rotate via library
  `obfuscate/rot13`).
- Field formatter id `obfuscate_field_formatter` (field type `email`). Text filter id
  `obfuscate_mail` (`TYPE_TRANSFORM_IRREVERSIBLE`).
- Service `obfuscate_mail` (`ObfuscateMail`); Twig filter `|obfuscateMail`, function `obfuscate()`.
