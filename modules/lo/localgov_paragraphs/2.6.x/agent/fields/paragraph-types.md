<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraph types shipped by localgov_paragraphs

All behavior is installed `config/install/*` — no PHP defines these. Five `paragraphs.paragraphs_type.*`
bundles, their `field.storage.*` / `field.field.*` and default `core.entity_form_display.*` /
`core.entity_view_display.*`. Entities are `paragraph`; add or override fields with Field UI like any bundle.
`localgov_numbered_text` is also (re)installed programmatically by `localgov_paragraphs_update_9004()` if
missing.

| Type (id) | Label | Description | Notable config |
|---|---|---|---|
| `localgov_text` | Text | Rich text (WYSIWYG) section. | — |
| `localgov_image` | Image | Image with caption. | — |
| `localgov_link` | Link | Promoted button-style link. | — |
| `localgov_numbered_text` | Numbered text | Numbered rich text (WYSIWYG) section. | reuses the `localgov_text` field |
| `localgov_contact` | Contact | (no description) | `paragraphs_library.allow_library_conversion: true` (can be saved to the Paragraphs library) |

## Fields per type

Field name = `field.storage.paragraph.<name>`; all `translatable: true`, none `required`, cardinality 1
unless noted.

### localgov_text
| Field | Type | Form widget | View formatter |
|---|---|---|---|
| `localgov_text` (Text) | text_long | text_textarea | text_default |

### localgov_image
| Field | Type | Form widget | View formatter |
|---|---|---|---|
| `localgov_image` (Image) | entity_reference → `media` (target bundle `image`) | media_library_widget | entity_reference_entity_view (view_mode `default`) |
| `localgov_caption` (Caption) | text_long | text_textarea | text_default |

### localgov_link
| Field | Type | Form widget | View formatter |
|---|---|---|---|
| `localgov_title` (Title) | string | string_textfield | string |
| `localgov_url` (URL) | string | string_textfield | string |
| `localgov_link_style` (Link style) | list_string — allowed value `button` → "Button" | options_select | list_key |

Note: `localgov_url`/`localgov_title` are plain `string` fields, not core `link`.

### localgov_numbered_text
| Field | Type | Form widget | View formatter |
|---|---|---|---|
| `localgov_numbered_text_number` (Number) | string | string_textfield | string |
| `localgov_text` (Text) | text_long (shared storage with `localgov_text` type) | text_textarea | text_default |

### localgov_contact
16 fields. Form display groups them with `field_group` into **vertical tabs** (group `group_contact_tabs`,
`format_type: tabs`, `direction: vertical`): Telephone, Email and website, Social media, Office address and
hours, Location, Description. `localgov_paragraphs_update_9002()` exists only to force that tab direction
back to vertical on sites upgraded from an old release.

| Field | Type | Label | Notes |
|---|---|---|---|
| `localgov_contact_heading` | string | Heading | |
| `localgov_contact_subheading` | string | Subheading | |
| `localgov_contact_phone` | telephone | Phone | |
| `localgov_contact_mobile` | telephone | Mobile | |
| `localgov_contact_minicom` | telephone | Minicom | |
| `localgov_contact_out_of_hours` | telephone | Out of hours | |
| `localgov_contact_email` | email | Email | |
| `localgov_contact_url` | link | Contact us online URL | |
| `localgov_contact_other_url` | link | Other URL | |
| `localgov_contact_twitter` | link | Twitter | |
| `localgov_contact_facebook` | link | Facebook | |
| `localgov_contact_instagram` | link | Instagram | |
| `localgov_contact_other_social` | link | Other social media URLs | multi-value (cardinality -1) |
| `localgov_contact_office_hours` | office_hours | Office hours | multi-value (cardinality -1); provided by the `office_hours` module |
| `localgov_contact_address` | address | Address | provided by the `address` module |
| `localgov_contact_location` | geolocation | Location | provided by the `geolocation` module |

`localgov_contact_office_hours` field storage is re-saved by `localgov_paragraphs_update_9003()` to pick up
an office_hours schema change.

## Adding your own field
These are ordinary paragraph bundles. Add a field via Field UI, or in code:
```php
\Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'my_field', 'entity_type' => 'paragraph', 'type' => 'string',
])->save();
\Drupal\field\Entity\FieldConfig::create([
  'field_name' => 'my_field', 'entity_type' => 'paragraph', 'bundle' => 'localgov_text',
  'label' => 'My field',
])->save();
```

## Where each type is usable
The bundles are just paragraph types; a host entity references them through a `entity_reference_revisions`
(paragraphs) field defined elsewhere in the LocalGov distribution. This module only supplies the component
library — richer components (accordion, tabs, quote, key facts, media-with-text, etc.) and any JS behaviour
live in the submodules, not here (see start.md).
