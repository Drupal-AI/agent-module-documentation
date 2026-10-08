<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# fylr File Picker (easydb) — agent index
**Entity Browser widget that copies files + metadata from a fylr/easydb DAM into Drupal `easydb_image` media.**

- **version:** 2.1.x
- **core:** ^10.3 || ^11
- **depends on:** entity_browser, media, file, image, node, views, path
- **configure:** `easydb.settings` → `/admin/config/media/easydb` (`administer easydb`)
- **routes:** `/admin/config/media/easydb` (`administer easydb`); `/easydb/import/{eb_uuid}` (POST/OPTIONS, `_access: 'TRUE'`).
- **plugin/element:** `Plugin/EntityBrowser/Widget/Easydb`, `Element/EasydbFile`; `EasydbCorsSubscriber` (origin-restricted CORS); `ImportFilesController::handleRequest`.
- **permissions:** `access easydb`, `administer easydb`.
- **Access:** the `_access: 'TRUE'` import route is enforced in-controller — requires an authenticated user (uid>0) **and** a valid `eb_uuid` from that user's private tempstore (`ImportFilesController.php:138-153`); CORS reflects only configured origins. The import downloads the fylr-supplied file `url` via cURL (`ImportFilesController.php:333-339`) with default TLS verification.

See [configure/setup.md](configure/setup.md)
