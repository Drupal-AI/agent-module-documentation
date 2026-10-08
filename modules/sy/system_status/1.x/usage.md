<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
System Status exposes a token-authenticated JSON endpoint reporting the site's installed modules, themes and versions, for external monitoring — plus a settings page.

---

Operations teams monitoring many Drupal sites want to poll each one for its module and version inventory — to know what is installed, what needs updating, and what is exposed to a new advisory — without logging into each. System Status provides that as a machine-readable endpoint: a JSON report of installed modules, themes and versions at a token-guarded URL that a central monitoring system can fetch.

Where openssl is available the inventory payload is encrypted for the monitoring client. The admin settings route is gated by the *administer site configuration* permission; the reporting endpoint uses the URL token.

---

- Report installed modules and versions.
- Monitor a site's update status.
- Poll a JSON status endpoint.
- Inventory modules remotely.
- Feed a central monitoring system.
- Check what needs updating.
- Report themes and versions.
- Track many sites' status.
- Encrypt the payload for a client.
- Gate the settings page by permission.
- Provide machine-readable status.
- Audit the module inventory.
- Poll for available updates.
- Monitor Drupal fleet health.