<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# section_library — configure & data model

Section Library has almost no global configuration. Its "config" is **content**: every
saved section/page is a `section_library_template` content entity. The only settings
form just renames two labels.

## The `section_library_template` content entity

- **Entity type id:** `section_library_template` (a `ContentEntityType`).
- **Base table:** `section_library_template`. Not bundleable, not translatable, not revisionable.
- **Admin permission:** `administer section library template entities`.
- **Collection / manage UI:** `/admin/content/section-library` (route
  `entity.section_library_template.collection`), backed by the `views.view.section_library` view.
- **Links:** canonical/edit/delete under `/admin/content/section-library/{id}`, plus a
  `preview` route `/admin/content/section-library/{id}/preview`.

### Base fields (from `SectionLibraryTemplate::baseFieldDefinitions()`)

| Field | Type | Notes |
|---|---|---|
| `id` | integer | Auto primary key (`entity_keys.id`). |
| `uuid` | uuid | |
| `label` | string | Required, max length **50**. The `entity_keys.label`. |
| `type` | list_string | Allowed values **`section`** and **`template`**. Form region hidden — set in code, not the edit form. |
| `layout_section` | layout_section | **Unlimited cardinality.** The serialized Layout Builder section(s). This is the payload. |
| `image` | image | Optional preview; `public://section_library`, ext `gif png jpg jpeg webp`. |
| `entity_id` | entity_reference | Required. The entity the template was captured from. |
| `entity_type` | string | Required. That entity's type id (e.g. `node`). |
| `user_id` | entity_reference (user) | Author; defaults to current user via `preCreate()`. |
| `created` / `changed` | created / changed | Timestamps. |

`type` distinguishes a **single** captured section (`section`) from a **whole-page**
capture of every section (`template`). The library picker filters by this value.

## Save & reuse flow (UI)

1. Enable Layout Builder on a display and edit a layout (`/…/layout`).
2. Each section shows a **"Add section to library"** link → route
   `section_library.add_section_to_library` → `AddSectionToLibraryForm`. It saves the
   current section (`type = section`) or all sections (`type = template`) with your label
   and optional image.
3. In another layout, **"Choose template from library"** (route
   `section_library.choose_template_from_library`,
   `ChooseSectionFromLibraryController`) opens the Views picker filtered to the matching type.
4. Picking one hits `section_library.import_section_from_library`
   (`ImportSectionFromLibraryController`), which **deep-clones** the stored sections into
   the target layout (see api/section_library.md).

## Settings form (the only real config)

- Route `section_library.admin_index` at **`/admin/config/content/section-library`**
  (`SettingsForm`). This is the module's `configure` route.
- Config object **`section_library.settings`** with two keys, both required labels:
  - `section_label` (default **`Section`**)
  - `template_label` (default **`Template`**)
- These only relabel the UI ("Add Section" / "Add Template" buttons, titles). They do **not**
  change the `type` field's stored values (`section`/`template`).
- Read/set via drush:
  ```
  drush config:get section_library.settings
  drush config:set section_library.settings template_label 'Page layout' -y
  ```

## Requirements & recommendations

- Hard deps: `layout_builder`, `image`, `options`, `views`.
- Recommended: **Layout Builder iFrame Modal** — swaps the narrow off-canvas tray for a
  modal so the library picker is larger.
- Content-based, so it does **not** overlap the config-based *Layout Builder Library* module;
  both can run together.
