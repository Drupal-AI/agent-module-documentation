Imce is a web-based file manager for Drupal that lets users browse, upload, delete, resize and organize files in per-role, per-user personal folders, and plugs into CKEditor 5, BUEditor and file fields as a file/image browser.

---

Imce exposes a JavaScript file browser (at `/imce/{scheme}`) whose behavior is governed by **configuration profiles** — config entities (`imce.profile.*`) that define allowed file extensions, maximum file size, disk quota, image width/height limits, thumbnail styles, and a tree of folders each with granular permissions (browse, upload, delete, resize, create subfolders, etc.). Profiles are assigned to user roles on the settings page (`/admin/config/media/imce`), and folder paths may contain tokens like `users/user[user:uid]` to give every member a private personal folder. Access and every file operation are routed through IMCE plugins (the `ImcePlugin` plugin type in `Plugin/ImcePlugin`): core plugins provide upload, delete, new-folder and resize operations, and third parties can add their own. Imce integrates with the text-editor image and link dialogs (CKEditor 5 and BUEditor) and with file-field widgets via third-party widget settings, so editors can pick existing server files instead of re-uploading. A static `Imce` façade class offers a programmatic API (access checks, directory scanning, file-entity creation, filename validation) for custom code. It ships permissions, config schema, Twig templates for its page and help screens, and role-to-profile mapping, but no Drush commands. It is a long-standing, near-ubiquitous building block for sites that need server-side file management beyond core's upload widgets.

---

- Give every authenticated user a private personal folder such as `users/user[user:uid]`.
- Let editors browse and pick an existing image from a CKEditor 5 image dialog instead of re-uploading.
- Add a server file browser to the CKEditor 5 link dialog for linking to documents (PDFs, etc.).
- Provide a file/image browser for BUEditor.
- Attach an "Open File Browser" button to a file- or image-field widget so users choose existing files.
- Restrict which file extensions a role may upload (e.g. `jpg png gif pdf`).
- Enforce a maximum upload size per profile (e.g. 2 MB).
- Enforce a per-user disk quota (e.g. 50 MB).
- Constrain uploaded images to a maximum width/height, auto-resizing on upload.
- Let users resize existing images from within the browser.
- Allow users to create and delete subfolders inside their allowed directories.
- Give different roles different profiles (e.g. a generous profile for editors, a limited one for members).
- Grant browse-only access to a shared folder while allowing upload elsewhere.
- Expose a per-user file browser tab on user profile pages.
- Serve private-scheme files through Imce with access control via `hook_file_download`.
- Generate thumbnail previews in the browser using a configured image style.
- Reject files whose names contain invalid characters via the IMCE filename validator.
- Build a media library-like picker for a custom module using the `Imce` façade API.
- Programmatically scan a directory and list its files/subfolders with `Imce::scanDir()`.
- Create file entities for pre-existing files on disk with `Imce::getFileEntity()`.
- Check whether the current user may access a given file URI in custom code.
- Add a brand-new file operation (e.g. "rename" or "zip") by writing an ImcePlugin.
- Add extra folder-permission types through a plugin's `permissionInfo()`.
- Deploy file-manager configuration between environments as exportable config entities.
- Use absolute URLs for selected files when integrating with an external/headless consumer.
- Force Imce pages to render in the admin theme for a consistent back-office look.
- Offer a multi-file upload queue with progress for bulk uploads.
- Localize/deploy role-to-profile assignments as part of `imce.settings`.
- Duplicate an existing profile as a starting point for a new one.
