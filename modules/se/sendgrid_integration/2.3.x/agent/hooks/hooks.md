# Hooks — sendgrid_integration.api.php

All are invoked from `SendGridMail::doMail()` while building/sending the message.

## `hook_sendgrid_integration_categories_alter($message, $categories)`

Alter the SendGrid categories array (defaults: `[site name, module, message id]`). Return the new
array. Invoked with `invokeAll`, so return a non-empty array to replace the categories.

```php
function my_module_sendgrid_integration_categories_alter($message, $categories) {
  $categories[] = 'from_' . $message['from'];
  $categories[] = $message['language'];
  return $categories;
}
```

## `hook_sendgrid_integration_unique_args_alter($unique_args, $message)`

Documented in `sendgrid_integration.api.php` for modifying the unique-arguments/metadata array
before send; return the modified array.

## `hook_sendgrid_integration_sent($to, $unique_args, $response)`

React after a message is sent — logging, notifications, bookkeeping. `$response` is the SendGrid API
response. (In `doMail()` this is invoked via `invokeAll` with the recipient and response.)

```php
function my_module_sendgrid_integration_sent($to, $unique_args, $response) {
  \Drupal::logger('my_module')->notice('SendGrid delivered to @to', ['@to' => $to]);
}
```

## Alter hooks fired via `ModuleHandler::alter()`

- `hook_sendgrid_integration_alter(array &$sendgrid_params, array $message)` — alter the fully built
  SendGrid message object before it is sent (`$sendgrid_params['message']` is the `SendGrid\Mail\Mail`).
- `hook_sendgrid_integration_valid_attachment_types_alter(array &$valid_types)` — add allowed
  attachment MIME-type prefixes (defaults: `image/`, `text/`, `application/pdf`, `application/x-zip`,
  `application/xml`).
