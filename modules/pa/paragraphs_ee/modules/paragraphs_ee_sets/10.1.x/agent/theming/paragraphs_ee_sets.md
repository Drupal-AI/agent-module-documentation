# Theming / integration — how sets join the enhanced dialog

`paragraphs_ee_sets` has no templates or theme hooks of its own; it reuses paragraphs_ee's
`paragraphs_add_dialog__categorized` and `input__submit__paragraph_action__image`. All logic
lives in `paragraphs_ee_sets.module`.

## What it does

1. **`hook_field_widget_complete_form_alter()`** — runs only when the widget's
   `paragraphs_sets.use_paragraphs_sets` third-party setting is on and add mode is `modal`. It
   forces `$elements['add_more']['#theme'] = 'paragraphs_add_dialog__categorized'`, then for each
   allowed set restyles its `append_selection_button_{id}` as a tile: sets
   `#theme_wrappers` to `input__submit__paragraph_action__image`, adds the
   `paragraphs-button--add-more` class, the set description (`ParagraphsSet::getDescription()`),
   and the set icon (`ParagraphsSet::getIconUrl()`) — falling back to a default image class.
   Sets are limited by the widget's `sets_allowed` setting.

2. **`hook_paragraphs_ee_widget_access()`** — returns `allowed()` only when the add-more element
   already uses the `paragraphs_sets_add_dialog` theme, otherwise `neutral()`, so it does not
   interfere with non-sets widgets.

3. **`paragraphs_ee_sets_preprocess_paragraphs_add_dialog__categorized()`** — collects every
   `append_selection_button_*` element into a new group and registers a **"Paragraphs Sets"**
   category tab (context "Paragraphs EE Sets: categories"), keeping sets grouped separately from
   individual paragraph types. Empty group is removed.

4. **`hook_module_implements_alter()`** + `hook_install()` module weight `20` — ensure this
   module's `field_widget_complete_form_alter` runs **after** both `paragraphs_ee` and
   `paragraphs_sets`.

Nothing here is configurable; it activates automatically for widgets that use Paragraphs Sets
with the enhanced modal dialog.
