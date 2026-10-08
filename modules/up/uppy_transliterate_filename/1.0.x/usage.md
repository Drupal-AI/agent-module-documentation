<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Uppy Transliterate Filename cleans up filenames of files uploaded through the Uppy uploader by stripping special characters client-side before upload.
---
The module attaches JavaScript that overrides the Uppy uploader's filename handling (via `drupalSettings.uppyOverrides`) to normalise each name: whitespace becomes hyphens, characters outside `[0-9A-Za-z_.-]` are removed, repeated `_`/`.`/`-` are collapsed, and the name is lowercased to avoid case-insensitive filesystem collisions. This prevents problematic filenames (accents, spaces, unsafe symbols) from reaching the server. There is no admin UI — enabling the module and using an Uppy-powered upload widget is all that is required.

Note: the module currently depends on a patch to `drupal/uppy` (issue 3487091) that fixes an override-overwrite bug, and requires `drupal/uppy ^3.0.1`. Setup: ensure Uppy (patched) is installed, enable this module, and uploads through Uppy will have transliterated filenames automatically.
---
- Transliterate filenames of Uppy-uploaded files.
- Replace spaces in filenames with hyphens.
- Strip accented/special characters from uploaded filenames.
- Remove characters outside `[0-9A-Za-z_.-]`.
- Collapse repeated underscores, hyphens and periods.
- Lowercase filenames to avoid case-collision issues.
- Sanitize names before files hit the server.
- Keep media filenames URL- and filesystem-safe.
- Apply consistent naming to all Uppy uploads.
- Avoid broken links from problematic filenames.
- Integrate with an existing Uppy upload widget.
- Prevent duplicate files differing only by case.
- Improve portability across case-insensitive filesystems.
- Clean names from non-Latin scripts on upload.
- Reduce manual filename fixups for editors.
- Override Uppy filename handling via drupalSettings.
- Support Drupal 10 and 11 media workflows.
- Standardise asset naming for CDNs.
- Work automatically with no configuration.
- Pair with the required uppy patch for correct overrides.
