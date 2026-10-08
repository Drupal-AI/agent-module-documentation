<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Process JS Redirect Link is a migrate process plugin (`migrate_process_js_redirect_link`, alias `migrate_process_js_link`) that requests a source URL and extracts the real target link from a JavaScript-redirect landing page — the pattern used by Google's RSS feed links.
---
`transform()` accepts a value, and only if it is an absolute `http(s)` URL (validated with `FILTER_VALIDATE_URL`) does it issue a Guzzle GET via the injected `http_client`. It then parses the returned HTML with `DOMDocument` and returns the `href` of the last `<a>` element on the page (again only if that is an absolute URL), otherwise an empty string; transfer errors are logged and yield an empty string. It is meant to be chained with plugins like `migrate_process_html`, `dom`, `dom_select`, `skip_on_empty` and `file_remote_url`.

The plugin fetches a **migration-author-supplied URL server-side** (SSRF surface), but the URL comes from trusted migration source data / configuration, not from an end-user request, and there is no route or UI. TLS verification is left at Guzzle defaults (enabled). Setup: add the plugin to a migration process pipeline with `source:` pointing at the field holding the redirect URL.
---
- Resolve Google RSS feed redirect links to their real target URLs.
- Extract the destination URL from a JavaScript redirect page.
- Fetch a remote page during migration and pull out its link.
- Chain with `migrate_process_html` to further parse the target.
- Feed the extracted link into `file_remote_url` to import an image.
- Select `og:image` meta from the target page via `dom_select`.
- Skip rows where no valid link is found using `skip_on_empty`.
- Validate that extracted values are absolute URLs.
- Normalise feed items whose links go through a redirector.
- Import external article bodies referenced by redirect links.
- Log fetch failures to the module's logger channel.
- Return an empty string for non-URL inputs to keep pipelines safe.
- Combine with `migrate_conditions` for `skip_on_condition` matches.
- Migrate content from feeds that hide the real URL behind JS.
- Use the `migrate_process_js_link` alias in existing pipelines.
- Resolve redirect links on import from an RSS/Atom source.
