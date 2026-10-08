# LocalGov Admin Theme Improvements — agent index

Submodule of **localgov_core**. Glue module: attaches small admin-theme CSS/JS fixes and reweights a
couple of admin local tasks. No config, no permissions, no entities, no dependencies declared.
Enabling it applies the fixes.

Key facts:
- `hook_layout_paragraphs_layout_paragraph_element_form_alter()` → attaches library `localgov_admin_theme_improvements/gin-layout-paragraphs` (JS) only when the active theme is `gin`.
- `hook_form_revision_overview_form_alter()` → attaches library `.../revisions-page` (CSS) on `revision_overview_form`.
- `hook_menu_local_tasks_alter()` → sets `#weight` on the "Files" (`view.files.page_1`) and "Page components" (`paragraphs_library_item.collection`) tabs.
- Libraries defined in `localgov_admin_theme_improvements.libraries.yml`.
