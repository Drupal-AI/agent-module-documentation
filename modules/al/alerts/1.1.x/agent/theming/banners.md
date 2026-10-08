<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alert banners — rendering, styling, dismissal

How an alert becomes a colored, dismissible banner. Two `hook_views_pre_render()` implementations plus the view's `block_1` row rewrite do the work; the `alerts_olivero` submodule supplies the CSS/JS.

## Per-severity color CSS (`alerts.module`)
`alerts_views_pre_render(ViewExecutable $view)` runs only for the view whose id is `alerts`. It loads every published `alert_severity` term, and for each builds a rule from the term's `field_color`:
```
.alert-severity-{tid} { background: {field_color}; }
```
All rules are joined and attached as an inline `<style>` element via `$view->element['#attached']['html_head']` (key `ALERTS`). So the banner background for a given alert comes from the color set on its severity term, keyed by the term id. `$color` is read from the color_field (`$term->field_color->first()->getString()`); the class selector uses the integer term id.

## Banner markup (view `block_1` row rewrite)
The `block_1` display (`views.view.alerts.yml`) excludes the `field_severity` (as `entity_reference_entity_id`) and `uuid` fields and rewrites the `title` field with this template (Views field "Rewrite results"):
```
<div role="alert" class="alert-banner alert-severity-{{ field_severity }}" id="alert-{{ uuid }}">{{ title }}</div>
```
`{{ field_severity }}` = the severity term id (matches the CSS class above), `{{ uuid }}` = node UUID (used as the DOM id for dismissal), `{{ title }}` = the node title field (rendered as a link to the node, `settings.link_to_entity: true`). The block shows the 5 most recent published alerts.

## Olivero submodule (`alerts_olivero`)
`alerts_olivero_views_pre_render()` (`modules/alerts_olivero/alerts_olivero.module`) attaches `alerts_olivero/olivero_display` to the `alerts` view. The library (`alerts_olivero.libraries.yml`) loads:
- `css/olivero-display.css` — positions the banner block full-width in the Olivero (and Gin toolbar) header, styles the anchor, the `messages__close` dismiss button, and the "Add Alert" header button.
- `js/alerts-dismiss.js` — depends on `core/drupal` + `core/once`.

`block.block.views_block__alerts_block_1.yml` (submodule `config/install`) places `views_block:alerts-block_1` in Olivero's `header` region.

## Dismissal JS (`js/alerts-dismiss.js`)
`Drupal.behaviors.alertsDismiss`:
- For each `div.alert-banner`, appends a `messages__close` button (labeled "Dismiss Alert" via `Drupal.t`) to the banner's first child.
- On click, hides the banner (`parent.style.display = "none"`) and pushes the banner's DOM id (`alert-{uuid}`) into a `dismissed` array persisted in `localStorage` under the key `dismissed`.
- On load, reads `dismissed` from `localStorage` and hides any matching banner. Ids no longer found on the page are pruned from the list — except while viewing an alert node (`body.page-node-type-alert`), so opening one alert does not forget the others.

Dismissal is entirely client-side (browser `localStorage`); nothing is written server-side and no route is involved.

## Replicating in a custom theme
On a non-Olivero theme, mirror `olivero-display.css` and `alerts-dismiss.js` in your theme (or extend the alert bundle / severity terms with extra fields — e.g. an icon — and add a Views relationship to the term to render them). The README notes you can instead hard-code severity backgrounds in your theme and uninstall the module, since the only runtime behavior it adds is the `<style>` injection.
