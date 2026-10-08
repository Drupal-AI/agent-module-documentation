<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `me_template` entity & template flow

## Entity type

`me_template` is a **content entity** (`ContentEntityType`), revisionable and owner-tracked:

- base table `me_template`, data table `me_template_field_data`, revisions
  `me_template_revision` / `me_template_field_revision` (`show_revision_ui = FALSE`).
- entity keys: `id`, `revision`=`vid`, `label`, `uuid`, `owner`=`uid`.
- `admin_permission = "access mercury editor template overview"`.
- `field_ui_base_route = entity.me_template.settings` — so you can add fields via Field UI.

It stores a saved Layout Paragraphs section (the duplicated component tree). There is **no
config schema** — templates are content, created at runtime, not exported config.

## Routes & paths

| Route | Path | Purpose / permission |
|---|---|---|
| `entity.me_template.collection` | `/admin/content/me-template` | List templates (overview). |
| `entity.me_template.add_form` | `/me-template/add` | Create a template. |
| `entity.me_template.canonical` | `/me-template/{me_template}` | View. |
| `entity.me_template.edit_form` | `/me-template/{me_template}/edit` | Edit. |
| `entity.me_template.delete_form` | `/me-template/{me_template}/delete` | Delete. |
| `entity.me_template.settings` | `/admin/structure/me-template` | Bundle settings / Field UI base (perm: administer mercury editor template). |
| `mercury_editor_templates.save_as_template` | `/admin/mercury-editor/save-as-template/{layout_paragraphs_layout}/{uuid}` | Save the selected component as a template (perm: create mercury editor template). |
| `mercury_editor_templates.insert_template` | `/mercury-editor-templates/{layout_paragraphs_layout}/insert/{me_template}` | Insert a template into the layout (perm: use mercury editor templates). |

## How templates reach the builder menu

`LayoutParagraphsAllowedTypesSubscriber` listens on
`LayoutParagraphsAllowedTypesEvent`: for a user with **"use mercury editor templates"**, it
loads all **published** (`status = 1`) `me_template` entities and adds them to the allowed
component types shown in Mercury's "add component" menu (subject to the layout's
`nesting_depth`). Unpublished templates are hidden.

## Scripting

```php
// Count / load published templates:
$ids = \Drupal::entityTypeManager()->getStorage('me_template')
  ->getQuery()->condition('status', 1)->accessCheck(FALSE)->execute();

// Create a bare template entity (normally created via Save-as-template):
$t = \Drupal::entityTypeManager()->getStorage('me_template')->create(['label' => 'Hero']);
$t->save();
```

```bash
drush php:eval 'print count(\Drupal::entityTypeManager()->getStorage("me_template")->loadMultiple());'
```

Uninstalling the submodule removes the `me_template` tables and all saved templates.
