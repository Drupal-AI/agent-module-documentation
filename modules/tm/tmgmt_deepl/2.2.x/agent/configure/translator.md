<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create & configure a DeepL translator provider

DeepL is used as a **TMGMT translator provider** — a `tmgmt_translator` config entity whose
`plugin` is `deepl_free` or `deepl_pro`.

## Add the provider (UI)

1. Go to *Translation → Providers* / TMGMT translators
   (`/admin/tmgmt/translators`, route `entity.tmgmt_translator.collection` — this is the module's
   `configure` route). Add a translator.
2. Choose plugin **DeepL API Free** (`deepl_free`) or **DeepL API Pro** (`deepl_pro`).
3. Enter your DeepL **auth key** and adjust the DeepL options.
4. Save; the form validates the key against DeepL (needs network + a valid key).

## `tmgmt.translator.<name>` settings (schema `tmgmt_deepl_settings`)

| Key | Meaning / values |
|---|---|
| `auth_key` | DeepL API authentication key. |
| `url` / `url_usage` | Translate + usage API endpoints (free vs pro differ). |
| `test_url` / `test_url_usage` | Endpoints used for the settings-form key test. |
| `formality` | `default` / `more` / `less` / `prefer_more` / `prefer_less`. |
| `split_sentences` | `0` (none) / `1` (interpunction + newlines, default) / `nonewlines`. |
| `tag_handling` | `0` (off) / `xml` / `html`. |
| `non_splitting_tags` / `splitting_tags` / `ignore_tags` | Comma-separated XML tag lists. |
| `preserve_formatting` | int (preserve formatting). |
| `outline_detection` | int (automatic outline detection). |
| `auto_accept` | bool — auto-accept returned translations (job completes without review). |

## Create the provider in code (scriptable — no API call to just save it)

```php
use Drupal\tmgmt\Entity\Translator;
Translator::create([
  'name' => 'deepl',
  'label' => 'DeepL',
  'plugin' => 'deepl_free',            // or 'deepl_pro'
  'settings' => [
    'auth_key' => getenv('DEEPL_AUTH_KEY'),
    'formality' => 'prefer_more',
    'auto_accept' => TRUE,
    'split_sentences' => '1',
    'tag_handling' => 'html',
  ],
  'remote_languages_mappings' => [],
])->save();
```

```bash
drush cget tmgmt.translator.deepl plugin
drush cget tmgmt.translator.deepl settings
```

## Store the DeepL auth key securely

Don't commit the key. Put it in an env var / Key entity:

```bash
ddev dotenv set .ddev/.env --deepl-auth-key=<value>   # then ddev restart
```

Then set `settings.auth_key` from `getenv('DEEPL_AUTH_KEY')` during deployment (or use a Key
entity where supported). Saving the translator config does **not** call DeepL; only translating a
job (or the form's key test) does.
