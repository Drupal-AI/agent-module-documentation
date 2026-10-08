# Configure the app-association files

All four forms live under `admin/config/mobile-app-links/*` and require the
**`administer mobile app links`** permission. The `configure` route `mobile_app_links.config`
is the admin menu block landing page.

## Config forms → config objects → served file

| Form route | Config object | Served at | Controller method |
|---|---|---|---|
| `mobile_app_links.ios_config` (`/ios`) | `mobile_app_links.ios` | `/.well-known/apple-app-site-association` | `appleAppSiteAssociation()` |
| `mobile_app_links.android_config` (`/android`) | `mobile_app_links.android_packages` | `/.well-known/assetlinks.json` | `assetLinks()` |
| `mobile_app_links.apple_dev_id_assoc_config` (`/apple-dev-id-assoc`) | `mobile_app_links.apple_dev_id_assoc` | `/.well-known/apple-developer-domain-association.txt` | `getAppleDevId()` |
| `mobile_app_links.apple_dev_merchant_id_assoc_config` (`/apple-dev-merchant-id-assoc`) | `mobile_app_links.apple_dev_merchantid_assoc` | `/.well-known/apple-developer-merchantid-domain-association.txt` | `getAppleDevMerchantId()` |

All four served routes are **public** (`_access: TRUE`) — Apple and Google require these files to
be reachable by anyone for the app-domain association to verify. Responses are cacheable and tied
to the source config's cache tags.

## iOS form (`IosConfigForm`)

Repeatable "App Configurations" fieldset; **Add More** / **Delete** rebuild via AJAX. Per entry:
- **App ID** (`appID`) — Apple team-qualified app ID; entries with an empty appID are dropped.
- **Paths** (`paths`) — newline-separated path patterns (normalized to `PHP_EOL`).
- **App Clips** (`appclips`) — the appclips app id string.
- **App IDs** (`appids`) — multivalue list of extra app IDs.
- **Defaults** (`defaults`) — newline-separated `key : bool` lines (e.g. `caseSensitive : false`).
- **Upload File** (`components`) — a managed `.json` file (upload location `public://uploads/`);
  on save the file is made permanent, and `appleAppSiteAssociation()` reads it back with
  `file_get_contents()` + `json_decode()` into the `components` array of that entry.

The controller assembles `applinks.details[]` (each `array_filter`-ed) plus an `appclips.apps`
block, then returns `json_encode(..., JSON_UNESCAPED_SLASHES)`.

## Android form (`AndroidConfigForm`)

Repeatable "Android App Configurations"; per entry **Package Name** (`package_name`) and
**SHA256 Certificate Fingerprints** (`sha256_cert_fingerprints`, newline-separated, normalized).
`assetLinks()` emits one object per package:
`{ "relation": ["delegate_permission/common.handle_all_urls"],
   "target": { "namespace": "android_app", "package_name": …, "sha256_cert_fingerprints": [<split on newline>] } }`.

## Apple developer / merchant ID forms

Each is a single textarea saved to `apple_dev_id_assoc` / `apple_dev_merchant_id_assoc`. The
controller returns the raw string as `text/plain`. Note: `getAppleDevId()` returns a cacheable
**404** when empty; `getAppleDevMerchantId()` returns the (empty) body with a 200.

## Path handling

`MobileAppLinksPathProcessor` (services `path_processor_inbound` prio -500 /
`path_processor_outbound` prio 500) sets `_disable_route_normalizer` on inbound `.well-known`
requests and nulls the language option on outbound, so the files resolve at the literal
`.well-known/...` URL even on multilingual sites with URL-prefix negotiation.

## Drush example

```php
// drush php:eval — register one Android package.
\Drupal::configFactory()->getEditable('mobile_app_links.android_packages')
  ->set('android_packages', [
    'com-example-app_0' => [
      'package_name' => 'com.example.app',
      'sha256_cert_fingerprints' => "AA:BB:CC:...\nDD:EE:FF:...",
    ],
  ])->save();
```
