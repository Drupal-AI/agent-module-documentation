<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sub-pathauto makes URL aliases work for *sub-paths*: if `/node/1` is aliased to `/about-us`, then `/about-us/edit`, `/about-us/delete` and any other child path also resolve.

---

Core only aliases whole paths, so an alias on `/node/1` does nothing for `/node/1/edit`. Sub-pathauto registers a single service, `path_processor_subpathauto` (`Drupal\subpathauto\PathProcessor`), tagged as both `path_processor_inbound` and `path_processor_outbound` at priority **50**. On an inbound request it strips trailing path segments one at a time, asks core's `path_alias.path_processor` whether the shortened path is an alias, and on the first hit rebuilds the full internal path (`/about-us/edit` → `/node/1/edit`). It then re-validates the candidate with `path.validator` so a bogus path is never returned, guarding against recursion with an internal flag. Outbound it does the mirror operation, so `Url::fromRoute('entity.node.edit_form', …)` renders as `/about-us/edit`. A language-prefix helper strips the URL language prefix before matching (using `language.negotiation`'s `url.prefixes`), so it works on prefixed multilingual sites. Two settings live in `subpathauto.settings`: `depth`, the number of trailing segments to try (the form labels `0` as *Disabled*, but the code treats `0` as *no limit*, and an unset/NULL value stops processing entirely), and `redirect_support`, which — when the [Redirect](https://www.drupal.org/project/redirect) module is installed — resolves redirects on the parent path before alias lookup so stale aliases still work. A config event subscriber invalidates the `rendered` cache tag whenever the settings are saved.

---

- Make `/about-us/edit` work when `/node/1` is aliased to `/about-us`.
- Keep contextual "Edit"/"Delete" links on aliased pages pointing at pretty URLs.
- Serve aliased sub-paths for entity views tabs such as `/my-article/revisions`.
- Give taxonomy term aliases working child paths, e.g. `/products/tools/feed`.
- Support module routes that hang off an entity path (`/my-article/webform/results`).
- Make user aliases extend to `/team/jane/edit` and `/team/jane/track`.
- Allow REST/JSON endpoints defined under an aliased base path to be requested via the alias.
- Limit the performance cost by capping `depth` to 1 or 2 on very large sites.
- Turn processing off entirely on an environment by clearing/unsetting the `depth` setting.
- Resolve sub-paths of an *old* alias by enabling `redirect_support` with the Redirect module.
- Keep aliases working after a bulk Pathauto re-generation, via redirect fallback.
- Ensure outbound link generation emits `/alias/sub` instead of `/node/N/sub`.
- Handle language-prefixed URLs (`/de/ueber-uns/bearbeiten`) on prefix-negotiated sites.
- Avoid writing custom inbound path processors for a one-off "alias plus suffix" requirement.
- Improve SEO by exposing pretty child URLs (`/blog/my-post/page/2`) rather than raw system paths.
- Let editors bookmark `/about-us/edit` instead of remembering node ids.
- Make Views pages placed under an aliased path reachable through the alias.
- Support pager and exposed-filter sub-paths under an aliased Views page.
- Give commerce product aliases working `/product/foo/add-to-cart`-style child routes.
- Preserve alias behaviour for entity forms opened in a modal from an aliased page.
- Deploy the depth setting per environment through configuration management (`subpathauto.settings.yml`).
- Invalidate all rendered pages automatically when the sub-path depth changes.
- Verify sub-path resolution from code with `path_processor_manager::processInbound()`.
- Diagnose a broken sub-path by checking whether `depth` is set at all in `subpathauto.settings`.
