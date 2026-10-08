<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API endpoints

Source: `src/Controller/DecoupledInterfaceTranslationsController.php`, `decoupled_interface_translations.routing.yml`,
`decoupled_interface_translations.permissions.yml`.

## Install / enable
```
drush en decoupled_interface_translations -y
```
Enables core `locale` as a dependency. Grant the permission `access interface translation endpoint` to the role(s)
or service account that will call the endpoints. No configuration to set.

## Common contract (both routes)
- `_format: json` (respond/negotiate JSON).
- `_auth: ['basic_auth', 'cookie']` — HTTP Basic auth or an active Drupal session cookie.
- `_user_is_logged_in: 'TRUE'` and `_permission: 'access interface translation endpoint'`.
- All decoupled strings are scoped by the Locale string **context** constant
  `DECOUPLED_STRING_CONTEXT = 'Decoupled Translation'`. Nothing outside that context is read or written.

## GET `/decoupled-interface-translations`
Route `decoupled_interface_translations.get` → `DecoupledInterfaceTranslationsController::get()`.

Iterates `language_manager->getLanguages()` (enabled languages). For each, calls
`locale.storage->getTranslations(['language' => <langcode>, 'translated' => true, 'context' => 'Decoupled Translation'])`
and builds a map. Returns a `JsonResponse` shaped:
```json
{
  "en": { "Source string": "Translation", "...": "..." },
  "fr": { "Source string": "Traduction" }
}
```
Only **translated** strings appear (untranslated source strings are excluded). Read-only; changes nothing.

## POST `/decoupled-interface-translations/add`
Route `decoupled_interface_translations.add` → `DecoupledInterfaceTranslationsController::add(Request $request)`.

Body: a JSON **array** of source-string values, e.g.
```json
["Add to cart", "Checkout", "Continue shopping"]
```
For each value it calls `locale.storage->findString(['source' => <value>, 'context' => 'Decoupled Translation'])`.
If not found, it creates a `Drupal\locale\SourceString`, sets the string and the `Decoupled Translation` context,
and `save()`s it (registering a new source string awaiting translation). Existing strings are left untouched.

Response `JsonResponse`:
```json
{
  "message": "Created 2 new source string(s), and found 1 existing source string(s).",
  "created":  [ { "lid": 42, "source_string": "Checkout" } ],
  "existing": [ { "lid": 17, "source_string": "Add to cart" } ]
}
```
This endpoint only registers **source** strings; it does not set translations. Translators supply the actual
translations through Drupal's normal interface-translation UI (`admin/config/regional/translate`) or `.po` imports;
those translations then surface via the GET endpoint.

## Operating notes
- The POST body must decode to an iterable array of scalars; a non-array/empty body yields no work.
- To expose a string to the GET feed: POST it to `/add`, translate it in Drupal, then it appears under each
  language that has a translation.
- Because access is gated by the permission plus authenticated session/basic-auth, grant the permission only to
  the roles or service accounts that legitimately manage decoupled UI strings.
