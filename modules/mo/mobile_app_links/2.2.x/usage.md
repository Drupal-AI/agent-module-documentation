Mobile App Link serves the `.well-known` domain-association files that iOS Universal Links and Android App Links require, generating `apple-app-site-association`, `assetlinks.json`, and the Apple developer/merchant domain-association files from admin-entered configuration.

---

The module exposes four public (`_access: TRUE`) routes under `/.well-known/` — `assetlinks.json` (Android App Links / Digital Asset Links), `apple-app-site-association` (iOS Universal Links + App Clips), `apple-developer-domain-association.txt`, and `apple-developer-merchantid-domain-association.txt` — served by `WellKnownController` as cacheable JSON/plain-text responses derived from module config. An admin (permission `administer mobile app links`) fills in the data through four config forms at `admin/config/mobile-app-links/*`: the iOS form manages a repeatable list of app links (appID, paths, appIDs, app clips, defaults, and an optional uploaded JSON components file), the Android form manages a repeatable list of packages (package name + newline-separated SHA-256 cert fingerprints), and two simple textarea forms hold the Apple developer-ID and merchant-ID association strings. A path processor (`MobileAppLinksPathProcessor`) sets `_disable_route_normalizer` and strips the language prefix for any `.well-known` path so the files resolve at the exact well-known URL regardless of Drupal's language/URL handling. These files must be publicly reachable — that is required by Apple and Google for the association to work — and their contents are entirely operator-defined. Config schema is provided; there is no Drush command. Works on Drupal 8 through 11.

---

- Serve `/.well-known/apple-app-site-association` so an iOS app can claim your domain for Universal Links.
- Serve `/.well-known/assetlinks.json` so an Android app can verify App Links (Digital Asset Links).
- Publish `apple-developer-merchantid-domain-association.txt` for Apple Pay domain verification.
- Publish `apple-developer-domain-association.txt` for Apple developer domain association.
- Register multiple Android packages, each with its own SHA-256 signing-certificate fingerprints.
- Register multiple iOS app IDs with distinct URL path patterns per app.
- Configure which URL paths deep-link into an iOS app (allow/deny path lists).
- Declare App Clips for an iOS app via the app clips field.
- Attach an uploaded JSON "components" file to an iOS app link entry for advanced path matching.
- Set per-app defaults (e.g. `caseSensitive: false`) for iOS link resolution.
- Manage all app-association files from Drupal config instead of hand-placing static files.
- Keep the well-known files in version-controllable config (config export/import).
- Ensure the association files resolve at the exact `.well-known` URL despite multilingual URL prefixes.
- Let the files be cached (cacheable responses tied to the config's cache tags) for performance.
- Return a 404 for the Apple developer-ID file when no value is configured.
- Support both a staging and production domain by editing config per environment.
- Add or remove app entries over time as apps are published or retired.
- Verify domain ownership for Apple Pay on the web.
- Provide the Digital Asset Links needed for Android Smart Lock / autofill associations.
- Update signing fingerprints after an Android app re-signing without redeploying code.
