<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mautic API is the base integration for connecting Drupal to one or more Mautic instances.

---

Mautic API provides integration with the Mautic marketing-automation API, supporting multiple Mautic instances — the connectivity layer other modules use to push/pull data (contacts, events, segments) to Mautic, with connection and webhook management.

Mautic API credentials are configured per connection (`administer mautic_api_connection`) and webhooks (`administer mautic_api_webhook`); store credentials securely (env-backed) and restrict these permissions. Depends on core `rest`; supports Drupal 10 and 11.

---

- Integrate the Mautic API.
- Support multiple Mautic instances.
- Manage connections.
- Manage webhooks.
- Push/pull contacts and events.
- Serve as a connectivity layer.
- Gate connections with `administer mautic_api_connection`.
- Gate webhooks with `administer mautic_api_webhook`.
- Store credentials securely (env-backed).
- Depend on core `rest`.
- Support Drupal 10 and 11.
- Underpin Mautic modules.
- Connect Drupal to Mautic
- Configure instances
- Handle marketing automation.
- Restrict admin permissions.
- Integrate Mautic.
- Manage API access
