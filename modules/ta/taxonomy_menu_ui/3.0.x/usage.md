<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Menu UI gives taxonomy terms the same "Menu settings" experience nodes already have: pick allowed menus per vocabulary, then tick "Provide a menu link" on a term form to create a real `menu_link_content` link pointing at that term.

---

The module is a pure form-alter layer over core's `menu_ui` — it defines no entities, services, plugins, permissions or Drush commands, and has no `configure` route. `taxonomy_menu_ui_form_taxonomy_vocabulary_form_alter()` adds a **Menu settings** group to the vocabulary form with an "Available menus" checkboxes element and a "Default parent item" select; an entity builder writes both into the vocabulary's **third-party settings under the `menu_ui` provider** — `available_menus` (a sequence of menu ids, defaulting to `['main']`) and `parent` (a `menu_name:plugin_id` string, defaulting to `'main:'`). That storage is declared in `config/schema/taxonomy_menu_ui.schema.yml` as `taxonomy.vocabulary.*.third_party.menu_ui`, deliberately reusing core's key so the shape matches node types. `taxonomy_menu_ui_form_taxonomy_term_form_alter()` then adds the familiar Menu settings details element (enabled checkbox, menu link title, description, parent item, weight) to every term form, restricted to the vocabulary's allowed menus and gated on the `administer menu` permission — with an extra branch that also grants access when `menu_admin_per_menu` is installed and the user administers one of those menus. On submit, `_menu_ui_taxonomy_term_save()` creates or updates a `menu_link_content` entity whose link URI is `internal:/taxonomy/term/<tid>`; unticking the checkbox deletes that link. Existing links are discovered by querying `menu_link_content` for that URI within the vocabulary's allowed menus, giving priority to the default menu. `hook_entity_extra_field_info()` exposes the "Menu settings" group as a form extra field per vocabulary so it can be reordered on *Manage form display*, and `taxonomy_menu_ui.tokens.inc` registers a chained `[term:menu-link:*]` token. `hook_uninstall()` clears `content.menu` from every `core.entity_form_display.taxonomy_term.*.default`, and `hook_ENTITY_TYPE_translation_delete()` strips the matching menu-link translation when a term translation is removed.

---

- Put every term of a "Departments" vocabulary into the main navigation without hand-building links.
- Let editors add a category term to the footer menu straight from the term add form.
- Restrict a vocabulary so its terms may only be placed in a dedicated "Product categories" menu.
- Set a default parent item so all new terms in a vocabulary nest under one navigation section.
- Allow a term to be placed in more than one menu by ticking several "Available menus".
- Reorder sibling term links with the Weight field on the term form.
- Give a term's menu link a hover description separate from the term description.
- Use a menu link title that differs from the term name (e.g. shorter for navigation).
- Remove a term from the menu by unticking "Provide a menu link" — the link entity is deleted.
- Build a taxonomy-driven main menu that stays in sync as editors add terms.
- Move a term's link to a different parent without touching `/admin/structure/menu`.
- Delegate menu placement for one vocabulary to editors via `menu_admin_per_menu` instead of `administer menu`.
- Reposition the "Menu settings" group on the term form using Manage form display.
- Hide the Menu settings group for roles that lack the `administer menu` permission.
- Migrate a hand-maintained category menu to term-driven links pointing at `/taxonomy/term/<tid>`.
- Print a term's menu-link title in a Twig template or mail via the `[term:menu-link:title]` token.
- Reference a term's menu-link URL in a pattern with the chained `[term:menu-link:url]` token.
- Keep term links translated: adding a term translation adds a menu-link translation in the same langcode.
- Clean up menu links automatically when a term translation is deleted.
- Store per-vocabulary menu policy in exported config (`third_party_settings.menu_ui.available_menus`).
- Deploy a vocabulary's menu policy between environments as ordinary config.
- Combine with `menu_item_extras` so term links get the menu's own bundle and fields.
- Give a glossary vocabulary a sidebar menu of its letters/sections.
- Expose a small taxonomy as a top-level site section menu for a landing-page site.
- Audit which terms have menu links by querying `menu_link_content` for `internal:/taxonomy/term/` URIs.
