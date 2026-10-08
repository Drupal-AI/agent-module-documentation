# Configuration

gText has one true setting — the **Google Cloud Translate API key** — plus two
permissions and the translation UI. Everything else (the stored translations
themselves) lives in Drupal's core Locale storage.

## The Google API key (optional)

The API key decides *how* machine translation happens:

- **Key set** → gText uses the official Google Cloud Translate client for
  translations.
- **Key empty / not set** → gText falls back to a free, unofficial
  translate.google.com endpoint, which is limited to **1000 characters per request**
  (longer strings raise an error asking you to add a key).

There is no shipped default, so until you set a key the config object does not exist
and the free fallback is used.

### Set the key

1. Go to the settings form at **`/admin/config/gtext/settings`** (requires the
   **Administer site configuration** permission).
2. Enter your key in the **Google API key** field.
3. **Save.** On save the form validates the key by making a live call to Google; an
   invalid key is rejected with a form error.

The value is stored as `google_api_key` in the `gtext.settings` config object.

> **Treat the key as a secret.** Because it is stored in configuration, be careful
> not to commit a real key into version-controlled config exports. Per this project's
> conventions, keep secrets in an environment variable (for example via
> `ddev dotenv set .ddev/.env …`) and set the config value from that at deploy time
> rather than hard-coding a live key into exported configuration.

### Scripting the key (optional)

```bash
drush cget gtext.settings google_api_key

# set a key
drush php:eval '\Drupal::configFactory()->getEditable("gtext.settings")
  ->set("google_api_key", "AIza...yourkey")->save();'

# clear the key (revert to the free fallback)
drush php:eval '\Drupal::configFactory()->getEditable("gtext.settings")
  ->set("google_api_key", "")->save();'
```

## Permissions

Grant these at **People → Permissions** (`/admin/people/permissions`):

- **Access gtext translate strings** — access the `/admin/config/texts`
  string-translation UI. This is declared as a *restricted* permission, so grant it
  only to trusted translator/administrator roles.
- **Access gtext translate** — see the inline "translate" buttons that gText adds to
  core's config-translation and entity-translation forms. These buttons call gText's
  translation endpoint via JavaScript to pre-fill a suggestion.

## The translation UI

Under **Translating texts** (`/admin/config/texts`, gated by *Access gtext translate
strings*):

- The main page lists translatable source strings, grouped by their locale context.
- Selecting a string opens its per-language translation editor
  (`/admin/config/texts/{lid}`).
- You can reload a single string's translation
  (`/admin/config/texts/{lid}/reload`) and export translations for a language and
  group (`/admin/config/texts/{langcode}/{group}/export`).

Saving a translation refreshes Drupal's JavaScript and locale caches and dispatches
core's `locale.save_translation` event, so the rest of the site picks up the change.

## Using it in code and templates

- In Twig: `gtext()` returns the translation service, and `gtext('some_context')`
  returns a wrapper for that locale context, so templates can emit context-aware
  translatable strings.
- In PHP: use the `gtext` service (`\Drupal::service('gtext')`) the same way.

Machine translation is only a convenience for filling in suggestions — the
authoritative translations are stored in core Locale.
