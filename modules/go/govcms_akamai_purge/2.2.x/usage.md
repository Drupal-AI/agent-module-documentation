<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GovCMS Akamai Purge is a helper module for purging Akamai CDN cache, integrating with the Purge module's queuer/processor.

---

GovCMS Akamai Purge is a helper for invalidating Akamai CDN cache from Drupal — integrating with the
Purge module (core-tags queuer + late-runtime processor) so that when content changes, the corresponding
Akamai-cached objects are purged. It is oriented toward the GovCMS platform (Australian government
Drupal). It depends on Purge's queuer/processor submodules, provides its own permissions and Drush
commands.

Use it on Akamai-fronted (GovCMS) sites to keep the CDN in sync with content changes. The
security-relevant point is the Akamai credentials used for purge API calls — store them as secrets, scope
them to purge operations with least privilege. It is an integration/performance feature; configure the
Akamai connection and Purge pipeline.

---

- Purge Akamai CDN cache.
- Invalidate cached content on change.
- Integrate with the Purge module.
- Use core-tags queuer + processor.
- Serve fresh content after edits.
- Store Akamai credentials as secrets.
- Scope credentials least-privilege.
- Provide Drush commands.
- Provide its own permissions.
- Target GovCMS/Akamai sites.
- Keep the CDN in sync.
- Configure the Akamai connection.
- Purge on content update.
- Invalidate CDN objects.
- Handle credentials securely.
- Front Drupal with Akamai.
- Configure the Purge pipeline.
- Support Australian gov sites.
- Manage CDN invalidation.
- Call the Akamai purge API.
