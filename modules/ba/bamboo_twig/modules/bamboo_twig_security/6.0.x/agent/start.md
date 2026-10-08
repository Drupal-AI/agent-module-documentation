<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bamboo Twig - Security — agent index

Twig functions to check whether the current (or a given) user has a **permission** or **role**,
singly or as an AND/OR collection. Submodule of **bamboo_twig**; read-only checks, no config.

- **The four functions, conjunctions, and anonymous behaviour** → [theming/security.md](theming/security.md)

`bamboo_has_permission`, `bamboo_has_permissions`, `bamboo_has_role`, `bamboo_has_roles`.
Service `bamboo_twig_security.twig.security` (args `@current_user`, `@entity_type.manager`).
Enable: `drush en bamboo_twig_security -y`.
