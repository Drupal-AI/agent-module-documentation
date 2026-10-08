<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — enable the enhanced dialog, categories & display

There is **no `configure` route** in `paragraphs_ee.info.yml`. Configuration happens in two
places: the Paragraphs field widget settings, and the Paragraphs category admin. Install sets
the module weight to 15 (above paragraphs) via `paragraphs_ee_install()` in
`paragraphs_ee.install`.

## 1. Turn the enhanced dialog on (per field widget)

The enhancements only apply to fields using the **Paragraphs (stable)** widget with
**Add mode = Modal form** (`add_mode: modal`). Set this on the entity's *Manage form display*
(the widget's settings gear). When Add mode is modal, `FormHooks::fieldWidgetCompleteFormAlter()`
swaps the add buttons for the `paragraphs_add_dialog__categorized` theme and attaches its
libraries.

### Widget third-party settings (`field.widget.third_party.paragraphs_ee`)

Added to the widget settings form by `FieldHooks::fieldWidgetThirdPartySettingsForm()`
(`src/Hook/FieldHooks.php`), stored under the widget's third-party setting
`paragraphs_ee.paragraphs_ee`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `dialog_off_canvas` | boolean | `false` | Open the picker as a Drupal off-canvas panel instead of a centered modal. Shown/enabled only when Add mode = modal. |
| `dialog_style` | string | `tiles` | How types are shown: `tiles` or `list`. |
| `drag_drop` | boolean | `false` | Show up/down arrows for drag & drop reordering. Shown only when Paragraphs Features' `show_drag_and_drop` is on. |
| `sidebar_disabled` | boolean | `false` | Hide the category sidebar in the dialog. |

The "add in between" quick-access buttons count comes from the **Paragraphs Features** widget
setting `paragraphs_features.add_in_between_link_count` (default `3`) — the first N unique types
are marked `#easy_access` in `FormHooks::fieldWidgetCompleteFormAlter()`. The widget settings
summary line is produced by `FieldHooks::fieldWidgetSettingsSummaryAlter()`.

## 2. Paragraphs categories (config entity `paragraphs_category`)

Admin UI: **Admin → Structure → Paragraphs categories** (`/admin/structure/paragraphs_category`,
route `entity.paragraphs_category.collection`; menu link `paragraphs_ee.links.menu.yml`,
action link `paragraphs_ee.links.action.yml`). Add/edit/delete routes live under the same path.
All are gated by the `administer paragraphs categories` permission.

The collection is a draggable list (`ParagraphsCategoryListBuilder`, form id
`paragraphs_category_admin_overview`) so category **weight** (dialog order) is set by dragging.
Each category is a config entity (`src/Entity/ParagraphsCategory.php`) with `config_export`
keys `id`, `label`, `description` (a `text_format` value: `{value, format}`), and `weight`.
The add/edit form (`ParagraphsCategoryForm`) rejects the reserved machine name `uncategorized`.
Config prefix `paragraphs_ee.paragraphs_category.*`; exports/deploys with `drush config:export`.

### Assign paragraph types to categories

The paragraph type form (`FormHooks::paragraphsTypeFormAlter()`, altering
`paragraphs_type_form`) gains a **Paragraphs categories** checkboxes element. Selections are
stored as the paragraph type's third-party setting `paragraphs_ee.paragraphs_categories` (a
sequence of category IDs) by the entity builder `paragraphsTypeFormBuilder()`; the setting is
removed entirely when nothing is selected. A type can belong to several categories and appears
under each matching tab plus the automatic **All** tab. Types with no (valid) category fall
under **Uncategorized** (`_none`). Empty categories are hidden in the dialog.

### Icons

Tile icons are **not** a paragraphs_ee setting — they are the icon image configured on the
paragraph type itself (`ParagraphsType::getIconUrl()`, read in
`FormHooks::fieldWidgetCompleteFormAlter()`). Types with no icon get a default image
placeholder class; a library of ready-made images ships under `images/library/`.

Config schema: `config/schema/paragraphs_ee.schema.yml` (defines the category entity, the
paragraph-type `third_party.paragraphs_ee.paragraphs_categories` sequence, and the widget
`third_party.paragraphs_ee` settings).

## Update path

`paragraphs_ee_update_8002()` migrated the old `easy_access_count` setting into Paragraphs
Features' `add_in_between_link_count`. `paragraphs_ee_post_update_alter_description_schema()`
converts legacy plain-string category descriptions to the `{value, format}` structure.

![Paragraphs categories collection](../../../../../../../screenshots/paragraphs_ee/10.2.x/paragraphs_category-collection.png)

![Add paragraphs category form](../../../../../../../screenshots/paragraphs_ee/10.2.x/paragraphs_category-add.png)
