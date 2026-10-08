<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How htmLawed filtering works

Source: `src/Plugin/Filter/Filterhtmlawed.php` (plugin `filter_htmlawed`) + bundled library
`htmLawed/htmLawed.php` (`hl_version()` = `1.2.15`).

## Filter plugin

- `@Filter(id = "filter_htmlawed", type = TYPE_HTML_RESTRICTOR, weight = 50)`.
- Extends `FilterBase`; implements `process()`, `settingsForm()`, and `tips()`.
- It **implements** core's filter plugin type — it does **not define** a new plugin type.

## `process($text, $langcode)` steps

1. Read the `config` setting; if non-empty, build the htmLawed `$config` array with
   `eval('$config = array(' . $settings['config'] . ');');`. If the result is not an array it falls
   back to the safe default (`safe=1`, the default element list, `deny_attribute => id, style`).
2. If `config['save_php']` is set, `<?php … ?>` blocks are temporarily masked (special `\x83`/`\x84`
   sentinels, `<`/`>`/`&` entity-encoded) so htmLawed does not mangle them — they are restored after.
3. Load the library: if the contrib **Libraries** module (API 3.x) exposes `htmLawed`, use that;
   otherwise `include_once` the module's bundled `htmLawed/htmLawed.php`.
4. Call `htmLawed($text, $config, $settings['spec'])` — the actual restrict/correct/purify pass.
5. Normalise `<!--break -->` back to `<!--break-->` (htmLawed reformats comments).
6. Restore any masked PHP blocks.
7. Return a `FilterProcessResult($text)`.

## What htmLawed does to the markup

- Removes tags/attributes not permitted by `elements`/`deny_attribute`.
- With `safe => 1`, strips scriptable/dangerous constructs (event handlers, `script`, `javascript:` URLs, …).
- Balances and correctly nests tags and closes unclosed ones; fixes broken/chopped HTML.
- Can restrict URL `schemes`, enforce attribute-value ranges via `spec`, transform deprecated tags, etc.
- Does **not** linkify URLs and does **not** convert newlines to `<br>`/`<p>` — that is other filters' job.

## Filter ordering

htmLawed should normally be the **last** filter (highest weight) so any markup produced by earlier
filters is still validated. If an earlier filter emits tags you want to keep, add them to `elements`.

## Library / Libraries module

`htmlawed_libraries_info()` registers the `htmLawed` library for the contrib Libraries module; when
present and loaded it is used instead of the bundled copy. To update the bundled library, replace
`htmLawed/htmLawed.php` and `htmLawed/htmLawed_README.htm` with newer upstream versions.
