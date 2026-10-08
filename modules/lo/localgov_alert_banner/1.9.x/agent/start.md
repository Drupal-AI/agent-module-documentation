<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Alert Banner (localgov_alert_banner) — agent index

Sitewide emergency banners as a dedicated content entity with bundles, moderation, per-bundle
permissions and a render block. Depends on core `block`, `content_moderation`, `field`, `link`,
`node`, `options`, `user`, `views`, `workflows` plus contrib **`condition_field`**.

- **Entity, bundles, fields, workflow, block placement** → [configure/setup.md](configure/setup.md)
- **The manager API, block rendering and cacheability** → [api/manager.md](api/manager.md)
- **Global and per-bundle permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Content entity **`localgov_alert_banner`** (base table `localgov_alert_banner`,
  `bundle_entity_type: localgov_alert_banner_type`,
  `admin_permission: manage all localgov alert banner entities`), revisionable with a custom
  storage handler `AlertBannerEntityStorage` (`revisionIds()`, `userRevisionIds()`,
  `countDefaultLanguageRevisions()`, `clearRevisionsLanguage()`), custom access handler,
  translation handler and `AlertBannerEntityHtmlRouteProvider`.
- Shipped bundle `localgov_alert_banner` with fields `short_description`, `link`,
  `type_of_alert` (severity list) and `visibility` (a **`condition_field`** value — page/context
  conditions).
- Also shipped: workflow `workflows.workflow.localgov_alert_banners`, role
  `user.role.emergency_publisher`, admin view `views.view.localgov_admin_manage_alert_banners`
  (`/admin/content/alert-banners`).
- Block plugin **`localgov_alert_banner_block`** (*Alert banner*) renders the current banners.
- `AlertBannerManager::getCurrentAlertBanners(array $options)` — options `type` (array of bundles,
  default all) and `check_visible` (default FALSE). Ordering: `type_of_alert` DESC **only when
  that field storage still exists**, then `changed` DESC. Query uses `accessCheck(TRUE)`; each
  banner is passed through `entityRepository->getTranslationFromContext()` and an explicit
  `access('view')` check.
- Deliberate design note in the source: **all** published banners are loaded before the visibility
  filter runs, "so we get cache contexts on all" — do not optimise that away, it is what keeps the
  block's cache metadata correct.
- Hooks: `hook_preprocess()` and `hook_preprocess_field()` for rendering,
  `hook_theme()` + `hook_theme_suggestions_localgov_alert_banner()` for per-type templates,
  `hook_modules_installed()` → `localgov_alert_banner_configure_scheduled_transitions()` when
  Scheduled Transitions arrives, `localgov_alert_banner_set_default_permissions()`, and
  `localgov_alert_banner_gin_content_form_routes()` for Gin.
