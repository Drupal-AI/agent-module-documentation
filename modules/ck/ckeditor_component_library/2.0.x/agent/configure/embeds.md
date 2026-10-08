<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure CKEditor Component Library embeds

## Prerequisites
1. Create at least one Component Library pattern with one or more variants.
2. On a CKEditor 5 text format, enable the **Embedded Content** toolbar button and its filter, and save the format.

## Enable & shape embeds
Go to `/admin/structure/component-library/ckeditor-embeds` (needs `administer component library patterns` + `use ckeditor5 embedded content`).

- Toggle which patterns are embeddable.
- For each pattern, the **Embed Config Form Settings** field is a JSON object keyed by the pattern's data properties; each value is a Form API (FAPI) definition applied to that property's embed-form element. Defaults to a textfield per property.

### Examples
```json
{
  "link_text": { "#type": "textfield" },
  "url": { "#type": "url" },
  "html_tag": { "#type": "value" }
}
```
- `"#type": "value"` hides a property from editors while keeping a fixed value (useful to lock a `html_tag` that would otherwise break markup).
- `"#access": false` removes an element from the form.

## Insert
In CKEditor 5, use the **Embedded Content** button, pick a pattern/variant, and fill the exposed properties. Output renders through the `ckeditor_component_library_embed` theme hook.
