<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Severity colors: the alerts_format_views_pre_render hook

The entire module is `alerts_format_views_pre_render(ViewExecutable $view)` in
`alerts_format.module`.

## What it does, step by step

1. **Guard:** runs only when `$view->storage->id() == 'alerts'`. Every other View is ignored.
2. **Load severities:** `\Drupal::entityTypeManager()->getStorage('taxonomy_term')
   ->loadByProperties(['vid' => 'alert_severity', 'status' => 1])`. Returns **published** terms
   of the `alert_severity` vocabulary, keyed by term id. If none, the hook returns early (no
   styles).
3. **Build rules:** for each term it reads `$term->field_color->first()->getString()` and builds
   `$colors[$tid] = '.alert-severity-' . $tid . ' { background: ' . $color . '; }'`.
4. **Attach:** pushes onto `$view->element['#attached']['html_head']` a render element
   `[['#tag' => 'style', '#value' => implode("\r\n", $colors)], 'ALERTS']`. Drupal renders this as
   an inline `<style>` block in `<head>` (the `'ALERTS'` string is the html_head key). Core's
   `HtmlTag::preRenderHtmlTag()` admin-XSS-filters `#value` before output.

Net effect: alert markup carrying a `class="alert-severity-<tid>"` (emitted by the Alerts recipe's
View/template) gets the background color configured on that severity's taxonomy term.

## Install / enable

- `drush en alerts_format -y` (or via the UI). No configuration form, no settings.
- It only produces output when the **`alerts` View** exists and renders a page, the
  **`alert_severity`** vocabulary exists with published terms, and each such term has a populated
  **`field_color`** field. These are supplied by the **Alerts recipe** (`drupal/alerts` recipe) —
  this module ships none of them. Without them the hook simply no-ops.

## Requirements / assumptions (all implicit, not declared)

- `alerts_format.info.yml` declares **no** `dependencies`. At runtime the hook type-hints
  `Drupal\views\ViewExecutable` (needs **views** enabled) and uses **taxonomy** term storage.
- Assumes a `field_color` field on `alert_severity` terms holding a CSS color string; a term
  missing that field/value would make `->first()->getString()` fail (robustness caveat — populate
  colors on every published severity term).

## Operating notes

- To recolor alerts, edit the `field_color` value on the relevant `alert_severity` taxonomy
  term(s); no code or CSS change needed. Unpublished severity terms are excluded.
- The style block is attached through the View's render array, so it appears only on responses
  that render the `alerts` View (e.g. a Views block in a header region), not site-wide.
- For full-width Olivero header banners plus a dismiss button, also enable the
  **`alerts_format_olivero`** submodule.
