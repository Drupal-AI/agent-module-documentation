<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# tmgmt_deepl alter hooks

From `tmgmt_deepl.api.php`. All are `\Drupal::moduleHandler()->alter()` calls made by
`DeeplTranslatorUi` and `DeeplTranslateOptions`. (The `DeeplReceivedDataEvent` and
`hook_tmgmt_deepl_query_string_alter` of 2.2.x no longer exist — use
`hook_tmgmt_deepl_translate_options_alter` instead.)

## `hook_tmgmt_deepl_checkout_settings_form_alter(array &$form, JobInterface $job)`

Add/modify fields on the DeepL job **checkout settings** form
(`DeeplTranslatorUi::checkoutSettingsForm()`).

```php
function mymodule_tmgmt_deepl_checkout_settings_form_alter(array &$form, \Drupal\tmgmt\JobInterface $job): void {
  $form['additional_info'] = ['#markup' => t('Extra info in the DeepL checkout form')];
}
```

## `hook_tmgmt_deepl_build_configuration_form_alter(array &$form, FormStateInterface $form_state)`

Add/modify fields on the DeepL **provider settings** form
(`DeeplTranslatorUi::buildConfigurationForm()`).

```php
function mymodule_tmgmt_deepl_build_configuration_form_alter(array &$form, \Drupal\Core\Form\FormStateInterface $form_state): void {
  $form['additional_info'] = ['#markup' => t('Extra info in the provider form')];
}
```

## `hook_tmgmt_deepl_has_checkout_settings_alter(bool &$has_checkout_settings, JobInterface $job)`

Force whether a DeepL job shows checkout settings (`DeeplTranslator::hasCheckoutSettings()`; also
TRUE automatically when `enable_context` is set).

```php
function mymodule_tmgmt_deepl_has_checkout_settings_alter(bool &$has, \Drupal\tmgmt\JobInterface $job): void {
  $has = TRUE;
}
```

## `hook_tmgmt_deepl_translate_options_alter(Job $job, array &$options)`

Alter the DeepL request options **before** a text or document request is sent
(`DeeplTranslateOptions::alterAndFilter()`). Keys are `\DeepL\TranslateTextOptions` /
`TranslateDocumentOptions` constants. **After** this hook, any key that is not a valid option for
the corresponding DeepL request is dropped (allow-list), so add unmodeled/beta parameters through
`TranslateTextOptions::EXTRA_BODY_PARAMETERS`.

```php
use DeepL\TranslateTextOptions;

function mymodule_tmgmt_deepl_translate_options_alter(\Drupal\tmgmt\Entity\Job $job, array &$options): void {
  if ($job->getSetting('custom_setting') == 1) {
    $options[TranslateTextOptions::FORMALITY] = 'prefer_more';
    // Reach a parameter the module does not model:
    $options[TranslateTextOptions::EXTRA_BODY_PARAMETERS]['some_beta_flag'] = 1;
  }
}
```

The `tmgmt_deepl_glossary` submodule implements the checkout, has-checkout and translate-options
hooks to inject the selected/matching glossary id (`$options['glossary']`).
