<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — settings form & config keys

- Route/UI: `/admin/config/media/media_link_enhancements` (`media_link_enhancements.settings`),
  permission `administer_media_link_enhancements`. Form: `MediaLinkEnhancementsAdminForm` (extends `ConfigFormBase`).
- Config object: `media_link_enhancements.settings` (all keys below; edit with `drush cset`).
- Prerequisite: enable core Media's **Standalone media URL** (`media.settings:standalone_url`); the form warns if off.
- Extension lists are comma-separated strings (case-insensitive); empty = all extensions. Bundle lists are
  arrays of media type machine names (a `checkboxes` map).

The five features are independent; each has an `enable_*` flag (default `0`).

## Direct linking
Rewrites media anchors (on rendered link fields and in parsed content) to the source file path.
- `enable_direct_linking` (bool)
- `direct_linking_bundles` (array of media bundle machine names)
- `direct_linking_extensions` (string, e.g. `pdf,doc,txt`)
- `direct_linking_download_attr` (bool) — add `download="<filename>"`
- `direct_linking_download_attr_extensions` (string)

## Type/size appending (508 accessibility)
Appends ` <prefix><ext><separator><size><suffix>` to link text, e.g. ` [PDF/12KB]`.
- `enable_type_size_appending` (bool)
- `type_size_appending_bundles` (array; **file-based bundles only**: source plugin in `audio_file`,`file`,`image`,`video_file`)
- `type_size_appending_prefix`, `type_size_appending_separator`, `type_size_appending_suffix` (strings)
- `type_size_appending_uppercase` (bool)
- `type_size_appending_extensions` (string)

## Redirection
At the media canonical route, 303-redirect `/media/{id}` to the source URL. Takes precedence over binary response.
- `enable_redirect` (bool)
- `redirect_bundles` (array)
- `redirect_extensions` (string)

## Binary response
At the media canonical route, stream the source file inline (`BinaryFileResponse`, `DISPOSITION_INLINE`).
- `enable_binary_response` (bool)
- `binary_response_bundles` (array; file-based bundles only)
- `binary_response_extensions` (string)

## Content parsing
DOM-parses configured text fields and applies direct-linking + type/size to media links inside them.
- `enable_content_parsing` (bool)
- `content_parsing_field_types` (array of field type machine names; UI offers only the "Text" category, e.g. `text_long`, `text_with_summary`)
- Note: HTML entities in anchor text (e.g. `&nbsp;`) are not supported and prevent replacement for that link.

After changing settings the form advises clearing cache (`drush cr`) for some changes to take effect.
