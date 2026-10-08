<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Obfuscate

## Settings form

- Route `obfuscate.obfuscate_config_form` → path `/admin/config/obfuscate`
  (*Configuration → Content authoring → Email obfuscation configuration*).
- Permission: `administer obfuscate` (title "Administer Obfuscate").
- Form `ObfuscateConfigForm` (a `ConfigFormBase`) has one radio, **System wide obfuscation
  method**, saved to `obfuscate.settings:obfuscate.method`. On submit it calls
  `drupal_flush_all_caches()` (method change affects rendered/cached output).

## Config

`config/install/obfuscate.settings.yml` ships:

```yaml
obfuscate:
  method: "html_entity"    # or "rot_13"
```

Schema `obfuscate.schema.yml` defines `obfuscate.settings` → `obfuscate.method` (string). Set it
without the UI via:

```bash
drush config:set obfuscate.settings obfuscate.method rot_13 -y
```

## Who uses this system-wide method

- The text **filter** (`obfuscate_mail`).
- The **Twig** extension (`|obfuscateMail`, `obfuscate()`).
- The `obfuscate_mail` **service**.
- The Email **field formatter** uses it as its *default*, but can be overridden per field instance
  (see [../plugins/formatter-and-filter.md](../plugins/formatter-and-filter.md)).

## Methods

| Value | Class | Behaviour |
|---|---|---|
| `html_entity` (default) | `ObfuscateMailHtmlEntity` | Pure PHP. Randomly HTML-entity-encodes ~25% of chars (always `.`/`@`/`:`), URL-encodes the `mailto:` href, adds `rel="nofollow"`. No JS. |
| `rot_13` | `ObfuscateMailROT13` | Emits a `js-enabled` span (ROT13 text) + a `js-disabled` span (reversed text, CSS fallback). `js/rot13.js` (library `obfuscate/rot13`) un-rotates and rebuilds a real mailto link client-side. |

Not encryption — a determined scraper can still recover addresses; this only defeats naive
harvesters.
