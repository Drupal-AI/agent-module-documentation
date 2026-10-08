<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — templates, theme hooks & libraries

## Theme hooks (`ThemeHooks::theme()`, `src/Hook/ThemeHooks.php`)

| Theme hook | Template | Use |
|---|---|---|
| `paragraphs_add_dialog__categorized` | `templates/paragraphs-add-dialog--categorized.html.twig` | The categorized add dialog: category tabs/sidebar, search box, tile/list groups. Render element `element`. |
| `input__submit__paragraph_action__image` | `templates/input--submit--paragraph_action--image.html.twig` | A single paragraph-type add button rendered as a tile with icon, title and description (base hook `input`). |

Preprocess (methods on `ThemeHooks`):
- `preprocessParagraphsAddDialogCategorized()` (registered as the theme's `initial preprocess`) —
  builds `categories` (incl. `_all` "All" and `_none` "Uncategorized"), groups buttons by their
  `#paragraphs_category`, drops empty categories, and sets `filter_placeholder` /
  `filter_description` for the search box. `sidebar_disabled` is passed through to the template.
- `preprocessInputSubmitParagraphActionImage()` (`#[Hook('preprocess_input__submit__paragraph_action__image')]`) —
  exposes `title`, `description`, and `icon_attributes` (sets `background-image` from the type's
  `#icon`).

To restyle, override either Twig template in your theme.

## Libraries (`paragraphs_ee.libraries.yml`)

| Library | Attached when | Contents |
|---|---|---|
| `paragraphs_ee.paragraphs` | any Paragraphs widget single element / modal | base admin JS/CSS; depends on `paragraphs_features/add_in_between` |
| `paragraphs_ee.categories` | modal add mode (and off-canvas content) | category filtering/search JS + CSS |
| `paragraphs_ee.off_canvas` | off-canvas browser content | off-canvas behavior (`core/drupal.dialog.off_canvas`) |
| `paragraphs_ee.drag_drop` | widget setting `drag_drop` on | reordering arrows (`core/drupal.tabledrag`, `core/drupal.announce`) |
| `paragraphs_ee.gin_accent` | active theme is Gin or a Gin subtheme | Gin accent-color CSS (depends on `gin/gin_accent`) |
| `paragraphs_ee.default_admin_accent` | active theme is Default Admin or subtheme | accent CSS (depends on `default_admin/global-styling`) |

`ParagraphsEE::addAdminThemeAccents()` (`src/ParagraphsEE.php`) inspects the active theme (name
or base-theme extensions) and attaches the Gin **or** Default Admin accent library to the
`add_more` element. `ParagraphsEE::registerWidgetFeatures()` attaches the `drag_drop` library,
passes `widgetTitle` to `drupalSettings`, and adds the `drag-drop-buttons` class to each item's
`top` region when that setting is enabled. Compiled CSS lives in `css/`, JS in `js/`; tile icon
images and the default-image library are under `images/` (`images/library/`).
