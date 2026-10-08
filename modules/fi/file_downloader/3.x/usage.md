<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Downloader adds a configurable field formatter that exposes one or more download links per file/image field value, using a small plugin system so each link can serve a different variant of the file.

---

Install the module (`ddev drush en file_downloader`; it depends on core's **File** module) and go to **Configuration → Media → Download Options** (`/admin/config/media/download_options`) to create one or more **Download Option Config** entities. Each one picks a *download-option plugin* — `Original File` serves the stored file unchanged, `Image Style` serves a selected image-style derivative — plus an optional list of **allowed file extensions** (space/comma separated, no leading dot; leave empty to allow all). The plugin choice is fixed once the entity is saved, so create a new option if you need a different plugin. Next, on a `file` or `image` field's **Manage display**, choose the **File Downloader** formatter and tick which download options to expose; when the field renders, each ticked option becomes a link (or, if the file/derivative is missing, a plain disabled label) pointing at `/download/{option}/{file}`. Access to a link is controlled per option: grant the generated **`use {id} download option link`** permission (People → Permissions) to the roles that should be able to download, and note that a download additionally requires the user's normal permission to view the underlying file and, if you set an extension list, a matching file extension. The three shipped Twig templates (`file-download-link`, `file-download-disabled`, `file-download-list`) are intentionally minimal, so override them in your theme to control the markup. To add your own variant (for example a watermarked or converted copy), write a `DownloadOption` plugin in `src/Plugin/DownloadOption/`.

---

- Add a download link to a file field's display.
- Expose several download options for one file.
- Offer an "original file" download.
- Offer an image-style (resized) download.
- Restrict a download option to certain file extensions.
- Allow all extensions by leaving the extension list empty.
- Create a Download Option Config at Configuration → Media → Download Options.
- Pick the download-option plugin when creating an option.
- Select an image style for an `image_style` option.
- Enable options on the File Downloader field formatter.
- Show download options on an image field.
- Show download options on a file field.
- Control who can download via the per-option permission.
- Require the viewer's normal file-view access before download.
- Hide options a user is not permitted to use.
- Show a disabled label when a file or derivative is missing.
- Theme the download link markup with the shipped templates.
- Theme the download list wrapper.
- Add a custom download variant with a `DownloadOption` plugin.
- Serve a converted-format copy of an uploaded file.
- Provide high-resolution and low-resolution download links side by side.
- Migrate from the older File Download module to multiple options.
- Rename or relabel an option's link text via its label.
- Delete a download option you no longer need.
