<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Deck EB (entity_reference_deck_eb) — agent index

Host submodule of **Entity Reference Deck** for **Entity Browser**. Depends on
`entity_reference_deck` and contrib **`entity_browser`**. Core `^11.4 || ^12`. Version 1.0.0-beta5.
No permission or config of its own.

## What it provides
- Entity Browser FieldWidgetDisplay plugin **`entity_reference_deck`**
  (`src/Plugin/EntityBrowser/FieldWidgetDisplay/EntityReferenceDeckDisplay.php`) — `view()`
  access-checks the entity (`$entity->access('view')`, restricted label via FormattableMarkup with
  escaped placeholders otherwise), else renders `EntityReferenceDeckCardBuilder::build()` with a
  context carrying `show_preview`.
- Hook class `Hook/FieldWidgetHooks` (`field_widget_complete_form_alter`) — stamps
  `erdeck-widget` + `--list`/`--grid` classes on `entity_browser_entity_reference` /
  `entity_browser_multi` widgets that pick the deck display, attaches `entity_reference_deck_eb/widget`,
  and mounts `entity_reference_deck_preview.field_chrome_builder` when `show_preview` + preview module.
- Library **`widget`**.

## Operate
Enable with `entity_browser`. On *Manage form display*, set the field's Entity Browser widget's
*Field widget display* to **Entity reference deck**; pick list/grid via the display settings.
