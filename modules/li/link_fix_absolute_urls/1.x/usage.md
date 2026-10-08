<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link: Fix Absolute URLs automatically converts same-site absolute URLs stored in link fields into portable internal references whenever an entity is saved.

---

Editors often paste a full URL (for example `https://www.example.com/about`) into a **link field** when they really mean a page on the same site. Those hardcoded absolute URLs are brittle: they break if the domain changes, bypass Drupal's internal link handling, and can leak a staging hostname into production. This module watches `hook_entity_presave()` and, for every `link`-type field on the entity being saved, checks whether the URL points at the current site; if it does, it rewrites the stored value to an internal reference — `entity:node/<id>` for nodes (aliases resolved through the path-alias system), `internal:/<path>` for other routed paths or local files, and `internal:/` for the front page — while leaving the link **title** and all off-site links untouched. Installation is the entire setup: run `composer require drupal/link_fix_absolute_urls` and enable the module (`drush en link_fix_absolute_urls`); there is **no settings page, permission, or configuration** of any kind. Only links saved *after* enabling are fixed, so to clean up content that already exists, re-save the affected entities — either by re-saving them in the UI, or programmatically with `\Drupal::service('link_fix_absolute_urls.link_processor')->process($entity)` (save the entity only if it returns `TRUE`), which the maintainers suggest wiring into a `hook_post_update_NAME()` for a one-shot site-wide fix.

---

- Convert same-site absolute URLs in link fields to internal references.
- Fix full URLs editors paste into link fields.
- Rewrite `https://mysite.com/node/12` to `entity:node/12`.
- Resolve pasted path aliases back to their canonical node reference.
- Turn a same-site file URL into an `internal:/…` path.
- Point front-page links at `internal:/` instead of the absolute home URL.
- Make internal links survive a domain or hostname change.
- Strip a leaked staging hostname out of stored links.
- Normalise `http://`, `https://`, and `www.` variants of your own domain.
- Leave genuinely external links completely unchanged.
- Preserve each link's title text while fixing its URI.
- Benefit from Drupal's internal link and access-aware URL handling.
- Install with `composer require drupal/link_fix_absolute_urls`.
- Enable with `drush en link_fix_absolute_urls` — no further setup.
- Run with zero configuration, no settings page, and no permissions.
- Apply the fix to every entity type that has link fields.
- Reuse the `link_fix_absolute_urls.link_processor` service in custom code.
- Bulk-fix existing content by re-saving affected entities.
- Migrate a whole site's links from a `hook_post_update_NAME()`.
- Skip `Redirect` entities automatically to avoid breaking redirects.
- Clean up link fields as a content-hygiene step before a site relaunch.
- Keep link data portable across environments.
