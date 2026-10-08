<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alerts - Olivero display (CSS + dismissal JS)

## Attachment
`alerts_olivero_views_pre_render(ViewExecutable $view)` (`alerts_olivero.module`) checks `$view->id() == 'alerts'` and, if so, appends `alerts_olivero/olivero_display` to `$view->element['#attached']['library']`. So the styling and JS load only where the alerts view renders.

The library (`alerts_olivero.libraries.yml`):
```
olivero_display:
  css: { component: { css/olivero-display.css: {} } }
  js:  { js/alerts-dismiss.js: {} }
  dependencies: [ core/drupal, core/once ]
```

## CSS (`css/olivero-display.css`)
Targets the alerts Views block (`.block-views-blockalerts-block-1`) and `.alert-banner`. Makes the banner span the full header width in Olivero, with a `min-width: 75rem` breakpoint and a Gin vertical-toolbar variant (`body.gin--vertical-toolbar`, `--ginVerticalToolbarOffset`). Styles the banner anchor (bold, white, padded), the `.messages__close` dismiss button (absolute right), and the `add_content_by_bundle` "Add Alert" header button (`.view-header .button`). Purely presentational; the per-severity background color comes from the parent module's injected `<style>` (`.alert-severity-{tid}`).

## Dismissal JS (`js/alerts-dismiss.js`)
`Drupal.behaviors.alertsDismiss.attach(context)`:
- `once('alertsAddDismiss', 'div.alert-banner', context)` → for each banner, `augmentAlert(element.firstElementChild)` appends a `messages__close` button whose label is `Drupal.t('Dismiss Alert')` inside a `visually-hidden` span.
- `once('alertsStorage', 'html', context)` → reads the `dismissed` array from `localStorage`; hides any banner whose id is listed (`element.style.display = "none"`). Entries whose element is not present are spliced out — **unless** `document.body.classList.contains('page-node-type-alert')` (viewing a single alert), so opening one alert does not drop the others from the list; the pruned list is written back only if something changed.
- `buttonClick(element)` (on button click): hides the banner's parent, pushes `parent.id` (`alert-{uuid}`) into `dismissed`, and `localStorage.setItem('dismissed', JSON.stringify(dismissed))`.

### localStorage contract
- Key: `dismissed` — a JSON array of banner DOM ids of the form `alert-{node-uuid}` (the id emitted by the parent view's `block_1` title rewrite).
- Scope: per browser, client-side only. Nothing is sent to the server; there is no dismiss route or stored server state. Clearing site data re-shows all banners.
