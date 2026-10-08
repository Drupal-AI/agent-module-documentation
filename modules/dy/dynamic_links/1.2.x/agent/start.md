<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic links (dynamic_links) — agent index

Creates a config entity (`dynamic_link`) that owns a path and an ordered list of internal target paths. Visiting the path redirects to (or, in subrequest mode, renders) the first target the current user can access. Access to the path is delegated to the targets' own access, so a dynamic link never grants access its targets would deny.

- **Core / deps:** `^10.3 || ^11`, no non-core module dependencies, no libraries, no Composer requirements beyond core.
- **Config entity:** `dynamic_link` (config prefix `dynamic_links.link.*`; class `src/Entity/DynamicLink.php`; interface `src/DynamicLinkInterface.php`). Exported keys: `id`, `path`, `use_subrequest`, `redirects`, `routes`.
- **Permission:** `administer dynamic_link` (the entity's `admin_permission`; gates all UI/admin routes).
- **Admin UI:** collection `/admin/structure/dynamic-link` (route `entity.dynamic_link.collection`, the `configure` route), add/edit `/admin/structure/dynamic-link/add|/{dynamic_link}`, delete form; list builder `src/DynamicLinkListBuilder.php`; edit form `src/Form/DynamicLinkForm.php`.
- **Dynamic routes:** `src/Routing/DynamicLinkRoutes::routes()` (wired via `dynamic_links.routing.yml` `route_callbacks`) registers one route per *enabled* link at its `path`, named `dynamic_link.<id>`, `_controller` = `DynamicLinkController::redirect`, `_custom_access` = `DynamicLinkController::access`.
- **Controller:** `src/Controller/DynamicLinkController.php` — `redirect()` (RedirectResponse or SUB_REQUEST render), `access()` (allowed iff a target resolves for the account).
- **Events:** `DynamicLinkRoutesEvent`, `DynamicLinkRedirectsEvent` (base `DynamicLinkEventBase`) let modules alter candidate targets globally or per link. See `agent/api/events.md`.
- **No** hooks in a `.module` file, no Drush commands, no plugin types. Provides config schema (`config/schema/dynamic_links.schema.yml`).

## Solution docs
- `agent/config/settings.md` — the config entity, the edit form fields, storage modes (paths vs routes), subrequest, permissions, admin routes.
- `agent/routing/routes.md` — how routes are generated per link, the controller, access delegation, `getFirstAvailable()`, `getDynamicUrl()`.
- `agent/api/events.md` — the two events, `DynamicLinkEventBase`, event names, altering candidate targets.
