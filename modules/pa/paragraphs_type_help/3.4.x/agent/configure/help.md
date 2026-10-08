<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure & create Paragraphs Type Help

No global settings form of key/value config — configuration is data (help entities) plus
enabling the extra field on Paragraph displays.

## Create a help item

UI: `/admin/content/paragraphs-type-help` → *Add Help* (`/admin/content/paragraphs-type-help/add`).
Entity type `paragraphs_type_help`, single bundle `paragraphs_type_help`. Base + Field-UI fields:

| Field | Machine name | Notes |
|---|---|---|
| Paragraph Type | `host_bundle` | entity_reference to `paragraphs_type`, **required**. Where the help shows. |
| Admin label | `label` | Optional; if empty, `preSave()` sets it to the Paragraph type label (`defaultLabel()`). |
| Active Paragraph Form mode | `host_form_mode` | `list_string`, allowed values from `paragraphs_type_help_paragraph_form_mode_options()`. Default `default`. Help shows only on this form mode; `default` = any mode without its own help. |
| Active Paragraph View mode | `host_view_mode` | `list_string`, from `paragraphs_type_help_paragraph_view_mode_options()`. No default. |
| Weight | `weight` | integer; render + list order (lighter = higher). |
| Published | `status` | unchecked = hidden. Only published helps render (`loadPublishedByProperties`). |
| Help text | `help_text` | Field-UI formatted long text (`text_textarea` widget, `text_default` formatter). |
| Help image | `help_image` | Field-UI image field (`image_image` widget, `medium` style display). |

Entity is translatable and revisionable (`show_revision_ui = TRUE`; revision log field present).

Programmatic create:
```php
\Drupal::entityTypeManager()->getStorage('paragraphs_type_help')->create([
  'host_bundle' => 'my_paragraph_bundle',
  'host_form_mode' => 'default',
  'help_text' => ['value' => '<p>Guidance…</p>', 'format' => 'basic_html'],
  'weight' => 0,
  'status' => 1,
])->save();
```
Load helpers on the entity class: `loadPublishedByHostBundle($bundle, $formMode, $viewMode)`,
`loadPublishedByHostDisplay($display)` (form/view display object; falls back to `default` mode).

## Show the help on a Paragraph type

The module adds extra fields `paragraphs_type_help__<help_view_mode>` (label
"Paragraphs Type Help: Rendered as <mode>") to **every** Paragraph bundle via
`hook_entity_extra_field_info()`:
- On the Paragraph **form display** the `default` extra field is visible by default (weight -100).
- On the Paragraph **view display** all extra fields are hidden by default — enable one on the
  Paragraph type's *Manage display* to show help to visitors.

Manage the help entity's own displays/view modes at
`/admin/structure/paragraphs-type-help/...` (Field UI base route
`entity.paragraphs_type_help.admin_form`, path `/admin/structure/paragraphs-type-help`).
An extra field only renders when at least one published help exists for that bundle+mode, so
enabling it site-wide is safe.

## Routes & permissions

Routes (`*.routing.yml`): `entity.paragraphs_type_help.collection` (list, the `configure` route,
perm `manage paragraphs_type_help entity`), `paragraphs_type_help.admin_create`,
`entity.paragraphs_type_help.edit_form` / `.delete_form` (entity access), and
`entity.paragraphs_type_help.admin_form` (settings/Field-UI base, perm
`administer paragraphs_type_help entity`).

Permissions (`paragraphs_type_help.permissions.yml`, both `restrict access: true`):
- `administer paragraphs_type_help entity` — entity-type admin, Field UI, admin settings route.
- `manage paragraphs_type_help entity` — create/edit/delete help items and see the collection.

Access is enforced by `ParagraphsTypeHelpAccessControlHandler`; rendered help also runs
`$help->access('view')` per item.
