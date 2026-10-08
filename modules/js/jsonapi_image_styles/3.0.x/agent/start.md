<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Image Styles — agent index

Exposes image-style derivative URLs on JSON:API `file--file` resources via a computed
`image_style_uri` base field on every File entity. An optional allow-list
(`jsonapi_image_styles.settings.image_styles`) limits which styles are exposed; empty = all.
No permissions of its own, no Drush, no config schema, no public plugin types.

- **Configure which styles are exposed (settings form + config key)** →
  [configure/settings.md](configure/settings.md)
- **The `image_style_uri` field: what it adds, response shape, how to consume it** →
  [api/image-style-uri-field.md](api/image-style-uri-field.md)

Key facts:
- Config object: `jsonapi_image_styles.settings`, key `image_styles` (checkboxes map). Empty/all-unchecked ⇒ every image style exposed.
- Settings route `jsonapi_image_styles.settings` at `/admin/config/services/jsonapi/image_styles`, gated by core permission **Administer image styles**.
- The field only computes values for File entities whose MIME type starts with `image`.
