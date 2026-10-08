<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tracker delivery & `hook_advanced_mautic_integration_tracker_alter()`

How the tracker reaches the page in 1.2.x, and the one extension hook the module exposes. Config keys
and client behaviour are in [../config/settings.md](../config/settings.md).

## Delivery pipeline (changed in 1.2.x)

1. `AdvancedMauticIntegrationHooks::pageTop()` (`#[Hook('page_top')]`) asks
   `VisibilityTracker::isVisible()`. When true it adds a render element with
   `#lazy_builder => ['advanced_mautic_integration.tracker_placeholder:build', []]` and
   `#create_placeholder => TRUE`, and applies the visibility cacheability to `$page_top`. The
   visibility decision caches *with* the page; the tracker is built *per request*.
2. `TrackerPlaceholder::build()` (service `advanced_mautic_integration.tracker_placeholder`, a
   `TrustedCallbackInterface` whose `trustedCallbacks()` returns `['build']`) returns a render array
   with **no markup** — only `#attached`:
   - library `advanced_mautic_integration/tracking_events`;
   - `drupalSettings.advancedMauticIntegration` = `MauticScript::getTrackingSettings($metadata)`.
   The settings' own cacheability (collected into `$bubbleable_metadata`) is merged into the build
   via `BubbleableMetadata::createFromRenderArray($build)->merge($bubbleable_metadata)->applyTo($build)`
   (the other way round, because `applyTo()` replaces rather than merges attachments).
3. `build()` then calls `$this->moduleHandler->alter('advanced_mautic_integration_tracker', $build)`
   — the extension point below — and returns `$build`.

Because the tracker is a placeholder, a default parameter that names the visitor (e.g.
`[current-user:mail]`, which carries the user cache context) does **not** drag the whole page out of
the Dynamic Page Cache: the page is shared, the tracker is rendered on every request. With BigPipe it
is streamed after the page for sessioned visitors; otherwise it is rendered in place before the
response is sent.

## `hook_advanced_mautic_integration_tracker_alter(array &$build)`

Declared in `advanced_mautic_integration.api.php`. Alters the tracker's render array *before it is
delivered*, so anything added to `$build['#attached']` reaches the browser **together with** the
tracker — whether the page is served whole or BigPipe streams the tracker after it. Attaching the same
code to the page instead risks it running before the tracker's settings exist.

```php
function hook_advanced_mautic_integration_tracker_alter(array &$build): void {
  $build['#attached']['library'][] = 'my_module/mautic_consent';
  $build['#attached']['drupalSettings']['myModule']['consentCategory'] = 'marketing';
}
```

`$build['#attached']` carries the `advanced_mautic_integration/tracking_events` library and the
`advancedMauticIntegration` settings; `$build['#cache']` carries their cacheability. The primary use is
a consent adapter that reports a decision to `Drupal.advancedMauticIntegration.consent()` (see
[../config/consent.md](../config/consent.md)); the bundled `advanced_mautic_integration_klaro`
submodule implements exactly this hook to add its `appId` setting and `consent` library.

## Other hooks (`Hook\AdvancedMauticIntegrationHooks`)

OOP `#[Hook]` methods on the hook-implementation service; the `.module` file forwards each for Drupal 10
via `#[LegacyHook]`.

- `#[Hook('help')]` — help text for the module page and the settings route.
- `#[Hook('page_top')]` — the delivery step above.
- `#[Hook('user_insert')]` / `#[Hook('user_update')]` — the user→contact sync trigger (see
  [../api/api.md](../api/api.md)).
