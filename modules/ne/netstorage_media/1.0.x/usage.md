<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
NetStorage Media imports Akamai NetStorage assets as Drupal media entities.

---

NetStorage Media synchronizes assets stored in Akamai NetStorage — Akamai's cloud storage/CDN origin — into Drupal as media entities, so files hosted on NetStorage can be managed and referenced through the Media system without duplicating them locally.

NetStorage credentials should be stored securely (env-backed); sync is gated by `administer netstorage media sync`. Depends on core `media`; supports Drupal 10 and 11.

---

- Sync Akamai NetStorage assets.
- Create media entities from assets.
- Reference NetStorage files as media.
- Avoid local duplication.
- Manage assets via the Media system.
- Store credentials securely.
- Keep credentials env-backed.
- Gate sync with `administer netstorage media sync`.
- Depend on core `media`.
- Support Drupal 10 and 11.
- Integrate Akamai storage.
- Import cloud assets.
- Support CDN origin
- Configure the connection
- Sync remote media.
- Manage NetStorage media.
- Reference cloud files.
- Support Akamai
