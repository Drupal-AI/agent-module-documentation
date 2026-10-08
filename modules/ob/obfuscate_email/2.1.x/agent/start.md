<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Obfuscate Email — agent index

Hides email addresses from spam bots: render them ROT13-scrambled (`@`→`/at/`, `.`→`/dot/`) on
the server, reassemble in the browser with vanilla JS (library `obfuscate_email/default`, attached
to every page). No settings page, no permissions, no Drush.

- **Text-format filter `obfuscate_email` (rewrites `mailto:` anchors) + its `click`/`click_label`
  settings** → [configure/filter.md](configure/filter.md)
- **The `field__email` theme hook / `field--email.html.twig` template, the `rot13` Twig filter,
  and the client-side reveal behaviour** → [theming/email-field.md](theming/email-field.md)

Key facts: filter id `obfuscate_email` (`TYPE_TRANSFORM_REVERSIBLE`, settings `click` +
`click_label`, config `filter.format.<id>` → `filters.obfuscate_email`). Theme hook `field__email`
targets any field literally named **`field_email`**. Obfuscation scheme: `str_rot13()` over the
address with `.`→`/dot/` and `@`→`/at/`; JS `Drupal.behaviors.obfuscateEmailField` reverses it.
No JavaScript fallback — no-JS clients never see the address.
