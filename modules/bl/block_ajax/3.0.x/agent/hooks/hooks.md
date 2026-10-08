# Hooks implemented (`block_ajax.module`)

| Hook | What it does |
|------|--------------|
| `hook_entity_type_alter()` | On the `block` entity type, sets the default form class to `AjaxBlockForm` and the list builder to `AjaxBlockListBuilder`. This is how the "Ajax block" fieldset appears on every block form. |
| `hook_block_build_alter()` | For an Ajax block, forces `#cache['max-age']` to the configured `max_age` (0 by default) and adds the `block_ajax` cache tag, so the placeholder is not served stale. |
| `hook_block_view_alter()` | For an Ajax block, adds a `#pre_render` closure that: swaps `#theme` to `block_ajax_block`; sets `#block_ajax_id` and `#block_settings`; attaches the `block_ajax/ajax_blocks` library, `drupalSettings.block_ajax.config` (from `getAjaxDefaults()`) and per-block settings; attaches the current node/user/term id for context blocks; and (with `access contextual links`) adds a contextual-links placeholder. It unsets `#block` so the placeholder builds without the config entity. |
| `hook_theme()` | Registers the `block_ajax_block` theme hook (template `templates/block-ajax-block.html.twig`, preprocess in `block_ajax.theme.inc`) with variables `block_ajax_contextual_links`, `block_ajax_id`, `block_settings`. |
| `hook_help()` | Renders `README.md` on `help.page.block_ajax` (parsed if the `markdown` module is present, otherwise `<pre>`). |

Integrator notes:
- To detect an Ajax block in your own alter, call `\Drupal::service('block_ajax.ajax_blocks')
  ->isAjaxBlock($blockPlugin)` rather than re-reading config.
- The `block_ajax` cache tag lets you invalidate all Ajax placeholders at once.
- `AjaxBlockListBuilder` extends core `BlockListBuilder` and appends " (Ajax loaded)" to labels of
  Ajax-enabled blocks on the block layout page.
