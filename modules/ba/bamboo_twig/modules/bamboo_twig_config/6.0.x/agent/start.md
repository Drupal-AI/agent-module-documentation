<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bamboo Twig - Config — agent index

Twig functions to read Drupal **Config API**, **settings.php** and **State API** values from a
template. Submodule of **bamboo_twig**; no config UI, no permissions, no Drush.

- **The three getters, signatures and examples** → [theming/config.md](theming/config.md)

Functions: `bamboo_config_get(name, key)`, `bamboo_settings_get(key)`, `bamboo_state_get(key)`.
Service `bamboo_twig_config.twig.config`. Enable: `drush en bamboo_twig_config -y`.
