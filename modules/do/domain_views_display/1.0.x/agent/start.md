<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Views Display (domain_views_display) — agent index

Makes a Views display **domain-aware**: a display can hand off to a *different display of the
same view* on specific domains of a **Domain** (Domain Access) multi-site. Package `Domain`.
Depends on core **`views`** and contrib **`domain`** (`>= 2.0`; composer `drupal/domain: ^2 || ^3`).
Core requirement `^10.3 || ^11`. License GPL-2.0-or-later. Version dir `1.0.x` (release
`1.0.0-alpha2`). Not covered by a security advisory policy.

- **The display-extender plugin, the runtime override mechanism, config, and how to configure a
  view** → [plugins/display-extender.md](plugins/display-extender.md)

## What it actually is

- **One Views plugin** — a **display extender** (not an access plugin, not a filter, not a query
  handler): `DomainViewsDisplayExtender`, id **`domain_views_display_display_extender`**, in
  `src/Plugin/views/display_extender/DomainViewsDisplayExtender.php`. It adds an
  `override_displays` option: a map of **domain id → display id** edited under a **"Domain
  overrides"** section (link *Override display*) in the Views UI.
- **A helper class** `Drupal\domain_views_display\DomainViewsDisplay` (`src/DomainViewsDisplay.php`,
  `ContainerInjectionInterface` + `TrustedCallbackInterface`, autowired via the class resolver, not
  a named service) that computes and applies the active override.
- **A route subscriber** `Routing\RouteSubscriber` (the only entry in
  `domain_views_display.services.yml`) that rewrites the affected `view.<id>.<display>` page routes
  to a **`Routing\ControllerDecorator`** wrapping core `ViewPageController`.
- **Hooks** in `domain_views_display.module`: `hook_module_implements_alter`,
  `hook_element_info_alter`, `hook_views_pre_view`.
- **Install/uninstall** (`src/Install.php` via `.install`): adds/removes the extender id to the
  `views.settings` `display_extenders` list.

## Mechanism (from source)

- `DomainViewsDisplay::getActiveOverride()` reads `override_displays` from the display's extender
  options, looks up `$this->domainNegotiator->getActiveId()` (Domain module), and returns the
  mapped display id **only if** it exists, differs from the current display, and the visitor passes
  `$view->access($override)` — otherwise `NULL` (falls back to the current display). It adds the
  **`url.site`** cache context whenever overrides exist.
- Page routes: `RouteSubscriber::alterRoutes()` swaps `_controller`/`_title_callback` from
  `ViewPageController::handle`/`getTitle` to `ControllerDecorator::handle`/`getTitle`, which resolve
  the override before delegating to the core controller and attach cacheability to the response.
- Embedded/pre-rendered views: `hook_views_pre_view` → `ensureDisplay()` and a pre-render
  (`preRender()`, inserted at the front of `view` `#pre_render`) both call `getActiveOverride()`.

## Config & footprint

- **No config object or settings form of its own** (`configure: null`). The mapping lives inside
  each view's display config under `display_extenders.domain_views_display_display_extender.
  override_displays`. Schema: `config/schema/domain_views_display.views.schema.yml`
  (`override_displays` = sequence of strings). Installing also edits core `views.settings`.
- **No permissions**, **no Drush commands**, **no submodules**, no libraries. Provides config
  schema: yes.

## Known caveats (from README / code comments)

- Override loops are possible (display A → B → A); the extender has an unimplemented `@todo` to
  prevent them.
- Renaming a display that another display overrides breaks the mapping (reconfigure it).
- Overridden domains are added as config dependencies best-effort only (core issue #2426607).
