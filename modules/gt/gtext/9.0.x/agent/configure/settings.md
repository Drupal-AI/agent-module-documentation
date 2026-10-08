# Configure gText

## The one config value

Config object **`gtext.settings`**, single key **`google_api_key`** (schema type `string`).
There is **no `config/install`**, so on a fresh site the object does not exist until you set a
key (reads return NULL/empty → free fallback translation is used).

- **Set** → gText uses the official Google Cloud Translate client (`google/cloud-translate`) with
  this key for machine translation.
- **Empty / unset** → gText uses a free, unofficial translate.google.com endpoint, limited to
  1000 characters per request.

## Set / read the key

Settings form routes (both use the same `SettingsForm`, field label "Google API key"):
- `gtext.translate.settings_page` → `/admin/config/gtext/settings`
- `gtext.translate.settings` → `/api/gtext/settings`
Both require **`administer site configuration`**. On save the form validates the key by calling
Google's `localizedLanguages()`; an invalid key raises a form error.

Scriptable:

```bash
drush cget gtext.settings google_api_key

# set a key
drush php:eval '\Drupal::configFactory()->getEditable("gtext.settings")
  ->set("google_api_key", "AIza...yourkey")->save();'

# clear the key (revert to free fallback)
drush php:eval '\Drupal::configFactory()->getEditable("gtext.settings")
  ->set("google_api_key", "")->save();'
# or remove the object entirely:
drush php:eval '\Drupal::configFactory()->getEditable("gtext.settings")->delete();'
```

## The translation UI (configure route)

- `gtext.translate` → **`/admin/config/texts`** — lists translatable source strings (grouped by
  locale context from `locales_source`) and links to per-string translation.
- `gtext.translate.string` → `/admin/config/texts/{lid}` — translate one string.
- `gtext.translate.update` → `/admin/config/texts/{lid}/reload` — reload a string.
- `gtext.translate.export` → `/admin/config/texts/{langcode}/{group}/export`.
All require **`access gtext translate strings`**.

## Permissions

- **`access gtext translate strings`** — access the `/admin/config/texts` string-translation UI
  (declared `restrict access: TRUE`).
- **`access gtext translate`** — see the inline "translate" buttons gText adds to core
  config-translation and entity-translation forms (JS calls `gtext.translate.google`).

## Note (settings.php side effect)

`hook_install` appends `twig_sandbox_whitelisted_methods` (adding `t` and `plural`) to
`settings.php` so the `gtext()` Twig helper works in sandboxed templates.
