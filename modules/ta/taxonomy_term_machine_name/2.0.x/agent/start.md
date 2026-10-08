<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Term Machine Name — agent index

Adds a **machine-name field** to taxonomy terms for stable, code-friendly identifiers. Version **2.0.0**. Core `^9.2 || ^10`, PHP 8.0+.

Depends on core field + taxonomy. One admin route: `/admin/modules/uninstall/field/taxonomy_term_machine_name` (permission `administer modules`) to remove field data before uninstall. No public routes.
