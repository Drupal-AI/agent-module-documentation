Twig Template Suggester adds the theme/template suggestions that Drupal core (and many contrib modules) leave out — block-per-region, page-and-html-per-node-type, user-per-role, field-per-view-mode, form/container/menu templates, and more — so themers can target them with a `.html.twig` file.

---

The module is a set of `hook_theme_suggestions_HOOK()` / `hook_theme_suggestions_HOOK_alter()` implementations plus a global `hook_preprocess`. It contributes suggestions for **blocks** (per region, per block-content bundle, per provider/base-plugin, per menu), **layouts** (an optional Display Suite fix), **containers** (has-parent/no-parent, per type, per view, per file/group/webform key), **forms** (per form id and per region), **form elements** and **inputs** (per id, per type, per webform id), **users** (per uid, per highest role, per view mode), **html** and **page** (per node type), **fields** (per field/view-mode/bundle and per entity-reference target type), **taxonomy terms** (per view mode + id/bundle combinations), **book trees** (per region), **menus** (per region), and **menu local actions** (per route piece). It also de-duplicates core's block suggestions. A global `twigsuggest_preprocess()` exposes a `base_path` variable to every template (so you can write `{{ base_path ~ directory }}/images/icon.svg`). The module installs itself at weight 100 so its suggestions win over other modules'. It has **no admin UI, no `configure` route, no permissions, and no config schema**; its only setting, `twigsuggest.settings:alternate_ds_suggestions` (normally enabled in `settings.php`), turns on the optional Display-Suite layout-suggestion fix. It provides one small service, `twigsuggest.helper_functions`, whose `getCurrentNode()` resolves the current node across canonical/preview/revision routes (used by the html/page suggestions). See README for cases better handled by Block Type Templates or Template Whisperer.

---

- Provide a `block--region--sidebar.html.twig` template for all blocks in a region.
- Theme a specific block in a region with `block--<region>--<block-id>.html.twig`.
- Style custom (content) blocks per bundle with `block--bundle--<type>.html.twig`.
- Give each node type its own page template (`page--node--article.html.twig`).
- Give each node type its own html wrapper template (`html--node--article.html.twig`).
- Theme user displays by highest role (`user--administrator.html.twig`) or uid or view mode.
- Provide field templates per view mode and bundle (`field--article--field_x--teaser.html.twig`).
- Target entity-reference fields by their target type (`field--entity-reference-type--taxonomy-term.html.twig`).
- Theme forms by form id (`form--user-login-form.html.twig`) or by region.
- Theme form elements or inputs by id or type (`form-element--textfield.html.twig`, `input--edit-submit.html.twig`).
- Theme webform elements by webform id.
- Provide container templates for form vs non-form (`container--has-parent`, `container--no-parent`).
- Theme containers per element type, per view, per managed-file field, per field group, per webform key.
- Provide taxonomy-term templates per view mode and term id/bundle.
- Theme menus per region (`menu--footer.html.twig`, or `menu--main--footer.html.twig`).
- Theme book-tree output per region.
- Theme menu local actions per route piece.
- Use the `base_path` variable in any template to build asset URLs.
- Ensure twigsuggest's suggestions win by its weight-100 install.
- Turn on the optional Display Suite layout-suggestion fix via `alternate_ds_suggestions`.
- Reduce reliance on custom preprocess code just to add template suggestions.
- Resolve the current node in a template context via the helper service across preview/revision routes.
- De-duplicate core's block template suggestions automatically.
