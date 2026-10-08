<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form integration — CanvasPageMetatagFormHooks

Class `Drupal\canvas_page_metatag\Hook\CanvasPageMetatagFormHooks`
(`src/Hook/CanvasPageMetatagFormHooks.php`). Registered as a service in
`canvas_page_metatag.services.yml` with `@config.factory` and `@metatag.manager`
injected; the hook is discovered via the `#[Hook(...)]` attribute.

## alterCanvasPageForm() — `#[Hook('form_canvas_page_form_alter')]`
1. Bails unless `$form['metatags']['widget'][0]` exists; takes it by reference as `$widget`.
2. Loads `canvas_page_metatag.settings`.
3. If `expose_basic_fields`: calls `restoreBasicGroup()`, then sets `#access = TRUE` on
   `$widget['basic']['description'|'abstract'|'keywords']` and on the help elements
   `$widget['preamble'|'tokens'|'image_help'|'intro_text']` (each guarded by `isset`).
4. If `expose_advanced` and `$widget['advanced']` exists: sets `#access = TRUE` on it and
   calls `fixRobotsCheckboxes()`.
5. For each of `open_graph`, `facebook`, `twitter_cards`: if the matching
   `expose_*` config is FALSE and the group exists, sets `#access = FALSE`.
6. Adds the config object as a cacheable dependency via `CacheableMetadata` so the altered
   form varies/invalidates with the settings.

`restoreBasicGroup()`: if `$widget['basic']` is a `container` (how Canvas flattens it),
converts it back to `details` with the label from
`MetatagManagerInterface::sortedGroupsWithTags()['basic']['label']` (fallback "Basic tags"),
`#open = FALSE`.

## Robots checkboxes repair
Canvas's React builder submits each checked box in a composite `checkboxes` element as the
generic `1` (and `0` when unchecked) instead of the option key. Core's
`Checkboxes::valueCallback()` then does `array_combine($input, $input)`, collapsing `#value`
to keys `'1'`/`'0'`, which fails validation ("The submitted value 1 in the Robots element is
not allowed").

- `fixRobotsCheckboxes(&$advanced)`: only if `$advanced['robots']['robots']['#type'] === 'checkboxes'`,
  appends `[self::class, 'repairRobotsCheckboxesValue']` to that element's `#after_build`.
- `repairRobotsCheckboxesValue($element, $form_state)` (public static): if every key of the
  current `#value` is already a valid option (`array_diff_key(...) === []`) it returns
  unchanged. Otherwise it re-reads the raw input via
  `NestedArray::getValue($form_state->getUserInput(), $element['#parents'])` and rebuilds
  `key => key` for every option key whose submitted value is non-empty, then writes it back
  with `$element['#value']` and `$form_state->setValueForElement()`.

## Notes for agents
- No route, controller, or entity is added; all behaviour hangs off the existing Canvas page
  form and Metatag field.
- The repair only affects Robots submissions coming through the corrupted-checkbox path;
  clean submissions (real browser widget) short-circuit and are untouched.
- Values are only re-keyed to valid, pre-declared `#options` keys — no user string is copied
  into the element value verbatim, and this module emits no markup (Metatag renders the tags).
