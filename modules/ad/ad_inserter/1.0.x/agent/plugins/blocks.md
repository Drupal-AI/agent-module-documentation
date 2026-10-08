<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block plugins, loader library & screen targeting

Ads are placed on the site with two block plugins in `src/Plugin/Block/`, both extending the abstract
`AdInserterBaseBlock` (`AdInserterBaseBlockInterface`). Place them like any block (Layout Builder or
*Block layout*); placement is gated by core `administer blocks`.

## `AdInserterBaseBlock` (abstract)

- DI: `entity_type.manager` (→ `ad_inserter` storage) and `module_handler`.
- `build()`:
  1. `getAdInserter()` (subclass-specific); returns `NULL` (renders nothing) if the ad is missing or
     `!isActive()`.
  2. Fires the alter hook: `moduleHandler->invokeAll('ad_inserter_alter_status', [$adInserter, &$options])`
     with `$options['status']` default TRUE; if a hook sets it FALSE the block renders nothing.
  3. Adds wrapper class `ad-inserter-block`; if `screen != 'all'` also adds `hidden` (revealed later by JS).
  4. Adds data attributes `data-ad-inserter-id`, `data-ad-inserter-screen`, and (if set)
     `data-ad-inserter-machine-name`.
  5. Attaches library `ad_inserter/loader` and renders the ad via the `ad_inserter` view builder.
- `getCacheTags()` merges the ad entity's cache tags.

## `AdInserterBlock` (id `ad_inserter`)

`src/Plugin/Block/AdInserterBlock.php`. Config key `ad_inserter_id`. `blockForm()` shows an
`entity_autocomplete` (`#target_type = ad_inserter`) to pick the ad; `getAdInserter()` loads it by id
from storage. Admin label "Ad Inserter".

## `AdInserterMachineNameBlock` (id `ad_inserter_machine_name`)

`src/Plugin/Block/AdInserterMachineNameBlock.php`. Config key `ad_inserter_machine_name`. `blockForm()`
is a required textfield; `blockValidate()` rejects a machine name that `AdInserterStorage::loadByMachineName()`
cannot resolve; `getAdInserter()` loads by machine name. Admin label "Ad Inserter by machine name".
Use this when you want the same block config to work across environments where entity ids differ.

## Loader library & screen targeting

- Library `ad_inserter/loader` (`ad_inserter.libraries.yml`) → `js/ad-inserter-loader.js`; deps
  `core/jquery`, `core/drupalSettings`, `core/once`.
- `hook_page_attachments()` publishes `drupalSettings.ad_inserter.mobile_breakpoint` from
  `ad_inserter.settings` on every page.
- `Drupal.behaviors.ad_inserter` runs once per `.ad-inserter-block`:
  - Computes `hideScreen` = `mobile` if `window.width() <= mobile_breakpoint` else `desktop`.
  - If the block's `screen` is neither the current `hideScreen` nor `all`, the block is **removed**
    from the DOM (so, e.g., a `desktop` ad on a narrow viewport never loads its script).
  - For a matching non-`all` block it `atob()`-decodes the base64 body (encoded server-side in
    `template_preprocess_ad_inserter()`) and injects it, then removes the `hidden` class.
  - `all` ads are shown immediately (not encoded, not deferred).

This base64/decode dance is a display/perf mechanism (defer running an ad's `<script>` until the
viewport is known), not an access control. The ad markup is authored server-side by holders of
`administer ad inserter`.

## Extending: `hook_ad_inserter_alter_status`

Implement `hook_ad_inserter_alter_status(\Drupal\ad_inserter\Entity\AdInserter $ad, array &$options)`
and set `$options['status'] = FALSE` to suppress a specific ad at render time (e.g. consent gating,
A/B logic). Invoked in `AdInserterBaseBlock::build()`.
