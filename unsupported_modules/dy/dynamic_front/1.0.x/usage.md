<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dynamic Front (obsolete; superseded by `dynamic_links`) makes the site front page redirect to the first URL, from an ordered admin-configured list, that the current user is allowed to access.
---
The settings form at `/admin/config/system/dynamic-front` (route `dynamic_front.settings`, permission `administer site configuration`) stores an ordered list of internal URLs; the module also disables the core "front page" field on the site information form, pointing admins to its own settings. A route callback (`DynamicFrontRoutes::routes()`) registers a `no_cache` route at the configured `system.site` front path (permission `access dynamic_front`), and `DynamicFrontController::redirect()` iterates the configured URLs, returning a `RedirectResponse` to the first one whose `Url::fromUserInput($url)->access()` passes, or throws `AccessDeniedHttpException` if none qualify.

The redirect targets are admin-configured internal user-input paths and each candidate is access-checked before redirecting, so a user is only ever sent to a page they may view. The module is marked `lifecycle: obsolete` with `lifecycle_link` to `dynamic_links`; prefer that project for new sites. Setup: enable, grant `access dynamic_front`, and list the candidate front paths in priority order.
---
- Send anonymous users to a public landing page and staff to a dashboard.
- Configure an ordered list of candidate front-page paths.
- Redirect each visitor to the first path they can access.
- Deny access when no configured path is viewable by the user.
- Grant front-page redirect capability via `access dynamic_front`.
- Disable the core site-frontpage field in favor of this module's list.
- Role-target the effective home page without custom code.
- Access-check every candidate before redirecting.
- Keep the redirect route uncached (`no_cache`).
- Log invalid configured URLs to the `dynamic_front` channel.
- Migrate to `dynamic_links` (this module is obsolete).
- Restrict configuration to `administer site configuration`.
- Order paths so the most specific audience match wins.
- Use internal user-input paths (e.g. `/dashboard`, `/welcome`).
- Provide different landing pages per permission set.
- Audit that redirect targets are access-checked (they are).
- Export the `dynamic_front` config between environments.
- Verify the configured front path matches `system.site` page.front.
- Confirm PHP 8.0+ is available (module requires it).
- Disable the module to restore the standard front page.
