# Configure external hreflang (via Metatag)

External Hreflang has **no page of its own**. It adds one field, "External Hreflang", to every
Metatag form. You set it on whichever Metatag level you need.

## Where to set it

| Level | Metatag config | `metatag_defaults` id |
|---|---|---|
| Site-wide default | Configuration → Metatag → **Global** | `global` |
| Front page | Metatag → Front page | `front` |
| All of an entity type | Metatag → e.g. Content | `node` |
| A specific bundle | Metatag → e.g. Content: Article | `node__article` |
| A single entity | The entity's Metatag field (override) | — (stored on the entity) |

## Value syntax

One alternate per line, `langcode|url`:

```
en-US|https://us.example.com
es-ES|https://es.example.com
```

- The part before `|` is the `hreflang` code; after `|` is the absolute external URL.
- Lines that are not exactly `code|url` are rejected by the tag's `validateTag()`.
- Tokens are supported, e.g. `en-us|https://us.example.com[current-page:url:relative:en]` to
  append the current relative path.

Each line becomes `<link rel="alternate" hreflang="<code>" href="<url>">` in the page `<head>`.

## Storage & scripting

Values live under `tags.hreflang_external` of the relevant `metatag_defaults` config entity (or
on the entity's metatag field for overrides).

```bash
# Read the global metatag defaults (look for tags.hreflang_external)
drush cget metatag.metatag_defaults.global
```

```php
// Set the global external hreflang default from code:
$defaults = \Drupal::entityTypeManager()->getStorage('metatag_defaults')->load('global');
$tags = $defaults->get('tags');
$tags['hreflang_external'] = "en-US|https://us.example.com\nes-ES|https://es.example.com";
$defaults->set('tags', $tags)->save();
```

Read it back:

```php
$val = \Drupal::entityTypeManager()->getStorage('metatag_defaults')
  ->load('global')->get('tags')['hreflang_external'] ?? '';
```
