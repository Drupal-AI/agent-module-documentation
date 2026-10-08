<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Breakpoint — breakpoint visibility (config, storage, render, JS)

All logic is in `BlockBreakpointManager` (`src/BlockBreakpointManager.php`), wired by
`block_breakpoint.module` and `block_breakpoint.services.yml`. No routes, no permissions, no
settings form, no config entity — settings live on the host block's **third-party settings**.

## Install / enable

- `drush en block_breakpoint -y`. Requires core `breakpoint` and `block` (declared in
  `block_breakpoint.info.yml`). Nothing to configure globally; you configure per block.

## The block configuration form (`blockFormAlter()`)

Attached via two alters:
- `hook_form_block_form_alter` → classic Block UI (`/admin/structure/block/…`).
- `hook_form_layout_builder_configure_block_alter` → Layout Builder component form.

Fields added under the `block_breakpoint` form tree:
- `enabled` — checkbox *"Enable Block Breakpoint"*; default from
  `getThirdPartySetting('block_breakpoint', 'enabled')`.
- `breakpoint_group` — select of `breakpoint.manager->getGroups()`; default is the block's stored
  group or, as fallback, `system.theme:default` (the default theme's breakpoint group). Has an
  `#ajax` callback `updateBreakpointOptions()` (wrapper `edit-breakpoint-options`) that reloads the
  breakpoint list when the group changes. `#states`: required + visible only when `enabled` checked.
- `breakpoints` — `#multiple` select of the group's breakpoints (label keyed by breakpoint id),
  from `loadBreakpointsAsOptions()` → `breakpoint.manager->getBreakpointsByGroup($group)` mapped to
  `getLabel()`. Wrapped in the AJAX `#prefix`/`#suffix` div. Same `#states`.

Submission wiring differs by context:
- Classic block: `$form['#entity_builders'][] = [$this, 'entityBuilder']` → `entityBuilder()`.
- Layout Builder (`$formObject instanceof ConfigureBlockFormBase`):
  `array_unshift($form['#submit'], [$this, 'componentSubmit'])` and the object is
  `getCurrentComponent()` (a `SectionComponent`).

## Storage (`storeThirdPartySettings()`)

Writes to any `ThirdPartySettingsInterface` object (block entity or section component):
- If `enabled` is empty → `unsetThirdPartySetting()` for `enabled`, `breakpoint_group`, `breakpoint`.
- Else → set `enabled = TRUE`, `breakpoint_group = <value>`, and `breakpoints` as a **sequence of
  mappings** `[{ 'breakpoint_id': <id> }, …]`. The nesting is deliberate: breakpoint ids contain
  dots (e.g. `olivero.md`) which the config system would otherwise treat as nested keys.

Config schema (`config/schema/block_breakpoint.schema.yml`) on
`block.block.*.third_party.block_breakpoint`: `enabled` bool, `breakpoint_group` string,
`breakpoints` sequence of `{ breakpoint_id: string }`.

## Render path

Classic blocks — `hook_preprocess_block` → `preprocessBlock(&$variables)`:
- Skips blocks with no `#id` (e.g. Page Manager widgets). Loads the `block` entity by id; acts only
  when `getThirdPartySetting('block_breakpoint','enabled')` is truthy.
- Adds class `block-breakpoint`, attaches library `block_breakpoint/block_breakpoint`, sets
  `attributes['data-block-breakpoint-media-query']`, and appends a render element
  `{'#theme' => 'block_breakpoint_inline_match', '#weight' => -50}` into `content`.

Layout Builder — `hook_preprocess_layout` → `_block_breakpoint_layout_builder_add()` →
`preprocessComponent(&$component)`:
- The subscriber `BlockComponentRenderArray::onBuildRender()` first copies the component's
  `getThirdPartySettings('block_breakpoint')` onto the build as `#block_breakpoint`.
- `preprocessComponent()` acts when `#block_breakpoint` is non-empty, adding the same class,
  library, `data-block-breakpoint-media-query` attribute and inline-match element to the component.

Media query — `buildMediaQueryFromBreakpoints(array $breakpoints, $group)`:
- For each stored `breakpoint_id` present in `breakpoint.manager->getBreakpointsByGroup($group)`,
  collects `->getMediaQuery()`, then `implode(', ', …)` (a comma = logical OR across the selected
  breakpoints). Values originate from breakpoint `*.breakpoints.yml` definitions, not user text.

## Client-side hiding (`js/block-breakpoint.js`, header library)

- On `DOMContentLoaded` and on every `MutationObserver` childList change of `documentElement`,
  it selects `.block-breakpoint` elements and runs `blockBreakpointMatchElement()`.
- `blockBreakpointMatchElement()` reads `data-block-breakpoint-media-query`; if
  `window.matchMedia(query).matches` is **false**, it `parentNode.removeChild()`s the element
  (skips `.layout-builder-block` wrappers so the LB editing UI is not stripped).
- `templates/block-breakpoint-inline-match.html.twig` emits an inline `<script>` that, via
  `document.currentScript`, finds the closest `.block-breakpoint` ancestor and matches it
  immediately — so a non-matching block (and any ad/embed script inside it) is removed before the
  browser processes it further. This is why the module beats plain CSS `display:none` for external
  scripts / impression counting.

## Manual (non-Block-UI) usage

Attach the library and mark up your own element, per README:

```twig
{{ attach_library('block_breakpoint/block_breakpoint') }}
<div class="block-breakpoint" data-block-breakpoint-media-query="(max-width: 600px)">
  {% include '@block_breakpoint/block-breakpoint-inline-match.html.twig' %}
  <p>Only shown on mobile.</p>
</div>
```

## Caveats

- Visibility is enforced **in the browser only**; the block HTML is present in the server response
  and is stripped client-side. Treat it as presentation/UX (accurate impressions), never as an
  access boundary — rely on the block's own access/visibility for real restrictions.
- IE ≤ 11 lacks `document.currentScript`; the block is still removed on load but external content
  may have loaded first (README). Layout Builder component third-party settings need a core patch
  (README references drupal.org/node/3015152).
