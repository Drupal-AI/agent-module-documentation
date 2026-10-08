<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sites overrides — architecture

## Core idea
Return a site-specific override entity instead of the shared original whenever a site (or preview) context is active — transparently, by decorating the services that load entities.

## Key services (sites_content_overrides.services.yml)
- `sites_content_overrides.site_aware_entity_resolver` (`SiteAwareEntityResolver`) — central resolver mapping an entity to its per-site override.
- `paramconverter.entity` **decorated** by `ParamConverter\EntityConverter` — route entity params resolve to the override.
- `entity.repository` **decorated** by `Entity\EntityRepository` — programmatic loads resolve to the override.
- `SiteOverrideRouteSubscriber`, `SitesContentOverridesConfigSubscriber` (definition-update aware), `SitesContentOverridesService`.
- `Hook\SitesContentOverridesHooks` — wired with `@csrf_token`, `@site_switcher`, `@sites_preview.service`; builds override/revert action links (CSRF-tokenised).

## Access
`Access\SitesOverridesParagraphAccessControlHandler::checkAccess()` — for `update`/`delete` on a paragraph, if `isSiteOverrideEditRoute()` and the route `site` is a `SiteWithContentInterface`, returns `allowed()` when `$site->contentAccess('update', $parentEntity, $account)` is true (cache contexts route/user.permissions/site). Otherwise falls back to the stock `ParagraphAccessControlHandler`. This intentionally bypasses the Content Moderation `forbid()` that blocks paragraph edits, but the authorization decision is delegated to the Sites module.

## Plugins
- `Plugin/SiteSetting/ContentOverrides`, `Plugin/TopBarItem/{PageOverrideActions,SiteOverrideStatus}`, `Plugin/views/query_extend/SitesContentOverrideEntities`, `Plugin/Validation/Constraint/SiteAwareEntityChanged*`, `Plugin/Derivative/SiteOverridesLocalTask`.

## Submodules
`*_behaviors`, `*_content_moderation`, `*_layout_builder`, `*_revisions_ui` — optional integrations.

## Prerequisite
Requires the `sites` / `sites_preview` / `form_decorator` contrib stack; not usable on a vanilla single site.
