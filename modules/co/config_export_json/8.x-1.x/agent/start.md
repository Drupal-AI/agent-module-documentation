<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Export JSON — agent index

Exports **admin-selected** Drupal config as JSON via REST (`/api/config.json`) and a public file. Version
**8.x-1.x**. Core `^8.8 || ^9 || ^10`. Depends on `config`, `rest`.

NOT a full-config dump by default: only configs an admin lists at `/admin/config/services/config-export-json`
(`administer site configuration`) are included. SECURITY CAUTION (not a clear-cut vuln, admin-gated exposure):
the REST resource gate is only `hasPermission('access content')` — anon-effective — and
`ConfigExportJsonApi::exportJsonFile()` writes `config.json` to the PUBLIC files directory, web-readable with no
access check at all. So anything an admin exposes is effectively public; listing a whole config object
(`name` with no `:key`) exports it entirely. Risk = admin misconfiguration leaking secrets, not an automatic
anonymous full-config disclosure. Advise: never expose configs containing keys/tokens; add a dedicated
permission. `ConfigForm.php`, `Service/ConfigExportJsonApi.php`, `Plugin/rest/resource/ConfigJsonRestResource.php`.
