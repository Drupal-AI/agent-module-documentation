<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# tmgmt_deepl hooks & event

From `tmgmt_deepl.api.php`.

## `hook_tmgmt_deepl_checkout_settings_form_alter(array &$form, JobInterface $job)`

Add/modify fields on the DeepL job **checkout settings** form.

```php
function mymodule_tmgmt_deepl_checkout_settings_form_alter(array &$form, \Drupal\tmgmt\JobInterface $job): void {
  $form['additional_info'] = ['#markup' => t('Extra info in the DeepL checkout form')];
}
```

## `hook_tmgmt_deepl_has_checkout_settings_alter(bool &$has_checkout_settings, JobInterface $job)`

Force whether a DeepL job shows checkout settings.

```php
function mymodule_tmgmt_deepl_has_checkout_settings_alter(bool &$has, \Drupal\tmgmt\JobInterface $job): void {
  $has = TRUE;
}
```

## `hook_tmgmt_deepl_query_string_alter(Job $job, array &$query_data, array $query_params)`

Alter the DeepL translation query **before** the request is sent (add/override DeepL query
parameters based on job settings).

```php
function mymodule_tmgmt_deepl_query_string_alter(\Drupal\tmgmt\Entity\Job $job, array &$query_data, array $query_params): void {
  if ($job->getSetting('custom_setting') == 1) {
    $query_data['my_custom_var'] = '1';
  }
}
```

## Event: `DeeplReceivedDataEvent`

Subscribe to `DeeplReceivedDataEvent::ALTER_RECEIVED_DATA` to post-process translated content
returned by DeepL before it is saved to the job. The event exposes `getJob()`, `getData()`,
`setData()`:

```php
namespace Drupal\my_module\EventSubscriber;

use Drupal\tmgmt_deepl\Event\DeeplReceivedDataEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class DeeplReceivedDataSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [DeeplReceivedDataEvent::ALTER_RECEIVED_DATA => 'onAlterReceivedData'];
  }
  public function onAlterReceivedData(DeeplReceivedDataEvent $event): void {
    if ($event->getJob()->getRemoteTargetLanguage() !== 'EN-US') { return; }
    $data = $event->getData();
    // ... mutate $data['#text'] ...
    $event->setData($data);
  }
}
```

Register it as a normal `event_subscriber`-tagged service.
