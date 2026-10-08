<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Robots DTAP keeps non-production environments (Development/Test/Acceptance) out of search engines by injecting a `noindex, nofollow` robots meta tag everywhere except on recognised production domains.

---

A settings form at `/admin/config/system/robots_dtap/settings` (permission `access administration pages`) stores a newline-separated list of production domains. `hook_page_attachments()` compares the current HTTP host to that list: if the host is not in the list (and the list is non-empty), it attaches a `<meta name="robots" content="noindex, nofollow">` tag to the head. On production hosts, or when no domains are configured, nothing is added. This is host-based rather than settings-per-environment, so the same config export works across all environments. It affects only the meta tag; it does not manage the physical `robots.txt` file.

---

- Prevent staging/acceptance sites from being indexed by Google.
- Add noindex,nofollow automatically on every non-production host.
- Keep one configuration that behaves correctly across DTAP environments.
- Whitelist one or more production domains that should be indexed.
- Avoid duplicate-content penalties from indexed test copies.
- Ship SEO-safe defaults without per-environment settings overrides.
- Block crawlers on feature-branch/preview domains.
- Complement robots.txt with a page-level meta directive.
- Configure production domains via a simple admin textarea.
- Rely on host matching so `settings.php` need not change.
- Ensure acceptance sign-off environments stay private from search.
- Apply noindex to all routes, including nodes and views.
- Turn off the behavior by clearing the production-domain list.
- Support multi-domain production setups with multiple whitelisted hosts.
- Reduce risk of leaking pre-launch content into search results.
