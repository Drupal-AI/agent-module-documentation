# Programmatic API — generate, preview & send an email

## The handler service — `easy_email.handler`
`Drupal\easy_email\Service\EmailHandler` (interface `EmailHandlerInterface`). Main entry point.

```php
/** @var \Drupal\easy_email\Service\EmailHandlerInterface $handler */
$handler = \Drupal::service('easy_email.handler');

// 1. Create an email (content entity) of a given template (bundle).
$email = $handler->createEmail([
  'type' => 'my_template',          // easy_email_type machine id (bundle)
  // any base/custom field values, e.g. an entity reference used by tokens:
  // 'field_order' => $order->id(),
]);

// 2. (optional) Override fields on the entity before sending — see setters below.
$email->setRecipientAddresses(['user@example.com']);
$email->setSubject('Hello [easy_email:field_order:entity:order_number]');

// 3. Send. Returns EasyEmailInterface[] (more than one when unsafe/per-user tokens
//    force separate rendered copies per recipient). Check ->isSent() on each.
$results = $handler->sendEmail($email, $params = [], $send_duplicate = FALSE, $save_email_entity = TRUE);

// De-dupe guard (uses the template 'key'):
if (!$handler->duplicateExists($email)) { $handler->sendEmail($email); }

// Preview without sending (returns a render array of the built message):
$build = $handler->preview($email, $params = []);
```

`sendEmail()` runs the email through the evaluator services (tokens → recipients → attachments),
dispatches presend/sent events, then hands off to Drupal's `plugin.manager.mail`. A real HTML
mailer (Symfony Mailer / Symfony Mailer Lite) must be enabled.

## The `easy_email` content entity
`Drupal\easy_email\Entity\EasyEmail` (revisionable, bundle = `easy_email_type`). Rich fluent API:

- Recipients: `getRecipients()/setRecipientIds()/addRecipient($uid)`, and address variants
  `getRecipientAddresses()/setRecipientAddresses()/addRecipientAddress($email)`.
- CC / BCC: same pattern — `setCCIds()/addCCAddress()`, `setBCCIds()/addBCCAddress()`, plus
  `getCombinedCCAddresses()`, `getCombinedBCCAddresses()`, `getCombinedRecipientAddresses()`.
- Content: `setSubject()`, `setFromName()`, `setFromAddress()`, `setReplyToAddress()`,
  `setHtmlBody($text, $format)`, `setPlainBody($text)`, `setInboxPreview($text)`.
- Attachments: `setAttachmentIds($fids)`/`addAttachment($fid)` (managed files),
  `setAttachmentPaths($paths)`/`addAttachmentPath($path)` (token/relative paths),
  `getEvaluatedAttachments()` (resolved list after evaluation).
- State: `isSent()`, `getSentTime()`, `getKey()/setKey()`, `getCreator()/setCreator()`.

## Evaluator services (called by the handler; usable directly)
- `easy_email.token_evaluator` (`EmailTokenEvaluator`) — `evaluateTokens($email)`,
  `replaceTokens($email, $values, $unique)`, `containsUnsafeTokens($email)`,
  `replaceUnsafeTokens($text, $recipient)`.
- `easy_email.user_evaluator` (`EmailUserEvaluator`) — resolves user recipients.
- `easy_email.attachment_evaluator` (`EmailAttachmentEvaluator`) —
  `evaluateAttachments($email, $save_attachment_to)`.
- `easy_email.purger` (`EasyEmailPurger`) — purges old logged emails (used by cron & Drush).

## Extension points
- **Action plugin** `easy_email_send` (`SendEasyEmail`, `type = "easy_email"`) — send emails as a
  bulk/Views action.
- **Events** `Drupal\easy_email\Event\EasyEmailEvents` (dispatched with `EasyEmailEvent`):
  `EMAIL_CREATE`, `EMAIL_PRESAVE`, `EMAIL_INSERT`, `EMAIL_UPDATE`, `EMAIL_PREDELETE`, `EMAIL_DELETE`,
  `EMAIL_PRETOKENEVAL`, `EMAIL_TOKENEVAL`, `EMAIL_PREUSEREVAL`, `EMAIL_USEREVAL`,
  `EMAIL_PREATTACHMENTEVAL`, `EMAIL_ATTACHMENTEVAL`, `EMAIL_PRESEND`, `EMAIL_SENT`.
- Because `easy_email` is a content entity, standard entity hooks
  (`hook_entity_presave`, `hook_entity_update`, …) also fire.
