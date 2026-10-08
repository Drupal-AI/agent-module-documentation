<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Orange DAM provides API integration between Drupal and Orange Logic's Orange DAM.

---

Orange DAM **integrates Drupal with Orange Logic's Orange DAM** — pulling assets/metadata from the Orange DAM
digital-asset-management platform into Drupal (via migrations) so DAM assets can be used on the site. It depends on
core Node, Migrate and the Migrate Plus/Tools/Source Queue and Pathauto modules.

Use it to sync assets from Orange DAM. It is a media/DAM integration. Security/data handling: it **calls the Orange
DAM API** (egress) with **credentials/API key** (store as secrets — env/Key — over HTTPS) and imports asset data;
only import/expose assets appropriate for the site's audience. It has no access-control role. Configure the Orange
DAM credentials.

---

- Integrate Orange DAM.
- Pull assets/metadata via migration.
- Use DAM assets on the site.
- Depend on Node, Migrate, Migrate Plus.
- Serve media/DAM integration.
- Sync DAM assets.
- Call the Orange DAM API (egress) with credentials.
- Store the credentials/API key as secrets (env/Key, HTTPS).
- Import/expose only audience-appropriate assets.
- Have no access-control role.
- Configure the Orange DAM credentials.
- Handle Orange DAM.
- Import assets.
- Configure the client.
- Sync assets.
- Handle the integration.
- Pull metadata.
- Migrate assets.
- Secure the credentials.
- Provide Orange DAM integration.
