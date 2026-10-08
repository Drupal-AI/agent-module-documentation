<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Virtuous — agent index

**Virtuous CRM (fundraising) integration** (contact sync + webhooks). Version **8.x-1.0**. Core `^11`.

**SECURITY (8.x-1.0):** `/virtuous/webhook/contact-created` + `/contact-updated` are `_access: TRUE` and the token check is **disabled** (`// Authorization validation disabled`) → anonymous can trigger syncs of arbitrary contact ids (quota abuse / enumeration; server-side re-fetch bounds it). Re-enable `validateWebhookAuthorization()`. API key via a Key entity.