<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Newsletter2Go — agent index

Integrates **Webform submissions with Newsletter2Go (Brevo)** email marketing (a handler subscribing contacts
to mailing lists). Config at `webform_newsletter2go.settings`; provides permissions. Version **2.0.0**. Core
`^10.1||^11`.

**Security:** store the Newsletter2Go/Brevo API credentials as **secrets**; HTTPS; submission data (email/PII)
is sent externally (consent + privacy). No access role beyond permission.
