<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search Replace Aliases gives administrators a two-step (preview then apply) form to find a text fragment across all URL aliases and replace it in bulk via a batch process.
---
The form at `/admin/config/search/path/replace` first queries `path_alias` entities whose `alias` contains the search string (`entityQuery(...)->condition('alias','%'.$search.'%','LIKE')`), shows a preview list of old→new aliases, and on confirmation runs a Batch API job that loads each `PathAlias`, applies `str_replace()`, and saves it (`search_replace_aliases/src/Form/SearchReplaceAliasesForm.php:130-164`). The search value is bound as a query placeholder (parameterised), so there is no SQL injection, and being a `FormBase` the submission carries Drupal's CSRF form token automatically.

Access is gated two ways: the route requires `administer site configuration`, and the module also defines an `access search replace aliases` permission (marked `restrict access: true`) — note the route currently checks the former, so ensure only trusted admins reach the page. This is a destructive bulk mutation with no dry-run rollback beyond the preview step, so operators should review the preview carefully; a broad fragment can rewrite many aliases at once. The UI strings are in Spanish.

Typical setup: enable the module, visit the form, enter search/replace fragments, review the preview, then confirm.
---
- Find all aliases containing a fragment.
- Preview old→new alias changes before applying.
- Bulk-replace a path segment across aliases.
- Fix a site-wide slug rename in one pass.
- Correct a typo repeated in many aliases.
- Migrate an alias prefix (e.g. /blog → /news).
- Run the replacement as a batch job.
- See a count of affected aliases.
- Restrict access to trusted administrators.
- Combine with the Redirect module to add redirects (warned in the form).
- Batch large alias sets without timeouts.
- Confirm the affected count before applying.
- Rename a URL prefix across the site.
- Fix a repeated typo in many aliases.
- Restrict the page to trusted administrators.
- Pair with Redirect to preserve old URLs.
