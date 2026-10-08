<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Alert Banner (localgov_alert_banner) — agent index

Sitewide emergency banners as a dedicated content entity with bundles, moderation, per-bundle
permissions and a render block. Depends on core `block`, `content_moderation`, `field`, `link`,
`node`, `options`, `user`, `views`, `workflows` plus contrib **`condition_field`** (`^2.0`).

- **Entity, bundles, fields, workflow, block placement** → [configure/setup.md](configure/setup.md)
- **The manager API, block rendering and cacheability** → [api/manager.md](api/manager.md)
- **Global and per-bundle permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Optional submodules (Group, Full page)** → [submodules/overview.md](submodules/overview.md)

Key facts:
- Content entity **`localgov_alert_banner`** (base table `localgov_alert_banner`,
  `bundle_entity_type: localgov_alert_banner_type`,
  `admin_permission: manage all localgov alert banner entities`), revisionable + translatable with
  a custom storage handler `AlertBannerEntityStorage`, custom access handler
  (`AlertBannerEntityAccessControlHandler`), translation handler and
  `AlertBannerEntityHtmlRouteProvider`. All admin routes live under `/admin/content/alert-banner`.
- Shipped bundle `localgov_alert_banner` with fields `short_description`, `link`,
  `type_of_alert` (severity list) and `visibility` (a **`condition_field`** value — page/context
  conditions). Base fields include `title` (plain string, max 50), `display_title`,
  `remove_hide_link` and a private `token` (used for the dismiss cookie).
- Also shipped: workflow `workflows.workflow.localgov_alert_banners`, role
  `user.role.emergency_publisher`, admin view `views.view.localgov_admin_manage_alert_banners`
  (`/admin/content/alert-banners`), and three optional blocks in `config/optional`.
- Block plugin **`localgov_alert_banner_block`** (*Alert banner*) renders the current banners.
- `AlertBannerManager::getCurrentAlertBanners(array $options)` — options `type` (array of bundles,
  default all) and `check_visible` (default FALSE). Ordering: `type_of_alert` DESC **only when
  that field storage still exists**, then `changed` DESC. Query uses `accessCheck(TRUE)`; each
  banner is passed through `entityRepository->getTranslationFromContext()` and an explicit
  `access('view')` check. Only published (`status = 1`) banners are ever returned.
- Deliberate design note in the source: **all** published banners are loaded before the visibility
  filter runs, "so we get cache contexts on all" — do not optimise that away, it is what keeps the
  block's cache metadata correct.
- Status form (`AlertBannerEntityStatusForm`, route `entity.localgov_alert_banner.status_form`,
  gated by `_entity_access: update`) is the go-live/take-down UI; it can optionally unpublish all
  other live banners in one step. Publishing regenerates the entity's `token` in `preSave()`.
- Route access checker `AlertBannerEntityPageAccess` (service
  `localgov_alert_banner.alert_banner_entity_page_access`) guards the banner *page* routes
  (canonical + revision), wired by `AlertBannerRouteSubscriber`.
- Hooks (now in `src/Hook/*`): `HelpHooks`, `ThemeHooks` (`hook_theme`,
  `hook_preprocess_localgov_alert_banner`, `hook_theme_suggestions_localgov_alert_banner`,
  `hook_preprocess_field`), `ModuleHooks` (`hook_modules_installed` →
  `localgov_alert_banner_configure_scheduled_transitions()`), `GinHooks`
  (`hook_gin_content_form_routes`). Legacy procedural wrappers remain in the `.module` via
  `#[LegacyHook]`.
- Optional submodules: `group_alert_banner` (Group integration) and
  `localgov_alert_banner_full_page` (full-screen banner bundle) — see
  [submodules/overview.md](submodules/overview.md).
