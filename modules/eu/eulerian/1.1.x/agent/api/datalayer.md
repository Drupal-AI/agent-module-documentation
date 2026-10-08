<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The datalayer, page attachments & event tracking

## How the tag is injected

`Hook\EulerianHooks::pageAttachments()` (attribute `#[Hook('page_attachments')]`, legacy wrapper in
`eulerian.module`) runs on every request and:

1. Merges `eulerian.settings` cache tags into the response.
2. **Returns early** (no tag) if `track.domain` is empty, or `EulerianVisibility` says the page is
   excluded, or the response status matches `status_codes_disabled`.
3. Builds `$datalayer` (see below).
4. Attaches library `eulerian/init` (and `eulerian/colorbox` when `colorbox` + `track.colorbox`),
   then sets:

```php
$attachments['#attached']['drupalSettings']['eulerian'] = [
  'datalayer'    => $datalayer,
  'clean_string' => $config->get('clean_string'),
  'domain'       => $config->get('track.domain'),
];
```

drupalSettings is JSON-encoded by core with the HTML-safe flags, so values placed in the datalayer
are serialized safely into the inline settings script.

## What goes into `$datalayer`

- `error => 1` and status captured when the request carries an exception (error page).
- Site search: `isearchengine`, `isearchkey` (`'keys'`), `isearchdata` (the `keys` query),
  `isearchresults` (pager total) — only on `search.view*` routes with `track.site_search`.
- `uid => generateUserIdentifierHash(uid)` when `track.userid` and the user is authenticated.
  The hash is `Crypt::hmacBase64($uid, privateKey . Settings::getHashSalt())` — stable, non-PII.
- `path` = the untranslated node's canonical URL when `translation_set` is on and the current node
  is a translation (needs `content_translation`).
- Each configured custom parameter as `name => value` after token replacement (empties skipped).

The Commerce submodules add to this same `datalayer` array via `hook_page_attachments_alter`
(cart/checkout/product) — see their trees.

## Init JS (`js/init.js`, library `eulerian/init`)

Depends on `core/drupalSettings`, `eulerian/events`, `eulerian/tools`. It bootstraps the standard
Eulerian tag from `drupalSettings.eulerian.domain` (returns early if the domain is undefined),
appends the async Eulerian script, then calls
`EA_push(EA_prepare2Push(drupalSettings.eulerian.datalayer))`.

## Tools JS (`js/tools.js`, library `eulerian/tools`)

Defines the globals used everywhere:

- `EA_cleanString(text)` — when `drupalSettings.eulerian.clean_string` is on, strips tags/entities
  (via a detached element's `textContent`), removes accents (`NFD` normalize), replaces whitespace
  with `_`, lowercases and trims; otherwise returns the text unchanged.
- `EA_getAttributes(element)` — reads all `data-eulerian-*` attributes off an element (prefix from
  `EA_ATTR_PREFIX`), cleaning each value.
- `EA_prepare2Push(data)` — flattens the datalayer object into Eulerian's iterating key/value array,
  expanding the "super properties": `products` (→ `prdref`/`prdamount`/`prdquantity` triples),
  `prdrefs` (→ repeated `prdref`), `isearchkeys` (→ `isearchkey`/`isearchdata` pairs).
- `EA_prepare2PushEvent(data)` — same idea for events, plus `action` handling: mandatory
  `actionname`, ordered declaring attrs (`actionmode`/`actionlabel`/`actionhref`), `actionparams`
  (name/value/finite) and nested `actions`. Throws (via `Drupal.t`) if mandatory action attributes
  are partially supplied.

The PHP-side `EulerianHelper::cleanString()` mirrors the JS cleaner (transliterate → `[^\w]+`→`_`
→ collapse `_` → lowercase/trim) for server-cleaned values.

## Event / link tracking (`js/events.js`, library `eulerian/events`)

Binds `keyup`/`mousedown`/`touchstart` on `document.body` and, on the closest `a`/`area`/`button`,
reads its `data-eulerian-*` attributes. Nothing is sent unless `data-eulerian-event` is present and
its value is a known type — `action`, `button`, `download`, `event`, `link` (or the `product*`
variants). Event name defaults to the element text, overridable with `data-eulerian-event-name`.

```html
<a href="/contact" data-eulerian-event="link" data-eulerian-event-name="Contact link">Contact us</a>
```

produces `EA_push('link', ['Contact link'])`. Product events additionally use
`data-eulerian-product-ref`. Custom `data-eulerian-*` attributes become a `globalarg` push around
the event. By design the module collects **no** clicks unless the author opts in with these
attributes (or Eulerian's own `__EA_*__` classes).

## Colorbox JS (`js/colorbox.js`, library `eulerian/colorbox`)

On `cbox_complete`, clones the datalayer, sets `path` to the opened `href`, drops any `error` key,
and pushes it — so modal content is tracked as its own pageview. Depends on `colorbox/colorbox`.
