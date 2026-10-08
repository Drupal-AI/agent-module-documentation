<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a generic ad load/remove handler (by example)

## Install & enable

```bash
drush en ad_entity_generic_example -y
```

Requires `ad_entity_generic`. Enabling it attaches `ad_entity_generic_example/loader` on every page
(`ad_entity_generic_example_page_attachments()`). The library depends on `ad_entity_generic/base`,
which provides `window.adEntity.generic`.

## The handler contract (from `js/example.loader.js`)

The generic provider (see the ad_entity_generic module) collects each `.adtag` container into an
`ad_tag` object and passes an array of them to every registered load handler via
`adEntity.generic.load()`. An `ad_tag` has:

- `id` — the container DOM element id (string).
- `el` — the container DOM element.
- `name` — the ad's internal machine name (string).
- `format` — the configured display format (string; from `data-ad-format`).
- `targeting` — common + ad-specific targeting, including `slotNumber`, `onPageLoad`, and
  `personalized`.
- `done(success, isEmpty)` — **call this when loading finishes**; sets the reserved `isLoaded` /
  `isEmpty` flags and flips the container's CSS state classes.
- `isLoaded`, `isEmpty` — reserved flags set by `done()`.
- `data(key, value)` — get/set `data-*` helper (jQuery-like).

Consent tip from the example: `window.adEntity.usePersonalization()` returns `true`/`false`/`null`.

## The pattern the example shows

```js
(function (adEntity) {
  var loadCallback = function (ad_tags) {
    var ad_tag = ad_tags.shift();          // consume tags you own
    while (typeof ad_tag === 'object') {
      // ... load the creative into ad_tag.el using ad_tag.format / targeting ...
      ad_tag.done(true, false);            // report success, not empty
      ad_tag = ad_tags.shift();
    }
  };
  var removeCallback = function (ad_tags) { /* cleanup on detach */ };

  // Ensure the queue object exists.
  adEntity.generic = adEntity.generic || {toLoad: [], toRemove: [], loadHandlers: [], removeHandlers: []};

  // unshift => run before the built-in "queue" handler.
  adEntity.generic.loadHandlers.unshift({name: 'example_loader', callback: loadCallback});
  adEntity.generic.removeHandlers.unshift({name: 'example_on_removal', callback: removeCallback});

  // Handle tags that were already queued before this (async) script loaded.
  loadCallback(adEntity.generic.toLoad);
  removeCallback(adEntity.generic.toRemove);
}(window.adEntity));
```

Key points the comments stress:

- Multiple load handlers can run; each should `shift()` off only the tags it owns. If you need to
  forward the whole set elsewhere, push a flat **copy** (other handlers also drain the array).
- A built-in `queue` handler (in `ad_entity_generic/base`) runs after custom handlers and moves any
  remaining tags onto the global `toLoad` / `toRemove` arrays — hence the direct check on those
  queues at the end, for tags that arrived before an asynchronously loaded loader.
- The example handlers only `console.log`; do not ship that to production.

## What this module does not do

No config, no config entities, no permissions, no services, no config schema. It is purely a
readable example; create generic-type Advertising entities separately (ad_entity_generic) to see
the handler fire.
