<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GovDelivery Bulletins provides a service and queue for sending bulletins using the GovDelivery Bulletins API.

---

GovDelivery Bulletins provides a service and queue for sending bulletins (government email/SMS
notifications) via the GovDelivery (Granicus) Bulletins API — so a Drupal site can programmatically queue
and send bulletins to GovDelivery subscriber lists. It is configured at
`govdelivery_bulletins.govdelivery_bulletins_admin_form` and provides its own permissions, in the Web
Services package.

Use it to send bulletins through GovDelivery. The security-relevant point: it authenticates to the
GovDelivery API with credentials — **store them as secrets** (not in exported config), operate over HTTPS,
and gate who can trigger/queue bulletins with its permissions (sending bulletins reaches real subscribers,
so triggering must be trusted to avoid unwanted/mass sends). It is an integration/messaging feature with no
content-access role beyond its permission. Configure the GovDelivery connection.

---

- Send bulletins via GovDelivery.
- Provide a bulletin service and queue.
- Reach GovDelivery subscriber lists.
- Queue and send notifications.
- Configure at the admin form.
- Provide its own permissions.
- Store GovDelivery credentials as secrets.
- Operate over HTTPS.
- Gate who can trigger bulletins.
- Avoid unwanted/mass sends.
- Have no content-access role beyond permission.
- Configure the GovDelivery connection.
- Send government notifications.
- Handle credentials securely.
- Queue bulletins.
- Send email/SMS bulletins.
- Integrate GovDelivery.
- Configure bulletin sending.
- Restrict bulletin triggering.
- Send subscriber bulletins.
