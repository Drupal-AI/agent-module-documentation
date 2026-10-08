<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibcite Import OAI (bibcite_import_oai) — agent index
**Imports Bibcite references from OAI-PMH / DSpace repositories via admin-configured ListRecords URLs.**

- **Version:** 1.1.x
- **Core:** ^10 || ^11
- **Depends:** bibcite:bibcite
- **Configure:** `/admin/bibcite_import_oai/config` (`bibcite_import_oai.admin_settings`)
- **Import UI:** `/admin/oai-import/import` (`bibcite_import_oai.index`)
- **Drush:** `oai-import:import --url="..."`
- **Service:** `bibcite_import_oai.importer` (`\Drupal\bibcite_import_oai\Model\Import`)
- **Cron:** `hook_cron` re-imports all URLs when "Update daily" is enabled.

**Security:** Server-side cURL fetch of admin-configured URLs only (no request-supplied fetch URL → no unauthenticated SSRF); TLS peer verification left at cURL default (enabled). Routes reference permissions by title, not the declared machine name `import from oai`, so access fails closed until fixed. `extract(curl_getinfo(...))` operates on fixed cURL keys — not a vuln.

See [configure/settings.md](configure/settings.md)
