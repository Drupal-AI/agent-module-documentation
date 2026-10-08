<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_webform_mailchimp_lists_mergevars_alter

Declared in `webform_mailchimp.api.php`. Invoked while the handler builds the merge vars for
a submission, just before they are sent to Mailchimp — use it to add, remove or rewrite merge
fields based on the submission.

```php
/**
 * Implements hook_webform_mailchimp_lists_mergevars_alter().
 */
function MYMODULE_webform_mailchimp_lists_mergevars_alter(
  array &$mergevars,
  \Drupal\webform\WebformSubmissionInterface $submission,
  \Drupal\webform\Plugin\WebformHandlerInterface $handler
) {
  // $mergevars is the Mailchimp merge-field map (e.g. ['FNAME' => 'Ada', ...]).
  $data = $submission->getData();
  if (!empty($data['company'])) {
    $mergevars['COMPANY'] = $data['company'];
  }
  // Inspect $handler->getConfiguration()['settings'] if behaviour must depend on the list.
}
```

Parameters:
- `&$mergevars` — the merge-field array being sent (mutate it).
- `$submission` — the `WebformSubmissionInterface` being processed.
- `$handler` — the MailChimp `WebformHandlerInterface` instance (read its settings).

This is the module's only hook and its single code extension point; there is no service API
to call directly. The actual Mailchimp API call is made by the Mailchimp module.
