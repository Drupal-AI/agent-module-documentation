<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Addons (views_addons) — agent index

Two Views handlers, nothing more. Depends only on core `views`. No permissions, no routes, no
services, no config schema directory, no submodules. Version **1.3.0**, core `^9 || ^10 || ^11`,
license GPL-2.0-or-later. Everything is registered by `hook_views_data_alter()` in
`views_addons.views.inc` and configured inside the Views UI.

## What it actually adds
1. **Advanced Custom Text** — a Views *field* handler.
   - Views id: `views field: views_addons_custom_advanced`; class
     `src/Plugin/views/field/CustomAdvanced.php`, extends core
     `Drupal\views\Plugin\views\field\Custom`.
   - Purpose: render custom markup like the core Custom Text field, but keep extra HTML tags
     that core strips. Core's Custom field filters output with `Xss::filterAdmin()`;
     `CustomAdvanced` overrides `viewsTokenReplace()` to use `strip_tags()` against
     `Xss::getAdminTagList()` + an admin-set "additional allowed tags" field (default
     `svg g circle text`). Twig token replacement is preserved via an `inline_template` build
     with a `#post_render` strip_tags callback.
   - Query is a no-op (`query()` overridden empty) — it is a purely presentational global field.
2. **Add Entity Link** — a Views *area* handler.
   - Views id: `views area: views_addons_add_entity`; class
     `src/Plugin/views/area/AddCoreEntity.php`, extends `AreaPluginBase`.
   - Purpose: render an access-checked link to an add form. Options: `entity_type`
     (node/user/taxonomy_term), `bundle` (node type), `vocabulary`, `link_text`, `css_classes`.
   - Routes: `node.add`, `entity.user.add_form`, `entity.taxonomy_term.add_form`. Visibility is
     gated on the entity's `createAccess(..., TRUE)` result assigned to `#access`; sets
     `user.permissions` cache context and config/entity-type cache tags.

## What it does NOT provide
No style plugin, no filter/sort/argument handlers, no query enhancement, no permissions, no Drush
commands, no config form (despite the module's terse description). The old stub's "Views query
enhancements" / "Views style plugins" labels were wrong — corrected in `data.json`.

## Deeper notes
- `plugins/handlers.md` — mechanism detail for both handlers and how they differ from core.

## Standing advice
- The Advanced Custom Text field intentionally weakens core's output sanitization. Only expose the
  "administer views" permission to fully trusted roles when this field is in use (see the general
  Drupal guidance on delegating Views administration).
- A view that uses either handler is bound to this module: removing views_addons leaves those
  views with broken handlers.
