# sfweb2lead_webform — API: alter the payload via the submit event

Before the handler POSTs to Salesforce, it dispatches an event so other modules can add,
change, or remove fields.

- Event class: `Drupal\sfweb2lead_webform\Event\Sfweb2leadWebformEvent`
- Event name constant: `Sfweb2leadWebformEvent::SUBMIT` = `'sfweb2lead_webform.submit'`
- Payload accessors: `getData()` / `setData(array)`, plus `getHandler()` and
  `getSubmission()` (the `WebformSubmissionInterface`).

The event's `data` is the associative array that will be posted (already contains `oid`,
mapped Salesforce fields, and merged custom data).

## Example subscriber
```php
// mymodule.services.yml
services:
  mymodule.sf_lead_subscriber:
    class: Drupal\mymodule\EventSubscriber\SfLeadSubscriber
    tags:
      - { name: event_subscriber }
```
```php
namespace Drupal\mymodule\EventSubscriber;

use Drupal\sfweb2lead_webform\Event\Sfweb2leadWebformEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class SfLeadSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [Sfweb2leadWebformEvent::SUBMIT => 'onSubmit'];
  }

  public function onSubmit(Sfweb2leadWebformEvent $event): void {
    $data = $event->getData();
    // Enrich the Salesforce lead, e.g. add a campaign id or UTM source.
    $data['Campaign_ID'] = '701xxxxxxxxxxxx';
    $data['lead_source'] = $data['lead_source'] ?? 'Website';
    $event->setData($data);
  }
}
```

The returned data becomes the POST body sent to `salesforce_url`.
