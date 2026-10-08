<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sites overrides provides a generic way to override shared content per site in a Sites-module multi-site, so entities can carry site-specific variants that are resolved transparently when a given site is active.
---
It works by decorating core services: a `SiteAwareEntityResolver` plus decorators over `paramconverter.entity` and `entity.repository` make entity loads return the site-specific override when one exists for the active/preview site, without callers needing to know. A route subscriber, config subscriber, a `ParamConverter` `EntityConverter`, a views query extender, and a validation constraint (`SiteAwareEntityChangedConstraint`) round out the integration; Navigation TopBar items (`PageOverrideActions`, `SiteOverrideStatus`) surface override state/actions in the admin UI. Four optional submodules add integrations for Behaviors, Content Moderation, Layout Builder, and a Revisions UI. Settings live at `/admin/config/sites/content-overrides` (`administer site configuration`).

Security-relevant detail: `SitesOverridesParagraphAccessControlHandler` deliberately grants paragraph update/delete access when the current route is a site-override edit route AND `$site->contentAccess('update', $parent_entity, $account)` returns true (sites_content_overrides/src/Access/SitesOverridesParagraphAccessControlHandler.php:32-49) — it bypasses the Content Moderation gate that would otherwise `forbid()`, but only after delegating the real check to the Sites module's per-site content access. The hooks service is wired with `@csrf_token`, indicating override action links are CSRF-tokenised. This module builds on the (non-core) `sites`/`sites_preview`/`form_decorator` ecosystem, so it is only meaningful on a site already running that stack.

Typical setup: run the Sites platform, enable this module (+ form_decorator, navigation), configure which entity types/bundles are overrideable, then edit per-site overrides from the site context.
---
- Override shared content per site in a multi-site.
- Resolve site-specific entity variants transparently on load.
- Decorate the entity param converter for site awareness.
- Decorate `entity.repository` to return overrides.
- Edit an override for the currently active site.
- Preview a site's overridden content.
- Show override status in the Navigation top bar.
- Trigger override/revert actions from the admin UI.
- Extend Views queries to respect site overrides.
- Integrate overrides with Content Moderation (submodule).
- Integrate overrides with Layout Builder (submodule).
- Integrate overrides with paragraph Behaviors (submodule).
- Add a per-site revisions UI (submodule).
- Configure overrideable entity types/bundles.
- Allow paragraph edits within a site-override edit route.
- Validate concurrent-edit conflicts site-awarely.
