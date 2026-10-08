<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Paragraphs Browser

No global settings form; there is no `configure` route in `paragraphs_browser.info.yml`.
Configuration is done through the Browser Type config entity, per-paragraph-type settings,
and per-field widget settings. All admin routes are gated by the **`administer paragraphs
types`** permission (provided by the `paragraphs` module).

> Note: the `paragraphs_browser_type` entity annotation declares
> `admin_permission = "administer paragraphs browser"`, but the module ships **no
> `*.permissions.yml`**, so that permission is never defined. Every route in
> `paragraphs_browser.routing.yml` actually requires `administer paragraphs types`.

## Setup flow (from README)

1. **Add a Browser** — Structure » Paragraph Types » Manage Browsers → Add. Broad buckets
   (e.g. Layouts, Media).
2. **Add Groups** to a browser — finer filters within it (e.g. Single-Column, Multi-Column).
3. **Assign paragraph types to groups** — Structure » Paragraph Types » [type] » Configure
   Groups.
4. **Enable the widget** — on a content type's Paragraphs (entity_reference_revisions) field,
   Manage Form Display → set widget to a Paragraphs Browser widget → gear icon → pick which
   Browser this field uses.

## Config entity: `paragraphs_browser_type`

Config prefix `paragraphs_browser_type`; config name
`paragraphs_browser.paragraphs_browser_type.{id}`. Exported keys (`config_export`):

- `id` — machine name.
- `label` — human label.
- `groups` — sequence of groups, each `{ label, weight }` keyed by group machine name
  (sorted by weight on save).
- `map` — sequence of `paragraph_type_id: group_machine_name` assignments.

Default install ships one browser type `content` (label "Content", empty groups) at
`config/install/paragraphs_browser.paragraphs_browser_type.content.yml`.

Example exported config:

```yaml
langcode: en
status: true
dependencies: {  }
id: layouts
label: Layouts
groups:
  single_column:
    label: 'Single Column'
    weight: 0
  multi_column:
    label: 'Multi Column'
    weight: 1
map:
  one_column: single_column
  three_column: multi_column
```

Manage via Drush: `drush config:get paragraphs_browser.paragraphs_browser_type.layouts`,
`drush config:set …`, or `drush config:import`.

## Routes (verified against paragraphs_browser.routing.yml)

| Route name | Path | Purpose |
|---|---|---|
| `entity.paragraphs_browser_type.collection` | `/admin/structure/paragraphs_type/browsers` | List browser types (Manage Browsers tab) |
| `paragraphs_browser.type_add` | `/admin/structure/paragraphs_type/browsers/add` | Add browser type |
| `entity.paragraphs_browser_type.edit_form` | `/admin/structure/paragraphs_type/browsers/{paragraphs_browser_type}/edit` | Edit browser type |
| `entity.paragraphs_browser_type.delete_form` | `/admin/structure/paragraphs_type/browsers/{paragraphs_browser_type}/delete` | Delete browser type |
| `entity.paragraphs_browser_type.groups_form` | `/admin/structure/paragraphs_type/browsers/{paragraphs_browser_type}/groups` | Manage Groups (tempstore) |
| `entity.paragraphs_browser_type.group_add_form` | `/admin/structure/paragraphs_type/browsers/{paragraphs_browser_type}/groups/add` | Add group (tempstore) |
| `paragraphs_browser.paragraphs_browser_type.group_edit_form` | `…/groups/{group_machine_name}/edit` | Edit group |
| `paragraphs_browser.paragraphs_browser_type.group_delete_form` | `…/groups/{group_machine_name}/delete` | Delete group |
| `paragraphs_browser.paragraph_type.group_edit` | `/admin/structure/paragraphs_type/{paragraphs_type}/browsers/groups` | Configure Groups tab on a paragraph type |
| `paragraphs_browser.paragraphs_browser_controller` | `/paragraphs_browser/{field_config}/{paragraphs_browser_type}/{uuid}` | AJAX modal that returns paragraph-type selection (perm `access content`) |

Menu tabs/actions: "Manage Browsers" and "Configure Groups" tabs are added on the paragraph
type collection/edit; "Add paragraphs browser type" and "Add group" local actions.

## Field widgets

Set on Manage Form Display for an `entity_reference_revisions` (Paragraphs) field:

- `paragraphs_browser` — label "Paragraphs Browser EXPERIMENTAL"; extends the Paragraphs
  `ParagraphsWidget`.
- `entity_reference_paragraphs_browser` — label "Paragraphs Browser Classic"; extends the
  legacy `InlineParagraphsWidget`.

Each widget has a setting to choose which Browser Type it uses. The widget attaches the
`paragraphs_browser/modal` library (`core/drupal.dialog.ajax`, `core/once`, plus the module's
JS/CSS).

## Per-paragraph-type settings (third-party settings)

`hook_form_alter` on the paragraph type edit form adds a "Paragraphs Browser Settings"
fieldset that stores third-party settings on the `paragraphs_type` entity under the
`paragraphs_browser` provider:

- `image_path` — preview image shown on the browser card. Accept a path relative to the
  Drupal root or a public-file path; the module validates it and prepends `public://` when
  needed. A `file` upload field copies an uploaded image (png/gif/jpg/jpeg/apng/svg) to
  `public://` and stores its path. Falls back to the Paragraphs icon if unset.
- `description` — short text shown on the browser card.

Read them in code with
`$paragraphs_type->getThirdPartySetting('paragraphs_browser', 'image_path')` /
`'description'`.

## Theming

Two theme hooks (override in a theme to restyle the browser):

- `paragraphs_browser_wrapper` — variables: `children`. Template
  `paragraphs-browser-wrapper.html.twig`.
- `paragraphs_browser_paragraph_type` — render element `form`. Template
  `paragraphs-browser-paragraph-type.html.twig` (the per-type card).
