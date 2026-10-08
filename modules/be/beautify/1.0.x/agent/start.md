<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Beautify (beautify) — agent index
**Reformats Drupal's rendered HTML via a pluggable beautifier (HTMLBeautify or PHP Tidy) on the response.**

- **Version:** 1.0.x
- **Core:** ^8.8 || ^9 || ^10
- **Route:** `beautify.settings_form` → `/admin/config/development/beautifier` (permission `admninister beautifiers`, note the upstream typo)
- **Plugin type:** `Beautifier` (annotation) with manager `BeautifierManager`; bundled plugins `HtmlBeautify`, `Tidy`.
- **Subscriber:** `BeautifyResponseFilter` on `KernelEvents::RESPONSE` rewrites HTML output.
- **Security:** Settings route is permission-gated; no anonymous or mutating endpoints; reformatting affects whitespace only. Tidy plugin needs the PHP Tidy extension.

See [plugins/beautifiers.md](plugins/beautifiers.md)
