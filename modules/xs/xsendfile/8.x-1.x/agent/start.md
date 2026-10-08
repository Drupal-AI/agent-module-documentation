<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Xsendfile — agent index

Serves private files via **X-Sendfile**/**X-Accel-Redirect** instead of PHP. Route subscriber overrides `system.files`, `system.private_file_download`, `image.style_private` with subclasses of core controllers. **Access model preserved** (`hook_file_download()`, image token + SA-CORE-2023-005 `..` guard). Config `/admin/config/media/file-system/xsendfile` (`administer site configuration`). Version **8.x-1.2**, core `^9||^10`. Security-reviewed: sound (faithful core reimplementation).