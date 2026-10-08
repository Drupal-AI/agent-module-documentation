LocalGov Admin Theme Improvements is a small glue module that attaches CSS/JS fixes to the admin theme — specifically a Gin + Layout Paragraphs JavaScript tweak and a revisions-page stylesheet — and reweights a couple of admin local tasks.

---

The module has no config or entities; it is purely a set of `hook_*_alter` implementations that attach two asset libraries and adjust local-task weights. `hook_layout_paragraphs_layout_paragraph_element_form_alter()` attaches the `gin-layout-paragraphs` JS library, but only when the active admin theme is Gin, to fix Layout Paragraphs form rendering under Gin. `hook_form_revision_overview_form_alter()` attaches the `revisions-page` CSS to improve the node revisions overview page. `hook_menu_local_tasks_alter()` bumps the weight of the "Files" (`view.files.page_1`) and "Page components" (`paragraphs_library_item.collection`) local tasks so they sort lower. Libraries are defined in `localgov_admin_theme_improvements.libraries.yml`. There are no dependencies declared, no permissions, and no configuration — enabling it applies the fixes.

---

- Fix Layout Paragraphs element form styling when using the Gin admin theme.
- Only load the Gin-specific JS when Gin is actually the active admin theme.
- Improve the appearance of the node revisions overview page with extra CSS.
- Reorder the "Files" local task so it sorts after other media tabs.
- Reorder the "Page components" (paragraphs library) local task.
- Apply admin-theme polish across a LocalGov site without theme edits.
- Keep admin UX tweaks in a module so they survive theme changes.
- Attach targeted admin CSS/JS only on the relevant admin forms.
- Provide a drop-in set of small admin-theme fixes for LocalGov Drupal.
- Avoid patching the Gin theme directly for Layout Paragraphs issues.
- Improve editor usability of the Layout Paragraphs builder under Gin.
- Make the revisions overview easier to scan for content editors.
- Keep media/component admin tabs in a sensible order.
- Ship admin polish that activates automatically on enable.
- Scope CSS/JS to only the admin forms that need them (no front-end impact).
- Bundle recurring admin-theme fixes so every LocalGov site gets them.
