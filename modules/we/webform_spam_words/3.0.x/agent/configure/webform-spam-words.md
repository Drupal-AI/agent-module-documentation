# Configure Webform Spam Words

Two separate mechanisms — do not confuse them. The global settings form only stores
*defaults for itself*; nothing in the module reads that config to protect a webform
automatically. Actual blocking happens only through a handler attached to a specific webform.

## 1. Global settings form (defaults only — not auto-applied)

- Route: `webform_spam_words.config`, path `/admin/config/webform/webform-spam-words`.
- Access requirement: `_permission: 'administer webform+edit webform spam words'` — the `+`
  is Drupal's route-permission **OR** syntax, so a user needs **either** `administer webform`
  **or** the module's own `edit webform spam words` permission (not both).
- Config object: `webform_spam_words.settings` (no config schema; `provides_config_schema:
  false`). Keys, with shipped defaults from `config/install/webform_spam_words.settings.yml`:
  - `spam_words` (sequence of strings) — default: `SEO`, `Digital Marketing`, `Click Here`,
    `unsubscribe`, `FREE`, `trial`.
  - `spam_text_message` (string) — default: `Unable to submit form. Please contact the site
    administrator, if the problem persists.`
  - `spam_field_name` (string, comma-separated field names) — default: `message`.
- Read/write directly: `drush config:get webform_spam_words.settings` /
  `drush config:set webform_spam_words.settings <key> <value>`. In the form UI, `spam_words`
  is edited as one word per line (a textarea) and stored as a YAML sequence on save.
- **This config is inert.** Grep confirms the `.module` file implements only
  `hook_help()` — there is no `hook_form_alter()`/`hook_webform_submission_form_alter()`
  reading `webform_spam_words.settings`. Changing it here has zero effect on any webform
  until you separately configure the handler below (which does not read this config either
  — its defaults are hardcoded in PHP, not derived from this settings object).

## 2. The handler that actually blocks submissions

- Plugin id `webform_spam_words`, class
  `Drupal\webform_spam_words\Plugin\WebformHandler\BlockWordsWebformHandler`, a Webform
  `WebformHandler` plugin (cardinality: single instance per webform).
- Default handler configuration (`defaultConfiguration()`, hardcoded — independent of the
  global settings above): `spam_words: 'SEO'`, `spam_text_message: 'Unable to submit form.
  Please contact the site administrator, if the problem persists.'`, `spam_field_name:
  'message'`.
- **No configuration form UI**: the class does not override `buildConfigurationForm()`, so
  the base `WebformHandlerBase` returns an empty form — the "Add handler" screen at
  `/admin/structure/webform/manage/{webform}/handlers` offers no fields to edit. To use
  non-default values you must set the handler's `settings` programmatically or via
  exported config YAML (see below); there is no click-path to customize it in the admin UI.
- Validation logic (`validateForm()`): splits `spam_field_name` on commas; for each named
  form field, lowercases + HTML-escapes the submitted value, collapses whitespace, and
  checks it for any `spam_words` entry as a case-insensitive substring. On a match it calls
  `$form_state->setErrorByName($field, $spam_text_message)`, which blocks the submission.
  Empty or array-valued fields are skipped.

### `spam_words` MUST be an array, not a string — a real footgun

`validateSpam()` does `foreach ($spam_words as $word)`. The shipped
`defaultConfiguration()` sets `spam_words => 'SEO'` — a **scalar string**. `foreach` over a
string in PHP 8 does not error; it emits `Warning: foreach() argument must be of type
array|object, string given` and the loop body simply never runs (verified against this
site's PHP). **A handler left at its untouched default therefore blocks nothing at all.**
Always set `spam_words` to a PHP array / YAML sequence of one or more words, e.g. `['casino']`
or `['casino', 'viagra']`, never a bare string, or the handler is silently inert.

### Attach the handler to a webform

Add a `handlers.<handler_id>` block to the webform's config (matches the shape of any other
Webform handler, e.g. the built-in `email` handler):

```yaml
handlers:
  block_spam_words:
    id: webform_spam_words
    label: 'Block spam words'
    handler_id: block_spam_words
    status: true
    weight: 0
    conditions: {  }
    settings:
      spam_words:
        - casino
      spam_text_message: 'Blocked: spam detected'
      spam_field_name: email
```

Or programmatically, e.g. in `drush php:eval`:

```php
use Drupal\webform\Entity\Webform;
$webform = Webform::load('my_webform');
$manager = \Drupal::service('plugin.manager.webform.handler');
$handler = $manager->createInstance('webform_spam_words');
$handler->setConfiguration([
  'handler_id' => 'block_spam_words',
  'label' => 'Block spam words',
  'settings' => [
    'spam_words' => ['casino'],
    'spam_text_message' => 'Blocked: spam detected',
    'spam_field_name' => 'email',
  ],
]);
$webform->addWebformHandler($handler);
```
