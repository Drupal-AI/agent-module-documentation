<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Analytics Cookieless injects a Universal Analytics (UA-xxxxxx-yy) tracking snippet that reports page views without storing the GA cookie.
---
`hook_page_attachments()` adds the tracking library and passes the configured UA account id, a JS file address, and an IP-anonymisation flag into `drupalSettings`; the bundled JS then sends hits to Google without the `_ga` cookie. Tracking is suppressed unless the account matches `^UA-\d+-\d+$`, the current path passes the visibility rules, and (optionally) the visitor is not an authenticated user. Page visibility reuses the classic Google Analytics module logic (`request_path_mode` include/exclude list of paths). The admin form lives at `/admin/config/system/google-analytics-cookieless`.

Note this targets legacy Universal Analytics property ids (UA-), which Google has sunset, so it is primarily useful for archival/self-hosted GA-style endpoints. Security review note: the settings route requires permission `administer google analytics` while the module's own `permissions.yml` defines `administer google analytics cookieless` — the route reuses the classic Google Analytics module's permission, so if that module is absent the permission is undefined and the form is reachable only by user 1 (locked down, not opened up).
---
- Enter a UA property id to enable tracking.
- Track page views without the GA cookie (GDPR-friendlier).
- Anonymise visitor IP addresses.
- Exclude admin/other paths from tracking.
- Track only a specific list of paths.
- Choose whether to track logged-in users.
- Point the tracker at a custom JS file address.
- Add analytics without the full google_analytics module.
- Keep tracking snippet out of pages that fail visibility rules.
- Validate the account id format before emitting the snippet.
- Restrict settings access to the analytics-admin permission.
- Provide cookieless statistics for a privacy-focused site.
- Track all pages except a listed exclusion set.
- Suppress tracking on admin paths.
- Serve the tracker without adding third-party cookies.
- Reuse the classic GA module's path-visibility semantics.