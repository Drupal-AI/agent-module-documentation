Block Form Alter is a small developer module that provides two consistent alter hooks — `hook_block_plugin_form_alter()` and `hook_block_type_form_alter()` — so you can modify block configuration forms by plugin id or by custom-block bundle without duplicating the fiddly detection code Layout Builder, Block Content and the Block module otherwise require.

---

Altering a block's configuration form in Drupal is awkward because the form is rendered by different subsystems (the Block module's `block_form`, Block Content's `block_content_*_form`, and Layout Builder's `layout_builder_add_block` / `layout_builder_update_block`) and the block's plugin is not consistently available. This module implements a single `hook_form_alter()` that detects the rendering context, resolves the block's plugin id or bundle, and re-dispatches to two clean hooks: `hook_block_plugin_form_alter(&$form, &$form_state, $plugin)` for block **plugins** (any plugin except `block_content`/`inline_block`), and `hook_block_type_form_alter(&$form, &$form_state, $block_type)` for custom **content block** forms (the `block_content` and `inline_block` plugins, including inline blocks placed via Layout Builder, handled through a process callback). It has no configuration, no admin UI, no permissions, no services and no config schema — it is purely a developer convenience API (its own `block_form_alter.api.php` documents the two hooks). You add your own module implementing one of the hooks; Block Form Alter guarantees it fires uniformly across the Block, Block Content and Layout Builder code paths. It exists to work around core issue #3028391 ("It's very difficult to alter forms of inline (content blocks) placed via Layout Builder").

---

- Set a default value on a specific block plugin's configuration form via `hook_block_plugin_form_alter()`.
- Disable or hide a field on a webform block's settings form by plugin id.
- Alter the configuration form of a custom (content) block bundle via `hook_block_type_form_alter()`.
- Consistently alter an inline block's form whether placed through Block layout or Layout Builder.
- Add a custom setting to a views block's placement form.
- Pre-fill a default label or override a field default on a content block bundle form.
- Force a checkbox on (and disable it) for a particular block plugin across all placements.
- Add validation or `#states` logic to a specific block type's form.
- Inject an extra fieldset into the block config form for one plugin only.
- Avoid writing duplicate detection code for `block_form` vs `layout_builder_update_block`.
- Alter inline-block forms added by Layout Builder's process callbacks (otherwise very hard).
- Target block forms by plugin id without matching on brittle form ids.
- Target custom-block forms by bundle machine name rather than form id.
- Apply the same alteration to a block whether edited in Block layout or Layout Builder.
- Provide module-specific defaults for third-party block plugins on placement.
- Remove or reorder elements on a particular block plugin's settings form.
- Add an AJAX callback or dependency to a specific content block bundle form.
- Standardise block configuration UX across Block, Block Content and Layout Builder.
- Give a distribution/install profile a single hook to customise block forms.
- Work around core issue #3028391 for inline content block form alteration.
