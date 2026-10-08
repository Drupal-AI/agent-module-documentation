<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link rewrite mechanics & query syntax

## Install / enable

`ddev drush en dialogs -y`. No dependencies, no configuration, no permissions. Once enabled it
acts on every rendered link whose query contains a `dialog` key.

## Entry point

`dialogs.module` implements `hook_help()` (currently empty, `@fixme`) and `hook_link_alter()`.
`dialogs_link_alter(&$variables)` fetches the `dialogs.hooks` service and calls
`DialogsHooks::hookLinkAlter($variables)` (`src/DialogsHooks.php`).

`hookLinkAlter()` passes `$variables['options']['query']` to
`DialogifyerFactory::fromQueryArray()`; if a `Dialogifyer` comes back it calls
`$dialogifyer->alterLinkOptions($variables['options'])`. Note the module works via
`hook_link_alter` because an OutboundPathProcessor would drop link attributes (per the class
docblock).

## Parsing — `DialogifyerFactory::fromQueryArray()` (`src/DialogifyerFactory.php`)

- Query key is hardcoded: `$queryKey = 'dialog'`. Returns `NULL` when the key is absent
  (`array_key_exists`, so a null value still counts).
- If the `dialog` value is a scalar, it is treated as the `type` (short form `?dialog=modal`).
- If it is an array, it reads `type`, `renderer`, `options`, `libraries` sub-keys.
- `type` defaults to `'dialog'` when empty.
- `libraries`: a non-array string is `explode('|', …)`. Each entry must be `extension/name`
  (exactly two `/`-split parts) AND resolve via `LibraryDiscoveryInterface::getLibraryByName()`,
  otherwise it is filtered out. Unknown/malformed library names are silently dropped.
- Constructs `new Dialogifyer($type, $renderer, $options, $libraries, ['dialog'], $renderer_service)`.

## Rewrite — `Dialogifyer::alterLinkOptions()` (`src/Dialogifyer.php`)

Mutates the link `$linkOptions` in place:
- Adds `use-ajax` to `attributes.class`.
- Sets `attributes['data-dialog-type']` = the type.
- If a renderer is set, `attributes['data-dialog-renderer']` = renderer.
- If options are set: `data-dialog-options` = `json_encode($options)` when array, else the raw
  string as-is.
- If `query['destination']` exists but is empty, fills it with `\Drupal::destination()->get()`
  (useful for form links returning to the current page).
- Unsets every query parameter listed in `queryParametersToUnset` (i.e. `dialog`) so the dialog
  params never appear in the final `href`.
- Attaches libraries: `core/drupal.dialog.ajax` merged with the validated effect libraries. If a
  `BubbleableMetadata` is supplied it uses `addAttachments()`; otherwise, if the renderer has a
  render context, it does an early `$this->renderer->render(['#attached' => …])` (the docblock
  calls this an "early-rendering hack" needed because link variables carry no metadata).

## Query syntax reference

- `?dialog` or `?dialog=dialog` — non-modal dialog.
- `?dialog=modal` — modal dialog. `?dialog[options][modal]=1` is a related but distinct option.
- `?dialog[type]=modal&dialog[renderer]=off_canvas` — nested form; renderers: `off_canvas`,
  `off_canvas_top` (contrib may add more). Modal + off_canvas reportedly do not combine.
- `?dialog[options][height]=100&dialog[options][width]=200` — array options.
- `?dialog[options]={"height":100,"width":200}` — JSON-string options (invalid JSON breaks the link).
- `?dialog[options][show]=fadeIn&dialog[options][duration]=5000` — show effect.
- `?dialog[libraries]=core/jquery.ui.effects.pulsate|core/jquery.ui.effects.explode` — extra
  effect libraries (pipe-delimited), or `?dialog[libraries][]=core/jquery.ui.effects.explode` array.
- `?dialog&destination` — empty destination becomes the current page.

## Notes

- Dialog rendering is done entirely by Drupal core's AJAX dialog system (`core/drupal.dialog.ajax`);
  this module only writes the trigger attributes. jQuery UI dialog option semantics come from
  https://api.jqueryui.com/dialog/.
- Use with the `renderfilter` contrib module to dialogify links inside filtered text.
- Tests: `tests/src/Functional/AdminPageTest.php`.
