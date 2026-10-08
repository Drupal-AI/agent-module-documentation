<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic Breadcrumb (dynamic_breadcrumb) — agent index
**Rewrites the labels of core-generated breadcrumb items for node, taxonomy term, media and user entities, using an admin-defined, token-driven value chosen per entity type and bundle.**

- **Version:** 2.1.x (release 2.1.0)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Dependencies:** `token`.
- **Mechanism:** `dynamic_breadcrumb_system_breadcrumb_alter()` (`hook_system_breadcrumb_alter`). It does NOT build a breadcrumb; it edits the text of links in core's finished breadcrumb. No BreadcrumbBuilder service, no plugins, no services.yml.
- **Handled routes:** `entity.node.canonical`, `entity.taxonomy_term.canonical`, `entity.media.canonical`, `entity.user.canonical`. For each breadcrumb link on one of those routes, if the bundle's checkbox is on, the value pattern is token-replaced against the linked entity and set as the link text (falls back to the entity label when empty).
- **Config objects:** `dynamic_breadcrumb.entity_types_config` (which entity types are managed) and `dynamic_breadcrumb.settings` (per entity type + bundle: `checkbox` on/off, `value` token pattern). Note token type key uses `term` for taxonomy_term. No config schema shipped.
- **Routes/UI:** menu hub `dynamic_breadcrumb.admin` → `/admin/config/user-interface/dynamic-breadcrumb`; Entity Types form and Breadcrumbs settings form beneath it. All require `administer site configuration` (no custom permissions).
- **Install guard:** `hook_requirements()` blocks install if Easy Breadcrumb >= 2.0.7 is enabled (features merged upstream).

See [configure/settings.md](configure/settings.md)
