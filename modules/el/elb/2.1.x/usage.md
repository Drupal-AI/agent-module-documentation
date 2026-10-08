<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
External Link Blocklist lets you define a comma-separated list of URL patterns that are forbidden in link fields, so editors get a validation error when they try to enter a matching external URL.

---

The module provides a link field widget (`ext_link_blocklist_field_widget`) and, optionally, alters the Linkit CKEditor link dialog to validate the `href` element. Validation is centralised in `BlocklistService`: it reads `elb.settings.blocklist` and `elb.settings.blocklist_exceptions` (each a comma-separated string, trimmed into arrays) and `isBlocklisted($uri)` returns TRUE when the URI contains any blocklisted substring and no exception substring. Matching is plain substring containment (`substr_count`), not domain parsing, so patterns like `example.com` match anywhere in the string; exceptions exist so a subdomain of a blocklisted domain can still be allowed. A common use case is blocking staging/dev domains from creeping into content as absolute links.

Blocklist and exceptions are edited at `/admin/config/content/elb`, gated by the `access the external links blocklist page` permission. To use it, add a Link field, choose the "External link blocklist" widget in Manage form display, and fill in the patterns. Note the update hook `elb_update_8004` auto-grants the settings-page permission to every role that already had "access administration pages".

---

- Forbid specific external domains/URLs in link fields.
- Stop dev/staging absolute URLs from being saved into content.
- Add the "External link blocklist" widget to a Link field.
- Maintain a comma-separated blocklist at `/admin/config/content/elb`.
- Allow a subdomain of a blocklisted domain via the exceptions list.
- Validate links entered through the Linkit CKEditor dialog.
- Show editors an error when they enter a blocklisted link.
- Restrict blocklist administration with a dedicated permission.
- Block by substring pattern (matches anywhere in the URL).
- Enforce internal-linking policy during site development.
- Prevent accidental links to competitor or wrong domains.
- Configure widget size and placeholder text.
- Apply the same blocklist across multiple link fields.
- Update patterns centrally without touching field config.
- Review role permissions after upgrade (auto-grant caveat).