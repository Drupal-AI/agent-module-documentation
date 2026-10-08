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
   Browser this field uses (plus optional modal width/height).

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
| `paragraphs_browser.paragraphs_browser_controller` | `/paragraphs_browser/{field_config}/{paragraphs_browser_type}/{uuid}` | AJAX modal returning the paragraph-type picker (perm `access content`) |

The picker controller builds `ParagraphsBrowserForm`, which lists only the paragraph bundles
the current user passes `createAccess` on (via the `paragraph` access control handler) — types
the caller cannot create are dropped from the list. Selecting a type fires an AJAX command
(`paragraphs_browser_add_paragraph`) that hands the chosen bundle name to the host field
widget's hidden add-select; the paragraph is then created by the host entity form, not by this
controller.

Menu tabs/actions: "Manage Browsers" and "Configure Groups" tabs are added on the paragraph
type collection/edit; "Add paragraphs browser type" and "Add group" local actions.

## Field widgets

Set on Manage Form Display for an `entity_reference_revisions` (Paragraphs) field:

- `paragraphs_browser` — label "Paragraphs Browser (stable)"; extends the Paragraphs
  `ParagraphsWidget`.
- `entity_reference_paragraphs_browser` — label "Paragraphs Browser Legacy"; extends the
  legacy `InlineParagraphsWidget` (deprecated widget).

Each widget adds settings for which Browser Type it uses (`paragraphs_browser`, default `_na`)
plus `modal_width` (default `80%`) and `modal_height` (default `auto`). The widget attaches
the `paragraphs_browser/modal` library (`core/drupal.dialog.ajax`, `core/once`, plus the
module's JS/CSS).

## Per-paragraph-type settings

`hook_form_alter` on the paragraph type edit form adds a "Paragraphs Browser Settings"
fieldset containing an **Image Settings** sub-fieldset:

- `image_path` — preview image shown on the browser card. Accept a path relative to the
  Drupal root or a public-file path; the module validates it (`paragraphs_browser_image_path_validate`)
  and prepends `public://` when needed. A `file` upload field copies an uploaded image
  (png/gif/jpg/jpeg/apng/svg) to `public://` and stores its path. Falls back to the
  Paragraphs icon (`getIconUrl()`) if unset. Stored as a third-party setting on the
  `paragraphs_type` entity under provider `paragraphs_browser`.

The card **description** is the paragraph type's own `description` field
(`ParagraphsType::getDescription()`) — configured on the standard paragraph type edit form,
not in this fieldset. (In 1.3.x the description was a separate `paragraphs_browser` third-party
setting; `paragraphs_browser_update_8001` migrates old values into the native description.)

Read the image in code with
`$paragraphs_type->getThirdPartySetting('paragraphs_browser', 'image_path')`.

## Theming

Two theme hooks (override in a theme to restyle the browser):

- `paragraphs_browser_wrapper` — variables: `children`. Template
  `paragraphs-browser-wrapper.html.twig`.
- `paragraphs_browser_paragraph_type` — render element `form`. Template
  `paragraphs-browser-paragraph-type.html.twig` (the per-type card: legend label, icon,
  description, add button).
