<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Personalized Content Dashboard — agent index

info.yml name: **Personalized Content Dashboard** (`content_dashboard`), version **1.0.3**, core `^9 || ^10 || ^11`, package Other. No dependencies.

A role-personalized **navigation** dashboard: one page of links to core admin listings, grouped into Content, Media and Configuration sections. It renders **no node data, no counts and no charts** — each item is a link to an existing core admin route, shown only when the current user passes the relevant permission/access check.

## Route & access
- Route `content_dashboard.dashboard` → `/admin/content-dashboard`, `_controller: DashboardController::content`, requirement `_permission: 'access content dashboard'`.
- Permission `access content dashboard` (`content_dashboard.permissions.yml`, `restrict access: FALSE`) is the only permission the module defines.

## What the controller builds (`src/Controller/DashboardController.php`)
- `menuOfTypeNodes()` — loads all `node_type` entities, sorts by label, and includes a type **only if** the node access handler `createAccess($type)` passes. Each item links to `view.content.page_1?type=<type>` (core Content view filtered by type). Description = the node type's own description.
- `menuOfMedias()` — returns empty unless the `media` module is enabled **and** the user has `access media overview`; then lists **all** media types (no per-type check), each linking to `entity.media.collection?type=<machine>` plus an `add_url`.
- `menuOfOthers()` — appends links guarded individually: Users (`access user profiles`), Forms (`webform` enabled + `access webform overview`), Taxonomies (`taxonomy` enabled + `access taxonomy overview`), Basic site settings (`administer site configuration`).
- `#roles_defined` = `count(currentUser->getRoles()) > 1`; when false the template shows a "You do not have access to this page" notice with a login link instead of the sections.

## Module hooks (`content_dashboard.module`)
- `hook_toolbar()` — adds a "My Dashboard" toolbar tab linking to the route, for users with `access content dashboard`.
- `hook_preprocess_menu_local_action()` — on `system.admin_content` / `entity.media.collection`, relabels the "Add content/media" action to the type in the `?type=` query. Gated by permission **`access editor dashboard`** — a permission the module never defines, so this only fires for the root/admin superuser.
- `hook_form_user_login_form_alter()` + submit — redirects login to the dashboard for users with permission **`access admin dashboard`** — also undefined, so effectively superuser-only.

## Theming
- `hook_theme()` `content_dashboard` → `templates/dashboard.html.twig`; library `content_dashboard/dashboard` attaches `assets/css/dashboard.css`. Titles are auto-escaped; item **descriptions are printed with `|raw`** (see note below).

## Notes for agents
- README/composer call the project "libeo/dashboard" and mention a settings page at *Structure → Personalized Dashboard*; **no such config form or menu link exists in the code** — the only entry point is the toolbar tab and `/admin/content-dashboard`. Treat the README's config section as aspirational.
- Item descriptions use Twig `|raw`; the only non-static source is the node type description (set by `administer content types`).

See [../usage.md](../usage.md) and [../human-docs/index.md](../human-docs/index.md).
