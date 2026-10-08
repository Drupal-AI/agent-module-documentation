# Configuration

All four forms live under **Configuration → *(Mobile App Links)***
(`/admin/config/mobile-app-links/*`) and require the **Administer mobile app links**
permission. Each form feeds one of the public `/.well-known/` files:

| Form | Fills in the file served at |
|---|---|
| **iOS** (`/ios`) | `/.well-known/apple-app-site-association` |
| **Android** (`/android`) | `/.well-known/assetlinks.json` |
| **Apple developer ID** (`/apple-dev-id-assoc`) | `/.well-known/apple-developer-domain-association.txt` |
| **Apple merchant ID** (`/apple-dev-merchant-id-assoc`) | `/.well-known/apple-developer-merchantid-domain-association.txt` |

You only need to fill in the forms for the associations you actually use. Responses
are cacheable and update whenever you save the corresponding config.

## iOS form — Universal Links & App Clips

This form manages a repeatable list of **App Configurations** (use **Add More** /
**Delete** to manage entries). For each app entry:

- **App ID** — the Apple team-qualified app ID (e.g. `ABCDE12345.com.example.app`).
  Entries left with an empty App ID are dropped.
- **Paths** — the URL path patterns that should deep-link into the app, one per line.
- **App Clips** — the App Clip app ID string, if you use App Clips.
- **App IDs** — additional app IDs (a multivalue list) for the same entry.
- **Defaults** — one `key : value` line per default, e.g. `caseSensitive : false`, to
  control how iOS resolves the links.
- **Upload File** — an optional `.json` "components" file for advanced path matching;
  on save it is made permanent and its contents are merged into the entry's
  `components`.

The module assembles the standard `applinks.details[]` structure (plus an `appclips`
block) and serves it as JSON.

## Android form — App Links / Digital Asset Links

This form manages a repeatable list of **Android App Configurations**. For each
package:

- **Package Name** — the app's package name (e.g. `com.example.app`).
- **SHA256 Certificate Fingerprints** — the app's signing-certificate SHA-256
  fingerprints, one per line. You can update these after re-signing an app without
  redeploying any code.

The module serves one Digital Asset Links object per package, granting
`delegate_permission/common.handle_all_urls` to that Android app.

## Apple developer / merchant ID forms

Each of these is a single **textarea** holding the association string Apple gives you:

- **Apple developer ID** — the developer domain-association string. If you leave it
  empty, the file returns a **404** (so an unconfigured association simply looks
  absent).
- **Apple merchant ID** — the Apple Pay merchant domain-association string, used to
  verify your domain for Apple Pay on the web.

Both are served as plain text exactly as you enter them.

## Multilingual sites

You do not need to do anything special: the module includes a path processor that
disables route normalization and strips any language prefix for `.well-known`
requests, so the files always resolve at the literal
`/.well-known/apple-app-site-association` (etc.) URL even on sites that use language
URL prefixes — which is exactly what iOS and Android expect.

## Verifying

After saving, open each file directly in a browser (for example
`https://your-site/.well-known/apple-app-site-association`) to confirm it returns the
content you entered. Then have your app teams re-run their platform association checks.
