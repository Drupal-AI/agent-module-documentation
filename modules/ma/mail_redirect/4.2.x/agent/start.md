<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mail Redirect — agent index

Redirects **ALL system-generated email to a configured test address/domain** — for testing on
non-production sites with real emails in the DB. Config at `mail_redirect.admin_settings`. Version
**4.2.6**. Core `^9.5||^10||^11`.

**SECURITY — TESTING TOOL, NEVER ON PRODUCTION:** it intercepts *every* outbound email → on a live site
real emails (resets/orders/notices) never reach users AND their PII/reset links go to the test address.
Dev/staging only; treat production presence as a misconfiguration.
