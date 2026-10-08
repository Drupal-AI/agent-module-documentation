<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSP integration + iframe resizing (mechanism)

Two moving parts beyond the formatter: an optional CSP event subscriber and a JS resizer.

## CSP `frame-src` subscriber

Service `media_qualtrics.host_subscriber`
(`Drupal\media_qualtrics\EventSubscriber\AllowedHostsCspEventSubscriber`), args
`@router.admin_context`, `@config.factory`. Subscribes to the CSP module's
**`csp.policy_alter`** event (only fires when the [`csp`](https://www.drupal.org/project/csp)
module is installed — it is a soft dependency, not required).

On non-admin routes it appends every `allowed_hosts` value to the `frame-src` directive
(setting the directive if it does not already exist). This lets the Qualtrics iframes load on
public pages without hand-editing the CSP policy. Admin routes are left untouched. The settings
form's description also hints at this when CSP is detected.

## JS iframe resizer

Library `media_qualtrics/qualtrics-controller` (`js/qualtrics-controller.js` +
`css/qualtrics-styles.css`, deps `core/drupal`, `core/drupalSettings`, `core/once`), attached
by the formatter. Together with the `Q_CHL=si` query parameter on the iframe `src`, it listens
for post-message height updates from Qualtrics and resizes `iframe.qualtrics-embed-container`
so the embedded survey is not scrollbar-clipped.

## Theme hook

`hook_theme()` registers `media_qualtrics` with variables `url`, `title`, `link`, rendered by
`templates/media-qualtrics.html.twig`. That is the entire `.module` file — no other hooks.
