<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alt Text Generator — configuration

## Install & enable

```
composer require drupal/alt_text_generator
drush en alt_text_generator -y
```

Depends on core **`image`** only (`alt_text_generator.info.yml`). No submodules, no extra contrib.
`configure: alt_text_generator.settings` puts a link on the Extend/module list.

## Settings form

Route **`alt_text_generator.settings`** → `/admin/config/content/alt-text-generator`, permission
**`administer site configuration`**. Class `src/Form/AltTextGeneratorSettingsForm.php`
(`ConfigFormBase`, form id `alt_text_generator_settings`), editable config
`alt_text_generator.settings`.

Fields:

- **`api_key`** — required textfield. The vendor (free-tier) key from
  `https://alttextgeneratorai.com/dashboard`. Stored in the `alt_text_generator.settings` config object.
- **`default_language`** — required `select`, default `english`. Options come from the class
  constant `LANGUAGES` (34 entries: english, spanish, french, german, italian, portuguese, dutch,
  russian, chinese, japanese, korean, arabic, swedish, norwegian, danish, finnish, polish, turkish,
  hindi, bengali, urdu, thai, vietnamese, indonesian, malay, filipino, greek, hebrew, hungarian,
  czech, romanian, bulgarian, ukrainian, croatian, serbian). This value is the `language` sent to
  the generate API.

**Credit check (on form build):** when a key is set, `buildForm()` POSTs `{apiKey}` to
`https://alttextgeneratorai.com/api/verify` (plain `new GuzzleHttp\Client()`, default TLS
verification). On HTTP 200 it renders a status message `Credits remaining: @credits` from the
response's `freeRewritesLeft`; on a Guzzle exception it renders an "Invalid API key" error and logs
to the `alt_text_generator` channel.

`submitForm()` saves `api_key` and `default_language` back to `alt_text_generator.settings`.

## Config object & schema

Config name **`alt_text_generator.settings`**
(`config/schema/alt_text_generator.schema.yml`, `type: config_object`):

| key | type | notes |
|---|---|---|
| `api_key` | string | vendor API key |
| `default_language` | string | one of the `LANGUAGES` keys, e.g. `english` |

**Install-default mismatch:** `config/install/alt_text_generator.settings.yml` ships
`api_key: ''` and **`language: 'en'`** — the key is `language`, not the schema/form key
`default_language`. The form reads `default_language` (falling back to `'english'`), so the
shipped `language: 'en'` value is effectively ignored until an admin saves the form.

## Example (config export)

```yaml
# alt_text_generator.settings.yml
api_key: 'YOUR_VENDOR_KEY'
default_language: english
```

Storing the key in a `.yml` export means it lands in version control — prefer setting it only via
the admin form (or overriding `$config['alt_text_generator.settings']['api_key']` from
`settings.php` via an environment variable) rather than committing the value.
