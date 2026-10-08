<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrate with the Phaxio online fax service.

---

Phaxio integrates Drupal with Phaxio — an online fax API — so a site can send faxes and receive fax-status callbacks, letting other modules react to fax events via `hook_phaxio_status`.

The status callback `/phaxio/status` is handled by `receiveStatus()`, which fires `hook_phaxio_status` with the `fax` + `event_type` params; the base module only fires the hook (mutates nothing). Store the Phaxio API secret securely (env-backed). Supports Drupal 9, 10, and 11.

---

- Integrate the Phaxio fax API.
- Send faxes.
- Receive fax-status callbacks.
- Fire `hook_phaxio_status`.
- Store the API secret securely.
- Depend on Drupal core only.
- Support Drupal 9, 10, and 11.
- Handle fax status.
- Configure Phaxio.
- Support Drupal.
- Support Drupal.
- Support Drupal.
