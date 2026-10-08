<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable AJAX BigPipe on a block (and on a view)

There is **no global settings page**. You switch AJAX BigPipe on **per block** through the block's
*Visibility* conditions, and (nominally) **per view** through a Views display extender.

## On a block — the visibility condition `ajax_big_pipe_condition`

1. Place/edit a block (Block layout, or a Layout Builder block). Open the **Visibility** tab.
2. Tick **"Use AJAX BigPipe"** (`use_ajax_big_pipe`). That is the master toggle; everything below only
   applies when it is on.

What happens when it is on (`ajax_big_pipe.module`):
- `ajax_big_pipe_block_build_alter()` reads the block entity's visibility config; if
  `visibility.ajax_big_pipe_condition.use_ajax_big_pipe` is set it replaces the block build with a
  `#lazy_builder` (`Drupal\block\BlockViewBuilder::lazyBuilder`, args `id` / `mode='full'` /
  `params=json_encode(<condition config>)`) and sets `#create_placeholder = TRUE`.
- `ajax_big_pipe_entity_presave()` cleans up: if the condition is present but `use_ajax_big_pipe` is
  empty, it removes the `ajax_big_pipe_condition` instance and drops `ajax_big_pipe` from the block's
  module dependencies, so toggling it off leaves no residue.

### Condition settings (all under `visibility.ajax_big_pipe_condition`)

Defaults come from `AjaxBigPipeCondition::defaultConfiguration()`; the fields are declared in
`buildConfigurationForm()` (`src/Plugin/Condition/AjaxBigPipeCondition.php`). The `negate` checkbox is
hidden (`$form['negate']['#access'] = FALSE`) and `evaluate()` always returns `TRUE` — this condition
is a marker/config carrier, not a real visibility gate.

| Key | Form label | Type / default | Effect (from `AjaxBigPipeStrategy::processPlaceholders`) |
|---|---|---|---|
| `use_ajax_big_pipe` | Use AJAX BigPipe | checkbox | Master toggle. The strategy skips any placeholder whose decoded `params['use_ajax_big_pipe']` is empty. |
| `use_statis_preview` | Display static block preview | checkbox | When on, renders the block **once**, sanitizes it (`clearContent`) and caches the snapshot in `cache.data` (`ajax_big_pipe_<token>`, `Cache::PERMANENT`); that snapshot is shown as the placeholder body instead of an animation. When off, an animated skeleton/spinner is shown. |
| `use_preview_height` | Fix the height of the block when loading | number (px), default 200 | Collected and stored, but **not read** by the placeholder strategy in 1.0.8 — has no runtime effect. |
| `use_preview_height_distance` | The distance with which the block when loading | number (px), default 100 | Emitted as the `data-loading-distance` attribute → used by the JS IntersectionObserver `rootMargin`, i.e. how far **before** the viewport the fragment starts loading. |
| `use_preview_templates` | Choose an animation template | select, default `default` | Selects the loading skeleton when static preview is off: `default` (small spinner `.ajax-big-pipe-loader`), `views_template`, `block_template`, `banner_template` (CSS skeleton blocks), `custom_template`. |
| `use_preview_templates_custom` | Add custom markup for loading | textarea | Raw HTML used verbatim as the loader when `use_preview_templates == 'custom_template'`. |

The three preview-template / distance / height fields are only shown in the UI (`#states`) when
`use_ajax_big_pipe` is on **and** `use_statis_preview` is off — a static preview and an animated
template are mutually exclusive.

### No-JS fallback

If the request carries the `big_pipe_nojs` cookie (`AjaxBigPipeStrategy::NOJS_COOKIE`) the strategy
returns the placeholders untouched, so the block is rendered inline the normal way — AJAX BigPipe only
kicks in for JS-capable clients.

## On a Views display — the display extender `ajax_big_pipe`

`hook_install` appends `ajax_big_pipe` to `views.settings:display_extenders` (and `hook_uninstall`
removes it), so every view gains an **"AJAX BigPipe"** section (in the display's *Other* options) with
a single **Status** checkbox — `AjaxBigPipe::buildOptionsForm()` /
`submitOptionsForm()` store it as `options['enabled']`.

Caveat for agents: in 1.0.8 the extender only records this flag (`isEnabled()`); no code in the module
reads it to convert a Views display into an AJAX-loaded placeholder. The block condition path above is
the one that is fully wired end-to-end. Treat the Views toggle as declared-but-inert unless you verify
a consumer on your Drupal version.

## Quick verification

- Confirm the endpoint exists: route `rest.load_ajax_big_pipe.GET` → `/api/bigpipe`
  (`ddev drush route --name=rest.load_ajax_big_pipe.GET`).
- After enabling on a block, view source of a page containing it: you should see a
  `<div data-ajax-placeholder="…" data-loading-distance="…">` and the `ajax_big_pipe/ajax` library.
