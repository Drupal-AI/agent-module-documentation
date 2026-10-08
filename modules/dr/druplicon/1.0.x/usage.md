<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Druplicon lets an administrator replace the Druplicon logo in the Admin Toolbar with a custom uploaded image.
---
The module adds one settings form at `/admin/config/druplicon/settings` (route `druplicon.settings`, permission `administer site configuration`) with a `managed_file` upload that stores the uploaded file id in `druplicon.settings:druplicon_fid`. On menu preprocessing, `druplicon_preprocess_menu()` detects the `admin` menu, loads the configured file, generates its URL, attaches the `druplicon/druplicon` library, and passes the image path to JS via `drupalSettings` so the toolbar logo is swapped client-side.

Upload validation restricts extensions to `png jpeg jpg jpe webp svg`. Because `svg` is permitted and SVG files can embed scripts, only trusted administrators (already holding `administer site configuration`) should use this form; serve the public files directory with appropriate headers if that is a concern. Setup: enable (depends on `admin_toolbar`), open the settings form, upload an image, and save.
---
- Replace the default Druplicon toolbar logo with a company logo.
- Upload a PNG/JPG/WebP/SVG image from the settings form.
- Brand the admin toolbar per environment (e.g. distinct logo for staging).
- Store the chosen image as a managed file referenced by config.
- Swap the toolbar logo client-side via drupalSettings and a JS library.
- Limit who can change the logo with `administer site configuration`.
- Remove branding by clearing the uploaded file.
- Provide a visual cue distinguishing production from non-production admin.
- Use the admin_toolbar module's menu as the injection point.
- Keep the uploaded file under `public://druplicon/`.
- Review SVG upload risk before allowing it on multi-admin sites.
- Attach the `druplicon/druplicon` asset library only on admin menu render.
- Export the `druplicon.settings` config between environments.
- Confirm the logo updates after clearing caches.
- Combine with a custom admin theme for full rebranding.
- Restrict the settings route to site administrators only.
- Verify the managed file is not deleted by file garbage collection.
- Translate the settings form labels.
- Disable the module to restore the default toolbar logo.
- Audit that only trusted roles can upload images here.
