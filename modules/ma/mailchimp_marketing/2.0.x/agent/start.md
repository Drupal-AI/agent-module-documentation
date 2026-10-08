<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mailchimp marketing — agent index

Integrates the **Mailchimp** email-marketing service (audiences, subscriber sync, campaigns);
`mailchimp_marketing_subscribe_ct` submodule. Config at `mailchimp_marketing.admin`; provides permissions.
Version **2.0.1**. Core `^10.3||^11.0`.

**Privacy:** store the Mailchimp API key as a secret; subscriber data (emails/names = PII) goes to Mailchimp
— consent + disclose (GDPR). No access role.
