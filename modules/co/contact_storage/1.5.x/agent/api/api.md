# Programmatic API — querying & creating stored messages

Contact Storage defines **no services of its own** (it only registers two event
subscribers). Its "API" is the fact that core's `contact_message` is now a fully stored,
queryable content entity. Use the standard entity/query APIs.

## Query stored messages

```php
// All message IDs for one contact form, newest first.
$ids = \Drupal::entityQuery('contact_message')
  ->accessCheck(TRUE)
  ->condition('contact_form', 'feedback')   // the bundle = contact form id
  ->sort('created', 'DESC')
  ->execute();

/** @var \Drupal\contact\MessageInterface[] $messages */
$messages = \Drupal::entityTypeManager()
  ->getStorage('contact_message')
  ->loadMultiple($ids);

foreach ($messages as $message) {
  $message->id();                 // integer id (base field added by contact_storage)
  $message->getSenderName();      // core Message methods
  $message->getSenderMail();
  $message->getSubject();
  $message->getMessage();
  $message->get('created')->value;
  $message->get('uid')->target_id;
  $message->get('ip_address')->value;
}
```

Base fields added to `contact_message` by `hook_entity_base_field_info`: `id` (int, read-only),
`created`, `uid`, `ip_address`. `subject` is the entity label; the bundle is the contact form
machine name.

## Create / edit / delete in code

```php
$storage = \Drupal::entityTypeManager()->getStorage('contact_message');

$message = $storage->create([
  'contact_form' => 'feedback',
  'name'    => 'Jane',
  'mail'    => 'jane@example.com',
  'subject' => 'Hello',
  'message' => 'Body text',
]);
$message->save();          // persisted (core alone would discard it)

$message->set('subject', 'Edited')->save();
$message->delete();
```

## Count a user's submissions

`contact_storage_maximum_submissions_user(ContactFormInterface $form)` (in
`contact_storage.module`) returns how many times the current user (or, for anonymous, the
current IP + uid) has submitted a given form — this backs the `maximum_submissions_user`
limit.

## Notes

- `send_html` in `contact_storage.settings` swaps the contact-form message view builder;
  changing it clears entity-type definition caches.
- The `contact_storage_options_email` field type appends option-mapped recipients to outgoing
  mail via `hook_mail_alter()`.
- There is no `contact_storage.*` service to call; work through
  `entity_type.manager` / `\Drupal::entityQuery()`.
