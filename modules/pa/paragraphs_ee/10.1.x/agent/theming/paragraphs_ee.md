# Theming — templates, theme hooks & libraries

## Theme hooks (`paragraphs_ee_theme()`)

| Theme hook | Template | Use |
|---|---|---|
| `paragraphs_add_dialog__categorized` | `templates/paragraphs-add-dialog--categorized.html.twig` | The categorized add dialog: category tabs/sidebar, search box, tile/list groups. Render element `element`. |
| `input__submit__paragraph_action__image` | `templates/input--submit--paragraph_action--image.html.twig` | A single paragraph-type add button rendered as a tile with icon, title and description (base hook `input`). |

Preprocess:
- `template_preprocess_paragraphs_add_dialog__categorized()` — builds `categories` (incl. `_all`
  "All" and `_none` "Uncategorized"), groups buttons by their `#paragraphs_category`, drops empty
  categories, and sets `filter_placeholder` / `filter_description` for the search box.
- `paragraphs_ee_preprocess_input__submit__paragraph_action__image()` — exposes `title`,
  `description`, and `icon_attributes` (sets `background-image` from the type's `#icon`).

To restyle, override either Twig template in your theme.

## Libraries (`paragraphs_ee.libraries.yml`)

| Library | Attached when | Contents |
|---|---|---|
| `paragraphs_ee.paragraphs` | any Paragraphs widget | base admin JS/CSS; depends on `paragraphs_features/add_in_between` |
| `paragraphs_ee.categories` | modal add mode | category filtering/search JS + CSS |
| `paragraphs_ee.off_canvas` | off-canvas dialog | off-canvas behavior (`core/drupal.dialog.off_canvas`) |
| `paragraphs_ee.drag_drop` | widget setting `drag_drop` on | reordering arrows (`core/drupal.tabledrag`, `core/drupal.announce`) |
| `paragraphs_ee.gin_accent` | active theme is Gin or a Gin subtheme | Gin accent-color CSS (depends on `gin/gin_accent`) |

`ParagraphsEE::addGinAccents()` detects the Gin theme/subtheme and attaches the accent library;
`ParagraphsEE::registerWidgetFeatures()` attaches the drag_drop library and adds the
`drag-drop-buttons` class when that setting is enabled. Source SCSS lives in `scss/`, compiled
CSS in `css/`; tile icon images are under `images/`.
