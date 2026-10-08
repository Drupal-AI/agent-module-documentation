403 to 404 (m4032404) converts Drupal "403 Access Denied" responses into "404 Not Found", so protected pages look non-existent rather than merely forbidden — hiding their existence from anonymous users and crawlers.

---

The module is tiny: a single exception event subscriber (`M4032404EventSubscriber`, priority 50 on `KernelEvents::EXCEPTION`) that catches `AccessDeniedHttpException` and replaces it with `NotFoundHttpException`. It is configurable through `m4032404.settings` (form at `/admin/config/system/m4032404`, route `m4032404.config`): `admin_only` limits the behaviour to admin routes; `pages` is a list of path patterns; and `negate` decides whether those paths are the ones to redirect (false) or the ones to exclude (true). CSRF-confirm routes are skipped so token flows still work. A per-user escape hatch is provided by the `access 403 page` permission — users who have it keep seeing the real 403 (useful for editors/debugging), while everyone else gets the 404. The second permission, `administer 403 to 404 settings`, gates the config form. Because saving the form rebuilds routes, the change takes effect immediately. This is a common hardening step: it prevents attackers from distinguishing "exists but forbidden" from "does not exist" during URL enumeration.

---

- Return 404 instead of 403 for access-denied pages so their existence is hidden.
- Prevent anonymous users from discovering that a protected node/path exists.
- Reduce information leakage during URL enumeration by crawlers or attackers.
- Hide the admin area from anonymous visitors by returning 404 on admin routes.
- Apply 403→404 only to admin paths via the `admin_only` setting.
- Limit the behaviour to a specific set of paths (e.g. `/reports/*`) with the `pages` list.
- Exclude a set of paths from the behaviour by enabling `negate`.
- Let trusted editors still see the real 403 via the `access 403 page` permission.
- Keep CSRF-confirm token routes working (they are intentionally skipped).
- Harden a site against forced-browsing reconnaissance with a one-line install.
- Make unauthorized `/user/*` profile access look like a missing page.
- Present a consistent "page not found" to unauthenticated users across the site.
- Combine with a custom 404 page for a uniform not-found experience.
- Debug access issues by granting yourself `access 403 page` to see the underlying 403.
- Restrict who can change the behaviour with `administer 403 to 404 settings`.
- Deploy the behaviour as code by exporting `m4032404.settings`.
- Turn the redirect on for only the front-facing site while leaving APIs untouched via `pages`.
- Avoid tipping off bots to login/admin endpoints by masking 403s as 404s.
- Satisfy a security review recommendation to not reveal protected resources.
- Apply security-through-obscurity selectively without custom exception subscriber code.
- Wildcard-match path groups (`*`) and `<front>` in the pages list.
- Switch the meaning of the pages list between include and exclude with one radio.
