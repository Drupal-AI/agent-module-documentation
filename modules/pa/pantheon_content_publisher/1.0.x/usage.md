<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pantheon Content Publisher provides Pantheon Content Publisher integration for Drupal.

---

Pantheon Content Publisher integrates Drupal with Pantheon's Content Publisher — connecting the site to
Pantheon's content-publishing/authoring service (e.g. authoring content in Google Docs and publishing it into
Drupal) via Pantheon's platform. It depends on the Search API module (>= 8.x-1.20), provides its own
permissions, in the Pantheon package.

Use it on Pantheon-hosted sites using the Content Publisher. Security note: it connects to Pantheon's service
with credentials/tokens — **store those as secrets** (not in exported config) and operate over HTTPS;
published content flows from the external source into Drupal (treat imported content per your trust of the
source). It has no access-control role beyond its permission. Configure the Pantheon Content Publisher
connection.

---

- Integrate Pantheon Content Publisher.
- Connect to Pantheon's publishing service.
- Publish external content into Drupal.
- Depend on Search API.
- Provide its own permissions.
- Store Pantheon credentials/tokens as secrets.
- Operate over HTTPS.
- Treat imported content per source trust.
- Have no access-control role beyond permission.
- Configure the connection.
- Handle content publishing.
- Publish from Google Docs.
- Import published content.
- Configure Pantheon.
- Handle credentials securely.
- Connect to Pantheon.
- Publish content.
- Integrate the publisher.
- Configure publishing.
- Handle Pantheon publishing.
