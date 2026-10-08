# Configure — Paragraphs Library

## Entity
`paragraphs_library_item` — a revisionable content entity (`Drupal\paragraphs_library\Entity\LibraryItem`,
`LibraryItemInterface`) wrapping a single reusable paragraph. Overview (Views) at
`admin/content/paragraphs` (`entity.paragraphs_library_item.collection`). Revision routes:
version history, view/revert/delete a revision (all require `administer paragraphs library`).

## Reuse workflow
1. Enable the module (pulls in `views` + `entity_usage`).
2. A **From library** paragraph type is provided; add it to your paragraphs field's allowed
   types so editors can insert a library item.
3. Promote a paragraph into the library, then reference it anywhere. Editing the library item
   updates every placement. Entity Usage tracks where each item is referenced.
4. Optionally install **Entity Browser** for a nicer picker (suggested, not required).

## Settings
Form at `/admin/config/content/paragraphs_library_item` (route
`paragraphs_library_item.settings`, form `LibraryItemSettingsForm`). Per-paragraph-type
third-party setting `allow_library_conversion` (schema
`paragraphs.paragraphs_type.*.third_party.paragraphs_library`) controls which types may be
converted into library items.

## Permissions (`paragraphs_library.permissions.yml`)
| Permission | Gates |
|---|---|
| `administer paragraphs library` | Manage the library, revisions, and settings. |
| `create paragraph library item` | Create library items. |
| `edit paragraph library item` | Edit library items. |

## Access caveat
A library item has no parent, so its access check forwards to the referenced paragraph's
*enabled* state only — it does **not** inherit the host entity's access. Treat library items
as broadly viewable; don't rely on them to hide host-restricted content.
