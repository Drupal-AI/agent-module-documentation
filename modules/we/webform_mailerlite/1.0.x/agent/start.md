<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform MailerLite handler — agent index

Webform **handler sending submissions to MailerLite** (email marketing — add/update subscribers). Depends
on `webform`. Version **1.0.4**. Core `^10.1||^11||^12`.

**Privacy:** store the MailerLite API key as a secret; submission data (names/emails = PII) is sent to
MailerLite — obtain consent + disclose (GDPR). No access role. Configure the handler with API key + list.
