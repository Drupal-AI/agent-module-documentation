<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File attributes — agent orientation

D9.3/D10 module adding custom anchor attributes to file-field links.

- `hook_field_info_alter()` swaps the core `file` field-type class for `FileAttributesFieldType` (adds `options`/attributes).
- Widget `FileAttributesFieldWidget`, formatter `FileAttributesFieldFormatter` (extends core `GenericFileFormatter`), theme `file_attributes_link`.
- `template_preprocess_file_attributes_link()` builds the link with `Link::fromTextAndUrl()` (escaped) + `Attribute` object.
- Security: attributes are set by editors with field edit access and rendered via Drupal's Attribute/Link API (auto-escaped). No public routes/permissions. No findings.
