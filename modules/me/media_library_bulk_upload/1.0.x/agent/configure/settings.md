<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — limit bulk-uploadable media types

**Settings form:** route `media_library_bulk_upload.settings` at
`/admin/config/media/media-library-bulk-upload-config` (menu link under Config → Media,
`configure` route in info.yml). Gated by the core **`administer media`** permission.

**Config object:** `media_library_bulk_upload.settings` — a single key:

| Key | Type | Meaning |
|---|---|---|
| `media_types` | sequence of media-type ids | Media types offered on the bulk-upload landing page. **Empty = all media types are offered.** |

The install default is empty (`media_types: {}`), so out of the box every media type is
bulk-uploadable (subject to permissions). The form renders a checkboxes element of all
media bundles; checked boxes are stored. Note the checkboxes element stores **unchecked**
boxes as `0`, so a saved value can look like `{ image: image, document: document, video: 0, audio: 0, remote_video: 0 }` — a type is "enabled" only when its value is truthy (equal to its id).

## How the value is used

- `listUpload()` (the landing page) loads `media_types`; if empty it loads **all** media types, otherwise only the listed ids, then filters each by `accessForm()`.
- `accessForm()` returns **forbidden** if `media_types` is non-empty and the requested type is not in it (message: "Media type X is not enabled for bulk upload."); otherwise it defers to the per-type permission.

## Read / set with drush

```bash
# Read current restriction
drush config:get media_library_bulk_upload.settings media_types

# Restrict to only Image + Document
drush config:set media_library_bulk_upload.settings media_types.image image -y
drush config:set media_library_bulk_upload.settings media_types.document document -y

# Restore "all types" (clear restriction) — set the whole key to an empty map
drush php:eval '\Drupal::configFactory()->getEditable("media_library_bulk_upload.settings")->set("media_types", [])->save();'
```

There is nothing else to configure — the module has no other settings.
