<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Wedia transfers content from the Wedia digital-asset-management platform.

---

Wedia **transfers assets from the Wedia DAM** — connecting Drupal to the Wedia digital-asset-management
platform so assets can be imported/referenced as media. It depends on core Media and provides its own permissions.

Use it to use Wedia assets in Drupal. It is a media/DAM integration. Security/data handling: it **calls the Wedia
API** (egress) with **credentials/API keys** (store as secrets — env/Key — over HTTPS) and imports asset data;
expose only assets appropriate for the site's audience. It has no access-control role beyond its permission.
Configure the Wedia credentials.

---

- Transfer Wedia DAM assets.
- Import/reference Wedia media.
- Use Wedia assets in Drupal.
- Depend on core Media + provide permissions.
- Serve media/DAM integration.
- Connect to Wedia.
- Call the Wedia API (egress) with credentials.
- Store credentials/API keys as secrets (env/Key, HTTPS).
- Expose only audience-appropriate assets.
- Have no access-control role beyond permission.
- Configure the Wedia credentials.
- Handle Wedia.
- Import assets.
- Configure the client.
- Transfer assets.
- Handle the integration.
- Reference media.
- Sync assets.
- Secure the credentials.
- Provide Wedia integration.
