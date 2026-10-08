# Programmatic API — services & entities

## Subscribe / unsubscribe — `simplenews.subscription_manager`

`Drupal\simplenews\Subscription\SubscriptionManagerInterface` (autowirable).

```php
/** @var \Drupal\simplenews\Subscription\SubscriptionManagerInterface $sm */
$sm = \Drupal::service('simplenews.subscription_manager');

$sm->subscribe('user@example.com', 'default', NULL);   // ($mail, $newsletter_id, $langcode|NULL); returns $this
$sm->unsubscribe('user@example.com', 'default');
$sm->isSubscribed('user@example.com', 'default');      // bool — currently ACTIVE on that newsletter
$sm->hasSubscribed('user@example.com', 'default');     // bool — was ever subscribed
$sm->tidy();                                           // remove stale unconfirmed subscriptions (also run by cron)
$sm->getsubscriptionsUrl();
```

`$langcode`: `''` = site default, `NULL` = current page language. For anonymous users a subscribe
normally creates an UNCONFIRMED subscriber and sends a double opt-in mail unless
`subscription.skip_verification` is TRUE.

## The subscriber entity — `simplenews_subscriber`

`Drupal\simplenews\Entity\Subscriber` (content entity). Status constants on
`SubscriberInterface`: `INACTIVE = 0`, `ACTIVE = 1`, `UNCONFIRMED = 2`.

```php
use Drupal\simplenews\Entity\Subscriber;

$subscriber = Subscriber::loadByMail('user@example.com');   // or Subscriber::create(['mail' => ...])
$subscriber->isSubscribed('default');                       // subscription state for a newsletter
$subscriber->subscribe('default');                          // add a subscription on the entity
$subscriber->unsubscribe('default');
$subscriber->getStatus();                                   // INACTIVE|ACTIVE|UNCONFIRMED
$subscriber->save();
```

Subscribe/unsubscribe history is recorded in the `simplenews_subscriber_history` content entity.

## Spool — `simplenews.spool_storage`

`Drupal\simplenews\Spool\SpoolStorageInterface`. Status constants: `STATUS_HOLD=0`,
`STATUS_PENDING=1`, `STATUS_DONE=2`, `STATUS_IN_PROGRESS=3`, `STATUS_SKIPPED=4`, `STATUS_FAILED=5`.

```php
$spool = \Drupal::service('simplenews.spool_storage');
$spool->addIssue($node);                 // enqueue one row per recipient for an issue node
$spool->countMails($conditions);         // pending count
$spool->getMails($limit, $conditions);   // pull a batch to send
$spool->updateMails($msids, $status);    // mark rows done/failed
$spool->clear();                         // purge processed rows per settings
$spool->issueSummary($issue);            // status summary for the admin panel
$handler = $spool->getRecipientHandler($issue);   // resolve the recipient handler for an issue
```

## Mailer — `simplenews.mailer`

`Drupal\simplenews\Mail\MailerInterface`.

```php
$mailer = \Drupal::service('simplenews.mailer');
$mailer->attemptImmediateSend(['entity_id' => $nid], TRUE);   // send now (optionally via batch)
$mailer->sendSpool($limit, $conditions);                      // drain the spool (called from cron)
$mailer->sendTest($issue, ['me@example.com']);                // send a test copy
$mailer->sendSubscribeConfirmation($subscriber);              // resend opt-in mail
$mailer->updateSendStatus();
```

## Other services

- `simplenews.mail_builder` (`MailBuilder`) — builds the message array for a mail/issue.
- `simplenews.mail_cache` (`MailCacheBuild`) — caches rendered content across recipients.
- `plugin.manager.simplenews_recipient_handler` — recipient handler plugin manager
  (see [../plugins/plugins.md](../plugins/plugins.md)).
