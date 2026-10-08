<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions Policy — mechanism, feature list & alter event

## How the header is produced

`ResponseSubscriber` (service `permissionspolicy.response_subscriber`) subscribes to
`KernelEvents::RESPONSE`. On the main request it:

1. Loads config `permissionspolicy.settings`; adds cache tag `config:permissionspolicy.settings`.
2. For the `enforce` policy, skips if `enforce.enable` is false.
3. Builds a `PermissionsPolicy` object, calling `setFeature($name, [...])` per configured
   feature based on its `base` (`self`→`['self']`, `none`→`['none']`, `any`→`['*']`, else
   `[]`) and then `appendFeature($name, $sources)` for any `sources`.
4. Dispatches `PolicyAlterEvent` (`PermissionsPolicyEvents::POLICY_ALTER`,
   `"permissionspolicy.policy_alter"`) so other modules can mutate the policy.
5. If the policy serializes to a non-empty value, sets the `Permissions-Policy` header;
   otherwise removes it.

## Serialization (`PermissionsPolicy` class)

`getHeaderValue()` sorts features alphabetically and serializes them as an RFC 8941
**structured-fields dictionary** using `gapple/structured-fields`. `reduceAllowlist()`
normalizes each feature's origin list:

- `none` present → empty allowlist → `feature=()`.
- `*` (any) present → `feature=*`.
- `self` / `*` are emitted as bare tokens; explicit origins as quoted strings.

Constants: `ORIGIN_ANY = '*'`, `ORIGIN_NONE = 'none'`, `ORIGIN_SELF = 'self'`.
Header name is always `Permissions-Policy`.

## Valid feature names

`PermissionsPolicy::FEATURES` (all use the `allowlist` schema). Standardized/common ones:

`accelerometer`, `ambient-light-sensor`, `attribution-reporting`, `autoplay`, `battery`,
`bluetooth`, `camera`, `ch-ua*` (client hints), `compute-pressure`, `cross-origin-isolated`,
`display-capture`, `encrypted-media`, `execution-while-not-rendered`,
`execution-while-out-of-viewport`, `fullscreen`, `geolocation`, `gyroscope`, `hid`,
`idle-detection`, `keyboard-map`, `magnetometer`, `microphone`, `midi`, `navigation-override`,
`payment`, `picture-in-picture`, `publickey-credentials-get`, `screen-wake-lock`, `serial`,
`storage-access`, `sync-xhr`, `usb`, `web-share`, `window-management`, `xr-spatial-tracking`.

Proposed/experimental include: `clipboard-read`, `clipboard-write`, `gamepad`,
`speaker-selection`, `browsing-topics`, `interest-cohort`, `join-ad-interest-group`,
`run-ad-auction`, `local-fonts`, `unload`, `vertical-scroll`, `document-domain`.

`PermissionsPolicy::isValidFeatureName($name)` validates; an unknown name throws
`\InvalidArgumentException`.

## Programmatic policy alter

```php
// In a module's EventSubscriber, listening on PermissionsPolicyEvents::POLICY_ALTER.
public function onPolicyAlter(\Drupal\permissionspolicy\Event\PolicyAlterEvent $event): void {
  $policy = $event->getPolicy();          // PermissionsPolicy
  $policy->setFeature('camera', ['none']);
  $policy->appendFeature('fullscreen', ['https://embed.example.com']);
  // $event->getResponse() is also available for response-aware decisions.
}
```

`PermissionsPolicy` methods: `setFeature($name, $value)`, `appendFeature($name, $value)`,
`removeFeature($name)`, `hasFeature($name)`, `getFeature($name)`, `getHeaderName()`,
`getHeaderValue()`. No Drush commands and no plugin types are provided.
