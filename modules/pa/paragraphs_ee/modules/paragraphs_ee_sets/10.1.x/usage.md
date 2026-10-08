Paragraphs EE Sets is a bridge submodule that brings the Paragraphs Editor Enhancements tile dialog to Paragraphs Sets, showing predefined reusable paragraph "sets" (templates) as icon tiles in a dedicated "Paragraphs Sets" group inside the enhanced add dialog.

---

The submodule connects three modules: it depends on both `paragraphs_ee` and `paragraphs_sets`. When a Paragraphs field widget uses the sets feature (`paragraphs_sets.use_paragraphs_sets`) and modal add mode, `paragraphs_ee_sets` forces the categorized dialog theme (`paragraphs_add_dialog__categorized`) and restyles each set's "append selection" button as a paragraphs_ee tile — applying the same icon (`ParagraphsSet::getIconUrl()`), description, and layout used for paragraph types. A preprocess hook then collects those set buttons into a new **"Paragraphs Sets"** category tab so sets appear alongside (but grouped separately from) individual paragraph types. It implements `hook_paragraphs_ee_widget_access()` to only act when the add-more element is a paragraphs_sets dialog, and `hook_module_implements_alter()` plus an install-time module weight of 20 to make sure it runs after both parent modules. It respects the widget's `sets_allowed` restriction so only permitted sets are shown. It defines no permissions, config schema, routes, or services of its own — it is purely an integration/theming layer.

---

- Show Paragraphs Sets as icon tiles in the enhanced add dialog instead of plain buttons.
- Group all available sets under a dedicated "Paragraphs Sets" tab in the dialog.
- Give each set the same tile styling (icon + description) as individual paragraph types.
- Use a set's configured icon image for visual recognition in the picker.
- Let editors add a whole predefined group of paragraphs (a set/template) from the tile dialog.
- Keep sets visually separated from single paragraph types while sharing one dialog.
- Honor the widget's allowed-sets restriction (`sets_allowed`) in the enhanced dialog.
- Provide a consistent editor experience whether adding a single paragraph type or a set.
- Automatically apply only when a widget uses Paragraphs Sets and modal add mode.
- Bridge Paragraphs Sets into the searchable/filterable paragraphs_ee dialog.
- Reuse the paragraphs_ee categorized template (`paragraphs_add_dialog__categorized`) for sets.
- Speed up building repeatable page layouts from reusable paragraph templates.
- Present starter/section templates (e.g. hero + text + gallery) as one-click tiles.
- Ensure correct ordering by running after both paragraphs_ee and paragraphs_sets (module weight 20).
- Avoid overriding the dialog when a non-sets add element is in use (widget access hook).
- Standardize the look of "append selection" set buttons across a site's content types.
