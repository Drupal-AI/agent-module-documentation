<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cincopa tag filter (`filter_cincopa`)

Class `Drupal\cincopa\Plugin\Filter\FilterCincopa` (`src/Plugin/Filter/FilterCincopa.php`),
a `FilterBase` of type `TYPE_TRANSFORM_IRREVERSIBLE`, title "Parse Cincopa Tags". This is
the module's primary integration and the only path that works on Drupal 10/11.

## What it does (`process($text, $langcode)`)

1. Runs `preg_replace_callback("/\[cincopa ([[:print:]]+?)\]/", …)` over the text. Every
   `[cincopa <id>]` tag is replaced with a placeholder element:
   `<div id="_cp_widget_<uniqid>">...</div>` where `<uniqid>` comes from `uniqid('')`.
2. For each match it records `arg0` (the full original tag, e.g. `[cincopa 123]`), `arg1`
   (the captured id/params), and `arg2` (the placeholder div id `_cp_widget_<uniqid>`) into
   an array keyed by the uniqid.
3. Returns a `FilterProcessResult` with two attached libraries —
   `cincopa/cincopa.filter.main` and `cincopa/cincopa.filter` — and passes the recorded
   matches to the page as `drupalSettings.cincopa`.

The captured value reaches the browser only through `drupalSettings` (JSON-serialized by
Drupal) and the placeholder div id is a server-generated `uniqid`, not user input.

## Client-side rendering

- `cincopa.filter.main` loads the **external** Cincopa runtime
  `https://www.cincopa.com/media-platform/runtime/libasync.js` (declared
  `{type: external, minified: true}` in `cincopa.libraries.yml`).
- `cincopa.filter` loads local `js/plugin.js`. Its `Drupal.behaviors.main` iterates
  `drupalSettings.cincopa` and calls `cp_load_widget(arg0, arg2)` (the Cincopa tag string +
  the placeholder div id). `cp_load_widget` is defined by the external runtime and injects
  the gallery/video/audio player into the placeholder div in the visitor's browser.

No API key, token, or account credential is stored by Drupal or sent from the server; the
gallery id alone identifies content in the author's Cincopa account.

## Setup / operate

1. Enable the module: `drush en cincopa` (appears under Extend → "Input filters").
2. Go to Administration → Configuration → Content authoring → Text formats and editors,
   Configure the target format, enable **"Parse Cincopa Tags"**, save.
3. In content using that format, insert `[cincopa <gallery-id>]` (id from the Cincopa
   galleries management page). Multiple tags per page are supported (each gets its own
   uniqid placeholder). Enable the filter only on formats where embeds are wanted.

Note: because the tag is transformed on output, the module effectively bypasses caching of
the affected text; scope the filter to formats where that trade-off is acceptable
(per `README.txt`).
