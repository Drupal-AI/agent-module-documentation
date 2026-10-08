<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How matching & redirecting works

Two event subscribers in `src/EventSubscriber/RedirectSubscriber.php` (service
`url_redirect.event_subscriber`, args `@path.matcher`, `@entity_type.manager`,
`@current_user`, `@messenger`):

- `KernelEvents::REQUEST` at **priority 33** (`requestRedirect`) — runs *before*
  `RouterListener` (priority 32) so a redirect can fire even for paths with no route.
- `KernelEvents::EXCEPTION` at priority 1 (`exceptionRedirect`) — runs `doRedirect()` for
  **403** responses, so a rule can redirect users off an access-denied page (avoiding an
  infinite-redirect loop with custom 403 pages).

A second subscriber, `RedirectSettingsCacheTag` (`url_redirect.settings_cache_tag`),
invalidates cache tags when redirect settings change.

## `doRedirect()` logic

1. `$path = Html::escape($request->getRequestUri())`; if it is `/` it becomes `<front>`.
2. **Wildcards:** every enabled rule whose `path` CONTAINS `*` is loaded and tested with
   `path.matcher->matchPath($path, $rule_path)`. First match wins.
3. **Exact:** `getRedirect($path)` queries enabled rules (`status = 1`) with
   `condition('path', $path)`; also retried against `substr($path, 1)` (no leading slash).
4. If a rule matches, load it and branch on `redirect_for`:
   - **Role**: `array_intersect($rule->getRoles(), $currentUser->getRoles())`. `negate`
     inverts the result.
   - **User**: current user id must be in the rule's `users` target_ids. (`negate` forces the
     redirect when set.)
5. On a positive match set the response to a **`TrustedRedirectResponse(target, 301)`**:
   - external (`preg_match('`https?://`', target)`) → target as-is;
   - `<front>` or empty → `TrustedRedirectResponse('<front>', 301)`;
   - otherwise → `$base_url . '/' . redirect_path`.
6. If the rule's `message` is `Yes`, a status message
   "You have been redirected to '<redirect_path>'." is queued.

## Consequences an agent should know

- Only **enabled** rules (`status = 1`) are ever considered.
- Matching is on the raw request URI, so store `path` with a leading slash (e.g. `/members`)
  or use `<front>`; wildcards use `*` (e.g. `/reports/*`).
- Redirects are **301 (permanent)** and use `TrustedRedirectResponse`, so external hosts are
  allowed without tripping Drupal's external-redirect protection.
- Role rules match if the user has *any* of the listed roles; `negate` flips that to "any
  user without those roles".
- There is no Drush command and no hook API — behavior is entirely driven by the
  `url_redirect` config entities (see [configure/redirects.md](../configure/redirects.md)).
