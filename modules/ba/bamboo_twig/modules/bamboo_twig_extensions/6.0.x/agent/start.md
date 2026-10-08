<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bamboo Twig - Extensions — agent index

Ports three **Twig-Extensions** filters into Drupal, prefixed `bamboo_extensions_`:
`bamboo_extensions_truncate` (Text), `bamboo_extensions_time_diff` (Date), and
`bamboo_extensions_shuffle` (Array). Submodule of **bamboo_twig**.

- **The three filters, signatures and examples** → [theming/extensions.md](theming/extensions.md)

Services: `bamboo_twig_extensions.twig.{text,date,array}`. Enable: `drush en bamboo_twig_extensions -y`.
