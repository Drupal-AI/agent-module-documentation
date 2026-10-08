Paragraphs Editor Enhancements (paragraphs_ee) restyles the "add paragraph" modal/off-canvas dialog used by Paragraphs and Paragraphs Features, letting editors browse paragraph types as searchable, icon-rich tiles grouped into custom categories.

---

The module hooks into the Paragraphs field widget (via `hook_field_widget_complete_form_alter()`) whenever the widget's "Add mode" is set to **Modal form**, replacing the plain add buttons with a themed dialog (`paragraphs_add_dialog__categorized`). Each paragraph type becomes a tile that shows the type's label, description, and the icon uploaded on the paragraph type — falling back to a default image when no icon is set. Editors can switch the dialog between **Tiles** and **List** display, filter/search types by title and description, and (optionally) open the picker as a Drupal **off-canvas** panel instead of a centered modal. A new **Paragraphs category** config entity (managed at Admin → Structure → Paragraphs categories) lets you define named groups; each paragraph type form gains a "Paragraphs categories" checkboxes element so a type can appear under one or more category tabs, plus an automatic "All" and "Uncategorized" group. Per-widget third-party settings (`dialog_off_canvas`, `dialog_style`, `drag_drop`, `sidebar_disabled`) are added to the Paragraphs widget's settings form, and the first few types are surfaced as "easy access" add-in-between buttons using the count configured by Paragraphs Features. The module also ships optional Gin-theme accent styling and drag-and-drop reordering arrows, and exposes `hook_paragraphs_ee_widget_access()` so other modules can allow or forbid its widget modifications. It depends on Paragraphs Features (which in turn requires Paragraphs) and requires Drupal core ^11.3.

---

- Give editors an icon-and-tile "add paragraph" dialog instead of a plain list of buttons.
- Group many paragraph types into custom **categories** (tabs) so the picker stays scannable.
- Add an "All" tab plus an automatic "Uncategorized" group in the add dialog.
- Let editors **search/filter** paragraph types by title and description in the dialog.
- Show each paragraph type's uploaded icon image for faster visual recognition.
- Display the paragraph type description under each tile as a hint.
- Switch the dialog between **Tiles** and **List** presentation per widget.
- Open the paragraph picker as an **off-canvas** side panel instead of a modal.
- Enable the enhanced dialog by setting a Paragraphs field widget's Add mode to **Modal form**.
- Define reusable category entities at Admin → Structure → Paragraphs categories.
- Assign a single paragraph type to several categories at once.
- Reorder categories in the dialog via the category **weight** field.
- Give category tabs their own formatted (text-format) descriptions.
- Surface the first N paragraph types as quick "add in between" buttons (count from Paragraphs Features).
- Add drag-and-drop reordering arrows to paragraph items in the widget.
- Hide the dialog sidebar for a more compact picker.
- Apply Gin admin theme accent colors to the dialog when using Gin or a Gin subtheme.
- Restrict who can manage categories with the `administer paragraphs categories` permission.
- Let another module allow/forbid the widget enhancements via `hook_paragraphs_ee_widget_access()`.
- Improve the editorial UX of large paragraph-based landing pages and page builders.
- Export/deploy category definitions and per-widget settings as configuration between environments.
- Keep translated paragraph type labels showing correctly in the widget summary.
- Combine with Paragraphs Sets (via the `paragraphs_ee_sets` submodule) to show sets in the same dialog.
- Present a consistent add experience across both the modal button and "add in between" buttons.
