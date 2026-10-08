<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The MailChimp webform handler

Plugin `\Drupal\webform_mailchimp\Plugin\WebformHandler\WebformMailChimpHandler` —
`@WebformHandler(id = "mailchimp", label = "MailChimp", category = "MailChimp")`,
`cardinality = CARDINALITY_UNLIMITED` (many per webform), `results = RESULTS_PROCESSED`.

Add it: *Webform → Settings → Handlers → Add handler → MailChimp*, or programmatically with
the webform handler plugin manager.

## Settings (schema `webform.handler.mailchimp`, `defaultConfiguration()`)

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `list` | string | `NULL` | Target Mailchimp **audience/list id** (from the Mailchimp module). |
| `email` | string | `''` | Which webform element supplies the subscriber email. |
| `double_optin` | boolean | `TRUE` | Require Mailchimp confirmation email before subscribing. |
| `mergevars` | text (YAML) | `''` | Map of Mailchimp merge tag → webform value (e.g. `FNAME: '[webform_submission:values:first_name]'`). |
| `interest_groups` | sequence | `[]` | Category id → array of interest group ids to add the subscriber to. |
| `control` | string | `''` | A webform element that gates subscription (only subscribe when it's set/true). |

The available lists, merge fields and interest groups come from the **Mailchimp module** (which
stores the API key); configure that first. Field mapping works by matching your webform
element `key`s to Mailchimp merge-field "Field tags" (case-insensitive).

## Programmatic add (config shape)

```php
$webform = \Drupal\webform\Entity\Webform::load('newsletter');
$handler = \Drupal::service('plugin.manager.webform.handler')->createInstance('mailchimp', [
  'id' => 'mailchimp', 'handler_id' => 'mc', 'label' => 'MailChimp',
  'status' => TRUE, 'weight' => 0,
  'settings' => [
    'list' => 'abc123audience', 'email' => 'email',
    'double_optin' => TRUE, 'mergevars' => "FNAME: '[webform_submission:values:name]'",
    'interest_groups' => [], 'control' => '',
  ],
]);
$webform->addWebformHandler($handler);
$webform->save();
```

Read back: iterate `$webform->getHandlers()` and check `getPluginId() === 'mailchimp'` and
`getConfiguration()['settings']`. Merge vars can be adjusted at send time via
[../hooks/mergevars.md](../hooks/mergevars.md).
