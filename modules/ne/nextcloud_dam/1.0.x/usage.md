<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Nextcloud DAM integrates a Nextcloud instance as a digital-asset-management source.

---

Nextcloud DAM **integrates a Nextcloud instance as a DAM** — talking to a Nextcloud server's API to browse and
reference files (documents/images/video) from Nextcloud as Drupal media, with an entity browser. It depends on core
Media, Entity Browser and the Social Auth Nextcloud module (and ships Nextcloud media types).

Use it to use Nextcloud as your asset source. It is a media/integration feature. Security/data handling: it
**connects to your Nextcloud server's API** (egress) with **credentials/OAuth** (via Social Auth Nextcloud) — store
those secrets securely (env/Key) over HTTPS, and only expose Nextcloud assets appropriate for the site's audience.
It has its own permissions. Configure the Nextcloud connection.

---

- Integrate Nextcloud as a DAM.
- Browse/reference Nextcloud files.
- Use Nextcloud assets as media.
- Depend on Media, Entity Browser, Social Auth Nextcloud.
- Provide its own permissions.
- Serve media integration.
- Connect to the Nextcloud API (egress) with credentials/OAuth.
- Store the Nextcloud secrets securely (env/Key, HTTPS).
- Expose only audience-appropriate assets.
- Configure the Nextcloud connection.
- Handle Nextcloud DAM.
- Browse assets.
- Configure the connection.
- Reference files.
- Handle the integration.
- Import assets.
- Secure the credentials.
- Provide Nextcloud DAM.
- Manage assets.
