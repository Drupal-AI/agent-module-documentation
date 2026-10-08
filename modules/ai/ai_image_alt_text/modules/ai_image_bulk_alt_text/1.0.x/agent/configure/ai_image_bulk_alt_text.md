# The bulk alt-text form

## Access

Route `ai_image_bulk_alt_text.fix_alt_text` →
`/admin/config/media/ai_image_bulk_alt_text` (menu: **Config → Media → Bulk Generate Alt
Text with AI**). Permission: **`batch fix ai images alt text`**. Form class
`Drupal\ai_image_bulk_alt_text\Form\AltTextFixer`. There is **no settings page** — this
submodule only provides this working form. Provider/model, prompt and image style all come
from the parent `ai_image_alt_text` module's config.

## What it lists

On build the form:

1. Walks every **content** entity type + bundle (`getEntityTypes`, `getImageFields`) and
   collects **image fields whose `alt_field` setting is enabled** (checked via the field's
   `field.field.*` config).
2. Loads entities with those fields and gathers items whose `alt` is **empty** and that have
   a referenced file (`getEntitiesAndFields`), capped at **50** per page load.

If nothing is missing, the form just shows "You are good! No image fields found with missing
alt text."

## Each row

Rendered as a `table` element, one row per missing image:

- **Image** — thumbnail (`image_style` `large`).
- **Entity** — first 30 chars of the owning entity label + the field machine name.
- **New Alt Text** — an editable `textarea` (class `alt-text-<unique_id>`).
- **Actions** — a per-row "Generate with AI" button carrying `data-file-id`,
  `data-unique-id`, and `data-entity-language` (the entity's langcode).
- Hidden fields per row: `base_entity_id`, `base_entity_type`, `field`.

A top **"Bulk Generate Alt Text with AI"** button plus the attached
`ai_image_bulk_alt_text/suggest` JS library (`js/suggest.js`) triggers generation for the
rows, reusing the parent module's generate route (AI Core `chat_with_image_vision`). Results
populate the textareas; a per-row loader is shown while generating.

## Saving

Nothing is written until **"Save changes"** (`submitForm`). For each row with a non-empty
`suggested_alt_text`, it loads the entity, sets `$entity->{field}->alt`, and saves, then
reports "@count alt text fields have been updated." Human-in-the-loop: you can edit or clear
any suggestion before saving.

## Permission

| Permission | Gates |
|---|---|
| `batch fix ai images alt text` | Access to the bulk form and saving. |

(Generating each suggestion also relies on the parent module's `generate ai alt tags` route.)
