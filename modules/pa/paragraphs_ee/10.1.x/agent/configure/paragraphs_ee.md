# Configure — enable the enhanced dialog, categories & display

There is **no `configure` route** in `paragraphs_ee.info.yml`. Configuration happens in two
places: the Paragraphs field widget settings, and the Paragraphs category admin.

## 1. Turn the enhanced dialog on (per field widget)

The enhancements only apply to fields using the **Paragraphs (stable)** widget with
**Add mode = Modal form** (`add_mode: modal`). Set this on the entity's *Manage form display*
(the widget's settings gear). When Add mode is modal, `paragraphs_ee` swaps the add buttons
for the `paragraphs_add_dialog__categorized` theme and attaches its libraries.

### Widget third-party settings (`field.widget.third_party.paragraphs_ee`)

Added to the widget settings form by `FieldHooks::fieldWidgetThirdPartySettingsForm()`, stored
under the widget's third-party setting `paragraphs_ee.paragraphs_ee`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `dialog_off_canvas` | boolean | `false` | Open the picker as a Drupal off-canvas panel instead of a centered modal (modal add mode only). |
| `dialog_style` | string | `tiles` | How types are shown: `tiles` or `list`. |
| `drag_drop` | boolean | `false` | Show up/down arrows for drag & drop reordering of items. |
| `sidebar_disabled` | boolean | `false` | Hide the category sidebar in the dialog. |

The "add in between" quick-access buttons count comes from the **Paragraphs Features** widget
setting `paragraphs_features.add_in_between_link_count` (default `3`) — the first N unique types
are marked `#easy_access`.

## 2. Paragraphs categories (config entity `paragraphs_category`)

Admin UI: **Admin → Structure → Paragraphs categories** (`/admin/structure/paragraphs_category`,
route `entity.paragraphs_category.collection`). Add/edit/delete routes live under the same path.
Gated by the `administer paragraphs categories` permission.

Each category is a config entity with `id`, `label`, `description` (a text-format value), and
`weight` (controls order in the dialog). Config prefix `paragraphs_ee.paragraphs_category.*`;
exports/deploys with `drush config:export`.

### Assign paragraph types to categories

The paragraph type form (`form_paragraphs_type_form_alter` in `FormHooks`) gains a
**Paragraphs categories** checkboxes element. Selections are stored as the paragraph type's
third-party setting `paragraphs_ee.paragraphs_categories` (a sequence of category IDs); a type
can belong to several categories, and appears under each matching tab plus the automatic **All**
tab. Types with no category fall under **Uncategorized** (`_none`). Empty categories are hidden.

### Icons

Tile icons are **not** a paragraphs_ee setting — they are the icon image configured on the
paragraph type itself (`ParagraphsType::getIconUrl()`). Types with no icon get a default image
placeholder class.

Config schema: `config/schema/paragraphs_ee.schema.yml`.
