<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming / integration — how sets join the enhanced dialog

`paragraphs_ee_sets` has no templates or theme hooks of its own; it reuses paragraphs_ee's
`paragraphs_add_dialog__categorized` and `input__submit__paragraph_action__image`. All logic
lives in two OOP attribute hook classes under `src/Hook/`.

## What it does

1. **`FormHooks::fieldWidgetCompleteFormAlter()`** (`#[Hook('field_widget_complete_form_alter',
   order: Order::Last)]`) — runs only when the widget's `paragraphs_sets.use_paragraphs_sets`
   third-party setting is on. It forces
   `$elements['add_more']['#theme'] = 'paragraphs_add_dialog__categorized'` when add mode is
   `modal`, then for each allowed set restyles its `append_selection_button_{id}` as a tile: sets
   `#theme_wrappers` to `input__submit__paragraph_action__image`, adds the
   `paragraphs-button--add-more` class, the set description (`ParagraphsSet::getDescription()`),
   and the set icon (`ParagraphsSet::getIconUrl()`) — falling back to a default image class.
   Sets are limited by the widget's `sets_allowed` setting (via `ParagraphsSets::getSets()`).

2. **`FormHooks::widgetAccess()`** (`#[Hook('paragraphs_ee_widget_access')]`) — returns
   `allowed()` only when the add-more element already uses the `paragraphs_sets_add_dialog` theme,
   otherwise `neutral()`, so it does not interfere with non-sets widgets.

3. **`ThemeHooks::preprocessParagraphsAddDialogCategorized()`**
   (`#[Hook('preprocess_paragraphs_add_dialog__categorized', order: Order::Last)]`) — collects
   every `append_selection_button_*` element into a new group and registers a **"Paragraphs
   Sets"** category tab (context "Paragraphs EE Sets: categories"), keeping sets grouped
   separately from individual paragraph types. Each button gets an `aria-describedby` pointing at
   its description. The empty group is removed if no sets are present.

4. **`hook_install()` module weight `20`** (`paragraphs_ee_sets.install`) plus the `Order::Last`
   hook ordering — ensure this module's alter/preprocess run **after** both `paragraphs_ee` and
   `paragraphs_sets`.

Nothing here is configurable; it activates automatically for widgets that use Paragraphs Sets
with the enhanced modal dialog.
