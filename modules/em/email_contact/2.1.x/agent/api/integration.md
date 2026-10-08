<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email Contact — route, mail, event, helper

## Route

```
email_contact.form  email-contact/{entity_type}/{entity}/{field_name}/{view_mode}
```

- Controller `ContactController::content` builds the `ContactForm`; `getTitle` provides the
  page/modal title (the formatter's `title` setting, else "`<label> - Email Contact`").
- Access is a custom check `ContactController::accessCheck`: the current user must be able to
  **view the entity** and **view the field**. There is no dedicated permission.
- `view_mode` defaults to `full`; `ViewModeTrait::getViewMode` falls back to `default` when the
  requested view display doesn't exist.
- The `email_contact_link` formatter builds links to this route; when its `modal` setting is on,
  the link gets `use-ajax` + `core/drupal.dialog.ajax` and the controller returns an
  `AjaxResponse` with an `OpenModalDialogCommand`.

## Sending mail (`hook_mail`, key `contact`)

`email_contact_mail()` composes the message under key `contact`:
- subject = the form's subject;
- body = the (token-replaced) `default_message` then the user's message;
- recipient(s) = the field's address(es); reply-to = the submitter's address.

`ContactForm::sendMessage()` calls `plugin.manager.mail->mail('email_contact', 'contact', $to,
…, $reply_to)`. The form validates the sender address and rejects newlines in the subject
(header-injection guard), logging attempts to the `email_contact` channel.

## Helper: read a field's addresses

```php
$emails = email_contact_get_emails_from_field($entity_type, $id, $field_name);
// returns non-empty array of valid-looking addresses, or throws NotFoundHttpException
// if the entity/field is missing, the field isn't type 'email', or no address is present.
```

## Altering the modal AJAX command (`AjaxEmailContactCommandEvent`)

Both the modal-open (in `ContactController::content`) and the modal-close (in
`ContactForm::ajaxSubmit`) dispatch `Drupal\email_contact\Event\AjaxEmailContactCommandEvent`
before adding the command to the response. Subscribe to it to replace/augment the Ajax command
or add attachments:

```php
use Drupal\email_contact\Event\AjaxEmailContactCommandEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyContactSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [AjaxEmailContactCommandEvent::class => 'onCommand'];
  }
  public function onCommand(AjaxEmailContactCommandEvent $event): void {
    $context = $event->getContext();       // ['instance' => 'email_contact.modal.open'|'...close', ...]
    // $event->setCommand($myCommand);     // swap the Ajax command
    // $event->addAttachments([...]);      // add libraries/settings
  }
}
```

The event's `context['instance']` is `email_contact.modal.open` or `email_contact.modal.close`,
so a subscriber can distinguish the two dispatch points.
