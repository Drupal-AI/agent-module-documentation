# Hooks invited by Mailchimp Transactional

Three integration points. The first two are documented in `mailchimp_transactional.api.php`; the
third is a `drupal_alter()` invoked in the mail plugin.

## `hook_mailchimp_transactional_mail_alter(array &$params, array $message)`

Invoked as `\Drupal::moduleHandler()->alter('mailchimp_transactional_mail', $params, $message)`
just before send/queue. `$params['message']` is the fully built Mailchimp Transactional message
array (html, text, subject, from_email/from_name, to, headers, tracking flags, tags, attachments,
metadata, optional subaccount). Alter it to add merge/global variables, change tracking, inject
headers, set a subaccount conditionally, etc. `$message` is the original Drupal message array
(read-only context).

## `hook_mailchimp_transactional_valid_attachment_types_alter(array &$types)`

Add allowed attachment MIME types (matched by `strpos`, so prefixes like `application/` work).
Default allowed set: `image/`, `text/`, `application/pdf`, `application/x-zip`.

```php
function mymodule_mailchimp_transactional_valid_attachment_types_alter(&$types) {
  $types[] = 'application/msword';
  $types[] = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
}
```

## `hook_mailchimp_transactional_mailsend_result(array $result, array $message)`

Respond to the outcome of a send. `$result` includes the per-recipient status (e.g. `sent`,
`queued`, `rejected`, `invalid`) and email; `$message` is the sent message array. Typical use:
react to rejected/bounced recipients.

```php
function mymodule_mailchimp_transactional_mailsend_result(array $result, array $message) {
  if ($result['status'] == 'rejected') {
    // e.g. flag or clean up the recipient account.
  }
}
```

There is no `.api.php`-declared alter for templates in this base module; the
`mailchimp_transactional_template` submodule adds
`hook_mailchimp_transactional_template_map_alter()` (see its docs).
