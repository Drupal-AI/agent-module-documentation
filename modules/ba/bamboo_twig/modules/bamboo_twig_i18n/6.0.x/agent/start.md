<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bamboo Twig - Internationalization — agent index

Twig helpers for multilingual sites: current language code, i18n-aware date formatting, and getting
the right entity translation. Submodule of **bamboo_twig**.

- **The function + two filters, signatures and examples** → [theming/i18n.md](theming/i18n.md)

`bamboo_i18n_current_lang()` · `date | bamboo_i18n_format_date(...)` · `entity | bamboo_i18n_get_translation(langcode)`.
Service `bamboo_twig_i18n.twig.i18n`. Enable: `drush en bamboo_twig_i18n -y`.
