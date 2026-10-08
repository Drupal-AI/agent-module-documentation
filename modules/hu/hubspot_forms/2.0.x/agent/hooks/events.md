# Events — `CollectFormsEvent`

`Drupal\hubspot_forms\Event\CollectFormsEvent` (extends
`Drupal\Component\EventDispatcher\Event`). Dispatched at the end of
`HubspotForms::fetchHubspotForms()`, after the configured account's forms are fetched but before
they are returned/cached. Use it to add forms from **additional HubSpot accounts** (or otherwise
adjust the list) so they appear in every embed's form select.

## API

```php
$event->getForms(): array           // current forms, keyed PORTAL_ID::FORM_ID => label
$event->addForm($key, $label): void // add one; $key must be "PORTAL_ID::FORM_ID"
$event->setForms(array $forms): void // replace the whole list
```

There is no event-name constant; subscribe to the class name.

## Example subscriber

```php
use Drupal\hubspot_forms\Event\CollectFormsEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class ExtraHubspotFormsSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [CollectFormsEvent::class => 'onCollect'];
  }

  public function onCollect(CollectFormsEvent $event): void {
    // Portal 9999999, form abc-123, shown in the select list as "Second account: Newsletter".
    $event->addForm('9999999::abc-123', 'Second account: Newsletter');
  }
}
```

Register it as a service tagged `event_subscriber`. The added key's `PORTAL_ID::FORM_ID` is what
the embed splits to call `hbspt.forms.create({ portalId, formId })`, so both parts must be valid
for that account.
