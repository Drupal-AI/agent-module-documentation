<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Garden Gnome Package (garden_gnome_package) — agent index

**Embeds Pano2VR / Object2VR panoramas & object movies from uploaded package archives.**

- **Version:** 1.0.x  | **Core:** ^8 || ^9 || ^10  | **Package:** Custom
- **Depends:** field, media, system.
- **Configure:** `/admin/config/media/garden_gnome_package` (route `garden_gnome_package.admin_settings`, perm `administer site configuration`).
- **Field type:** GgnomeField; **formatter:** GgnomeFieldFormatter. On save, `GGPackage::getExtractedPackage()` unzips the uploaded package (core `Zip` archiver) into the **public files** dir, parses `gginfo.json`, copies the pano/object player into a versioned public dir.

**Security note:** user-uploaded ZIP archives are extracted whole into the web-accessible public files directory with no file-type restriction (`GGPackage.php:138-139`), then player JS is written there. Dangerous-archive handling / possible zip-slip depending on the core archiver; combined with a server that executes PHP from files/, a malicious package could be a code-exec vector. Requires privilege to create package field values (trusted editors) — restrict that permission. D2-level, incidental.
