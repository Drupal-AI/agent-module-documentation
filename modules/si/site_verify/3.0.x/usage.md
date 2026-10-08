<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Verification lets site owners prove domain ownership to search engines and other webmaster services, either by adding a meta tag to the front page or by serving a verification file from the site root.

---

The module manages a `site_verification` config entity that stores one verification record per service (Google, Bing, Yandex, or any custom provider). Each record has a `type` of either `meta` (a `<meta name="..." content="...">` tag injected on the front page only) or `file` (plain-text content served at a dynamic route matching the given filename off the site root). Records are managed at `/admin/config/search/verifications`, where an editor can add, edit, enable/disable, and delete verifications; the add/edit form accepts manual entry, pasting a full `<meta>` tag to auto-parse, or uploading a verification file to auto-parse. Only enabled (`status: true`) verifications are attached to the front page or served as a route. File-type verification routes are generated dynamically by a route-building service that queries all enabled `file` verifications and are rebuilt automatically whenever a verification entity is saved or deleted. Two permissions gate access: `administer site verify` for managing meta-tag verifications and viewing the listing, and `manage file based site verifications` for the file-serving type specifically (since serving arbitrary files from the site root has more sensitivity). A validation constraint enforces that no two enabled `file` verifications share the same filename. The module has no settings form of its own beyond the entity list/add/edit forms — there is no separate global settings page.

---

- Verify site ownership with Google Search Console using a meta tag.
- Verify site ownership with Bing Webmaster Tools using a meta tag.
- Verify site ownership with Yandex Webmaster using a meta tag or file.
- Paste a full `<meta name="..." content="...">` tag copied from a webmaster console and have it auto-parsed into fields.
- Upload a verification file (e.g. `google1234567890abcdef.html`) provided by a search engine and have its name/content auto-parsed.
- Serve a plain-text verification file at the site root (e.g. `/BingSiteAuth.xml`) without creating a real file on disk.
- Disable a verification temporarily without deleting its configuration.
- Re-enable a previously disabled verification.
- Delete an obsolete verification record.
- List all configured site verifications with their type, enabled status, and name/link in one admin view.
- Grant a limited role access to manage only meta-tag verifications via `administer site verify`.
- Grant a separate, more sensitive `manage file based site verifications` permission to trusted roles only, since file verifications can serve content at arbitrary root-relative paths.
- Migrate a legacy Yahoo verification (deprecated) forward via the module's update hook that moves it to a generic "custom" engine.
- Export a verification's configuration (`site_verify.site_verification.<id>.yml`) for deployment via config sync.
- Programmatically create a meta verification entity via `SiteVerification::create()` and `->save()`.
- Programmatically create a file verification entity and have its route appear after a route rebuild.
- Read back a verification's stored meta name/content via `drush config:get site_verify.site_verification.<id>`.
- Confirm a verification is valid (passes the config entity's typed-data validation) before saving.
- Rely on automatic route-cache rebuilds whenever a file verification is added, updated, or removed (no manual `drush cr` needed for the new file route to work).
- Use multiple verifications simultaneously (e.g. Google meta tag + Bing file) without conflicts.
- Prevent two enabled file verifications from claiming the same filename (unique-file validation constraint).
- Give an admin note/description to a verification so other editors know which service it belongs to.
- Rename the auto-generated machine name of a new verification before saving.
- View contextual help text on the verifications listing and add-form explaining the meta-tag vs file workflow.
- Keep a disabled file verification's config around without exposing its route publicly.
- Serve verification file content with a `text/plain` content type and cacheable response metadata.
- Restrict which roles can edit an existing file-type verification (file type edit form is hidden without the file permission).
- Ensure meta tags render only on the front page, not on every page of the site.
