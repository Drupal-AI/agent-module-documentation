<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Read Time Calculator tamper plugin

`src/Plugin/Tamper/ReadTimePlugin.php` — the module's only class. It provides one Tamper plugin
that computes an estimated reading time (whole minutes) from an HTML value.

## Install & enable

- `composer require drupal/feed_tamper_read_time`, then enable `feed_tamper_read_time`.
- Requires the **Tamper** module (`tamper:tamper`, info.yml `dependencies`). Tamper is normally
  paired with **Feeds Tamper** / Feeds so you can attach tampers to import mappings, but this
  module only depends on Tamper itself.

## Plugin definition

Annotation on `ReadTimePlugin` (extends `Drupal\tamper\TamperBase`):

- `id = "feed_tamper_read_time"`
- `label = "Read Time Calculator"`
- `description = "Calculates reading time from HTML content with configurable WPM."`
- `category = "Other"`

No new plugin type is declared; this is a plugin *instance* for Tamper's plugin type. The class
constant `SETTING_WPM = 'wpm'` names the single setting.

## Configuration (one setting: `wpm`)

- `defaultConfiguration()` — `parent::defaultConfiguration()` plus `wpm = 200`.
- `buildConfigurationForm()` — renders one form element keyed `wpm`:
  - `#type => number`, `#title` "Words Per Minute (WPM)"
  - `#default_value => $this->getSetting('wpm')`
  - `#min => 50`, `#max => 1000`, `#step => 10`
- `submitConfigurationForm()` — calls `parent::submitConfigurationForm()`, reads
  `$form_state->getValue('wpm')`, and persists it with `$this->setConfiguration(['wpm' => $wpm])`.

The setting is stored as part of the tamper instance configuration (managed by Tamper); this
module ships **no** `config/install` or `config/schema` of its own.

## Runtime: `tamper($data, TamperableItemInterface $item = NULL)`

1. `$text = $this->extractTextFromHtml($data)` (see below).
2. Word count: `$words = preg_split('/\s+/', trim($text), -1, PREG_SPLIT_NO_EMPTY);
   $wordCount = count($words);`.
3. Rate: `$wpm = (int) $this->getSetting('wpm');` and if `$wpm < 1` it falls back to `200`
   (guards against zero/negative → no division by zero).
4. `$readingTimeMinutes = ceil($wordCount / $wpm);`.
5. Returns `(string) $readingTimeMinutes` — a plain numeric string, e.g. `"5"`. The `$item`
   argument is accepted but unused; the plugin transforms only the scalar value it is given.

## `extractTextFromHtml($html)` (private)

- `new \DOMDocument()`, then
  `@$dom->loadHTML(mb_convert_encoding($html, 'HTML-ENTITIES', 'UTF-8'),
  LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD)` — no implied `<html>/<body>` wrapper, no doctype,
  parse warnings suppressed with `@`.
- Removes every `<script>` and `<style>` element (`getElementsByTagName` → `removeChild`).
- `new \DOMXPath($dom)` → `query('//text()[normalize-space()]')` gathers the non-empty text nodes;
  each `nodeValue` is trimmed and joined with a single space.
- `preg_replace('/\s+/', ' ', $text)` collapses runs of whitespace; returns the trimmed result.

Net effect: only the visible text contributes to the word count; markup, scripts, and styles are
discarded before counting.

## How to use it

1. In a Feeds/Tamper mapping (or any Tamper pipeline) for the field carrying the HTML body, add a
   tamper and choose **Read Time Calculator**.
2. Set **Words Per Minute (WPM)** (default 200; 50–1000).
3. Map the plugin's output — the minute count string — into your read-time field (a number or text
   field). On each import the value is recomputed from the current source content.

## Caveats

- The `'HTML-ENTITIES'` argument to `mb_convert_encoding()` is deprecated as of PHP 8.2; it may emit
  a deprecation notice on newer PHP but does not change behaviour.
- The whole value is parsed into a DOM on each run; very large HTML values cost proportional
  memory/time. Content comes from the admin-configured import source (trusted pipeline input).
