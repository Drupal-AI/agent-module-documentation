<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# D2: Text Filter (d2_filter) — agent index

Submodule of **D2: Declarative Diagramming** (`../../../../1.0.x/agent/start.md`). Adds one text-format filter
that renders `[d2]...[/d2]` blocks to inline SVG. Core `^11`, PHP `^8.1`, GPL-2.0-or-later. Depends on `d2:d2`.

## What it provides
- **Filter plugin `filter_d2`** — `Drupal\d2_filter\Plugin\Filter\FilterD2`
  (`src/Plugin/Filter/FilterD2.php`). Annotation: title "D2 Filter", type
  `FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE`, weight `-10`.
  - `process($text, $langcode)`: `preg_replace_callback('@\[d2\](.+?)\[/d2\]@s', ...)` — each block's inner text
    is passed to `processD2()` → `(new \Drupal\d2\D2Helper())->getSvg($text)`, returning a `FilterProcessResult`.
  - `tips($long)` / `help($long)`: short and long D2 syntax help strings.

## No routes / permissions / config
No routing, services, permissions, or config schema. Behaviour and error handling (caching, the
`view d2 diagram errors` permission) all live in the parent module's `D2Helper` — see
`../../../../1.0.x/agent/api/rendering.md`.

## Operate
1. `drush en d2_filter` (pulls in `d2`).
2. Add "D2 Filter" to a text format at Configuration > Content authoring > Text formats and editors.
3. Write `[d2]...[/d2]` blocks in content using that format.

## Solution docs
- Filter details: [agent/filters/filter_d2.md](filters/filter_d2.md)
