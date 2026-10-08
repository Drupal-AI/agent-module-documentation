<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feed Tamper Read Time (feed_tamper_read_time) — agent index

A single **Tamper plugin** that converts an HTML value into an estimated reading time in whole
minutes, for use inside Feeds/Tamper import pipelines. License GPL-2.0-or-later.
Version 1.0.0 (dir 1.0.x). Core `^9 || ^10 || ^11`.

- **The plugin, its WPM setting, and the extract/count/divide pipeline** →
  [plugins/read-time.md](plugins/read-time.md)

## What it actually is

- One plugin: `ReadTimePlugin` (id **`feed_tamper_read_time`**, label *"Read Time Calculator"*,
  category *"Other"*), in `src/Plugin/Tamper/ReadTimePlugin.php`, extending
  `Drupal\tamper\TamperBase`.
- Hard dependency on **`tamper:tamper`** (info.yml). It ships no routes, no permissions, no
  services, no config schema, no Drush, no hooks, no install file — just the one plugin class and
  its `LICENSE.txt`/`.info.yml`.
- It does not define a plugin *type*; it provides one instance for the Tamper plugin type. You add
  it to a field via the Feeds/Tamper UI ("Add tamper" → *Read Time Calculator*).

## Mechanism (from source)

- `defaultConfiguration()` sets `wpm = 200`.
- `buildConfigurationForm()` exposes one `#type = number` field **Words Per Minute (WPM)**:
  `#default_value` the current `wpm`, `#min` 50, `#max` 1000, `#step` 10.
- `submitConfigurationForm()` stores the submitted `wpm` via `setConfiguration()`.
- `tamper($data, $item = NULL)` → `extractTextFromHtml($data)` → `preg_split('/\s+/', …,
  PREG_SPLIT_NO_EMPTY)` word count → `(int) wpm` (fallback 200 if `< 1`) → `ceil(words / wpm)` →
  returns the minute count as `(string)`. Output is a numeric string only.
- `extractTextFromHtml()` loads the HTML into `\DOMDocument` (`loadHTML` with
  `LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD`, warnings suppressed), removes all `<script>` and
  `<style>` nodes, collects `//text()[normalize-space()]` via `\DOMXPath`, joins with spaces, and
  collapses whitespace.

## Notes / caveats

- `wpm` const is `ReadTimePlugin::SETTING_WPM` (`'wpm'`).
- The form clamps WPM to 50–1000; the runtime additionally guards against `< 1` by falling back to
  200, so an out-of-range or missing value never divides by zero.
- `extractTextFromHtml()` calls `mb_convert_encoding($html, 'HTML-ENTITIES', 'UTF-8')`, whose
  `'HTML-ENTITIES'` target is **deprecated as of PHP 8.2** — expect a deprecation notice on newer
  PHP; it is not a behavioural bug.
