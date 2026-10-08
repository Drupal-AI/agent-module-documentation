<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin notification (admin_notification) — agent index
**Sets one admin-defined message shown to every authenticated user on each request via the messenger.**

- **Version:** 8.x-1.x
- **Core:** ^8 || ^9 || ^10
- **Route:** `admin_notification.admin_form` → `/admin/config/system/admin_notification` (permission `administer admin notification`)
- **Permission:** `administer admin notification`
- **Mechanism:** `KernelEvents::REQUEST` subscriber reads Drupal state (`admin_notification.enabled/message/type`) and calls messenger for authenticated users only.
- **Security:** Admin config route is permission-gated; the message is added only to authenticated users; no anonymous, mutating, or external endpoints. Message is trusted admin input.
