# Events

The handler dispatches two Symfony events (Drupal `\Drupal\Component\EventDispatcher\Event`)
after a delivery attempt. Subscribe from an `EventSubscriber` service in your own module.

| Event name constant | Value | When |
|---|---|---|
| `WebformGoogleSheetsSuccessEvent::EVENT_NAME` | `webform_googlesheets.success` | After a submission row is appended successfully. |
| `WebformGoogleSheetsErrorEvent::EVENT_NAME` | `webform_googlesheets.error` | When a Google API call throws, or the target sheet gid is missing. |

## Success event — `Drupal\webform_googlesheets\Event\WebformGoogleSheetsSuccessEvent`

- `getSubmission(): WebformSubmissionInterface` — the appended submission.
- `getResponse(): ?BatchUpdateSpreadsheetResponse` — the Sheets API response, or `NULL` when
  older custom code created the event without one.

## Error event — `Drupal\webform_googlesheets\Event\WebformGoogleSheetsErrorEvent`

- `getSubmission(): WebformSubmissionInterface` — the submission that failed.
- `getErrorMessage(): string` — the caught exception message (or the "sheet ID does not exist"
  message).

## Subscriber example

```php
use Drupal\webform_googlesheets\Event\WebformGoogleSheetsSuccessEvent;
use Drupal\webform_googlesheets\Event\WebformGoogleSheetsErrorEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MySubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [
      WebformGoogleSheetsSuccessEvent::EVENT_NAME => 'onSuccess',
      WebformGoogleSheetsErrorEvent::EVENT_NAME => 'onError',
    ];
  }

  public function onSuccess(WebformGoogleSheetsSuccessEvent $event): void {
    $submission = $event->getSubmission();
    $response = $event->getResponse(); // BatchUpdateSpreadsheetResponse|null
  }

  public function onError(WebformGoogleSheetsErrorEvent $event): void {
    $message = $event->getErrorMessage();
  }
}
```

Register the class as a service tagged `event_subscriber`. Both success and error paths also log
to the `webform_submission` logger channel, independently of any subscriber.
