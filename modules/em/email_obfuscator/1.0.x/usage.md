<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Email Obfuscator scans every rendered front-end HTML response and obfuscates the email addresses it finds so simple harvesting bots cannot read them directly from the markup.

---

The module registers a kernel RESPONSE event subscriber that rewrites the response body on non-admin pages. Addresses inside `mailto:` links are reversed and given inline `onfocus`/`onmousedown` handlers that restore the real address the first time a visitor clicks or tabs to the link; plain-text addresses have a hidden `display:none` span inserted in the middle of the string (optionally tagged `data-nosnippet` so Googlebot skips it). Admin/backoffice routes, routes you list in `settings.php`, Ajax webform submissions and any address inside an HTML tag or attribute are left alone, as are addresses that fail PHP's `filter_var()` email validation. There is no settings form and no permission — you enable the module and, if needed, tune two optional keys in `settings.php`. Treat it as a deterrent that reduces casual scraping and spam; because the address is still delivered to the browser, a determined scraper can still recover it, so it is not access control or a privacy guarantee.

---

- Deter automated email-harvesting bots that scrape addresses from page HTML.
- Reduce inbound spam to addresses published on the site.
- Obfuscate `mailto:` link addresses site-wide without editing content.
- Reverse the address in `mailto:` hrefs so the raw address is not in the served markup.
- Restore the real `mailto:` address automatically on first click, focus or right-click.
- Hide plain-text addresses (e.g. `info@example.com` printed as body text) with an injected invisible span.
- Keep obfuscated addresses out of search-engine snippets via the `data-nosnippet` attribute.
- Apply obfuscation to all front-end responses automatically, with no per-field or per-view configuration.
- Leave admin/backoffice pages unmodified so editing UIs are unaffected.
- Exclude specific routes from obfuscation by listing them in `settings.php` (`ignored_routes`).
- Exclude the CKEditor 4 link dialog route (`editor.link_dialog`) so editing links still shows the real address.
- Avoid corrupting Ajax webform submissions, which the filter skips.
- Skip invalid email strings so non-email text is never altered.
- Skip addresses embedded in HTML attributes such as input `placeholder` values.
- Disable the `data-nosnippet` behavior via `settings.php` (`use_datanosnippet => FALSE`) when not wanted.
- Protect contact-page and footer email addresses from casual scraping.
- Add lightweight anti-spam hardening to a site without changing themes or content.
- Deploy obfuscation across a multi-site or many pages by simply enabling one module.
- Combine with other spam measures as a low-cost first layer of email protection.
- Log obfuscation failures to the `email_obfuscator` logger channel for debugging.
