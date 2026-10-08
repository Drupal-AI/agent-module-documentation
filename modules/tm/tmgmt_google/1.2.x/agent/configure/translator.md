<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Google translator

The module contributes the TMGMT translator plugin **`google`**. You configure it by creating a
`tmgmt_translator` provider entity that uses that plugin.

## The plugin

`GoogleTranslator` — `@TranslatorPlugin id = "google"`, label "Google",
`ui = GoogleTranslatorUi`, implements `ContinuousTranslatorInterface`. No config UI of its own beyond
the provider form; configuration is the translator entity's `settings`.

## Settings (schema `tmgmt.translator.settings.google`)

| Setting | Type | Meaning |
|---|---|---|
| `api_key` | string | **Required.** Google Cloud Translation API key. `checkAvailable()` returns "yes" only when set. |
| `auto_accept` | boolean | Automatically accept translations returned for the job. |
| `url` | string | Hidden endpoint override, used only by automated tests — leave empty in production. |

## Create / configure a translator

UI: *Configuration → Regional and language → Translation providers* (route
`entity.tmgmt_translator.collection`, `/admin/tmgmt/translators`) → add a provider, choose
**Google**, paste the API key. On save the UI validates the key by calling
`getSupportedRemoteLanguages()` (a live Google request); an invalid key raises
"The 'Google API key' is not correct."

Scriptable (config entity `tmgmt.translator.<name>`):

```php
$t = \Drupal\tmgmt\Entity\Translator::create([
  'name' => 'google', 'label' => 'Google', 'plugin' => 'google',
  'settings' => ['api_key' => 'YOUR_KEY', 'auto_accept' => TRUE],
]);
$t->save();
// read back: $t->getPluginId(); $t->getSetting('api_key'); $t->getSetting('auto_accept');
```

```bash
drush cget tmgmt.translator.google
```

## Availability

`checkAvailable($translator)` → `AvailableResult::yes()` if `api_key` is set, otherwise
`AvailableResult::no(...)` linking to the translator's edit form. `getSupportedRemoteLanguages()` and
`getSupportedTargetLanguages()` return empty until a key is configured, so language mapping only
appears once the key is valid.
