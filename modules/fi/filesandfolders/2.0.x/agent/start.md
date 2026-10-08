<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Files and Folders — agent orientation

D9/D10 custom file manager. On-disk dir `filesandfolders`; real machine name `files_and_folders`. Node-based (`folder`/`file` bundles) with parent-folder refs, role-based access via `field_authorized_roles`, and many AJAX routes in `files_and_folders.routing.yml` -> `src/Controller/FileFolderController.php`.

Key routes: `files_and_folders.upload_files` (`FileFolderController::uploadFiles()`, writes to `public://files_and_folders/`) and `files_and_folders.download_file` (`FileFolderController::downloadFile()`, streams the file via `BinaryFileResponse`).

Note: the access model relies on `field_authorized_roles` intersection with the user's roles.
