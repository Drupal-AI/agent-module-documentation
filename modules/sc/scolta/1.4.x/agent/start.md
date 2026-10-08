<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scolta — agent index

**AI-powered client-side search with Pagefind** (Search API backend, static browser-side index). Depends on
`search_api`. Provides permissions (`administer scolta`, `use scolta ai`). Version **1.4.0**. Core `^10.3||^11`.

Search — the static Pagefind index is **served to the browser** (indexed content is effectively **public**): the
gatherer indexes only **published** entities but ignores per-user/entity view access, so index only public
content and respect Search API access. No access role beyond permission.

Optional AI (query expansion, summarization, follow-up) via a configured LLM provider (built-in client, Amazee.ai
managed gateway, or the Drupal AI module). Three POST endpoints under `/api/scolta/v1/*` gated by `use scolta ai`
+ a decoratable `_scolta_ai` feature check, with fail-closed per-IP/global flood limits. The anonymous role is
**not** granted `use scolta ai` on install (and it is revoked from anonymous by update 10004). A GET
`/api/scolta/v1/health` is anonymous but returns status-only unless the caller has `administer scolta`. Outbound
LLM calls go over Drupal's HTTP client (TLS verified); the endpoint URL is admin config, not request-supplied.
API key comes from `SCOLTA_API_KEY` env / `settings.php` `scolta.api_key`, or an encrypted Amazee.ai token in State.

The browser bundle (JS/CSS/WASM) is not committed here: `AssetDeployer` copies it from the installed
`tag1/scolta-php` into `public://scolta-assets` at install and on every cache rebuild.

## Diff 1.2.x → 1.4.x

Real changes since 1.2.x (spanning the 1.3.0 and 1.4.0 releases):

- **AI feature access is now one decoratable decision point (1.3.0).** New `scolta.ai_access` service
  (`AiAccessInterface` / `AiAccess`) and `_scolta_ai` route access check (`AiFeatureAccessCheck`). The three AI
  routes keep `_permission: 'use scolta ai'` and add `_scolta_ai: <feature>`; both must allow. The shipped rule
  only restates `use scolta ai`, but a site can decorate the service to narrow who reaches the features.
- **The search block no longer advertises AI features to visitors who cannot use them (1.3.0).**
  `ScoltaSearchBlock` now combines each config flag (`ai_expand_query` / `ai_summarize`) with the access answer
  and bubbles that cacheability, so an anonymous visitor is no longer handed a UI that fires a 403.
- **"Facet index loading" setting (1.3.0).** New `facet_mode` config (`eager` default / `deferred` / `disabled`)
  controlling when/whether the browser downloads the facet index.
- **`--entity-ids` option on `drush scolta:build` (1.3.0).** Scopes a build to an explicit comma-separated ID list.
- **Locale-safe library declaration (1.4.0).** New `scolta_library_info_alter()` resolves the deployed
  `public://scolta-assets` bundle URIs to `DRUPAL_ROOT`-relative paths; the raw `public://…` URI declaration had
  made every rendered page return HTTP 500 once the locale module was enabled.
- **Browser bundle deploys from installed scolta-php, not committed here (1.4.0).** `AssetDeployer` copies
  JS/CSS/WASM into `public://scolta-assets` at install, in `scolta_update_10005()`, and on every cache rebuild
  (`hook_rebuild()`); the block/library reference the deployed copies by stream-wrapper URI. Uninstall removes the
  directory.
- **`drush scolta:build` resume segments honor `--force` (1.4.0).** `runResumeChain()` now forwards `--force` to
  the segments it spawns, so a large forced build no longer silently degrades to incremental for its tail.
- **Version/library (1.4.0).** Opened the 1.4.x line; `tag1/scolta-php` re-locked to the published 1.4.0 (floor
  stays `^1.3.0`).

Unchanged from the earlier baseline (present since 1.0.x/1.1.x): the three POST AI endpoints, the anonymous
status-only health endpoint, the CSRF-protected dismiss-rebuild-notice route, per-IP/global flood limits, the
Amazee.ai managed-gateway path with an encrypted-at-rest token, and the `accessCheck(FALSE)` + `status = 1`
indexing queries.
