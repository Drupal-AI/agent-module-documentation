<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Handler plugin: `send_multiple_emails`

File: `src/Plugin/WebformHandler/SendMultipleEmailWebformHandler.php`
Class: `SendMultipleEmailWebformHandler extends \Drupal\webform\Plugin\WebformHandler\EmailWebformHandler`

## Install / enable

`composer require drupal/webform_send_multiple_emails` then `drush en webform_send_multiple_emails`.
Requires the Webform module (`drupal/webform:^6.0`). Nothing else is installed — no routes,
permissions, services, config schema or settings form. To use it: on a webform go to
Settings → Emails / Handlers → Add handler → **Send Multiple Emails**, then configure it exactly
like the core "Email" handler.

## Plugin annotation

`id = "send_multiple_emails"`, `label`/`category = "Notification"`, `cardinality = CARDINALITY_UNLIMITED`
(add several per webform), `results = RESULTS_PROCESSED`, `submission = SUBMISSION_OPTIONAL`.

## Configuration

Inherits every setting of the core email handler (To/From/CC/BCC/reply-to, subject, body, `html`,
`states`, element mappings). Stored in the webform's own handler config; this module ships no
config object. `defaultConfiguration()` adds four keys on top of the parent:

| Key | Type | Meaning |
|---|---|---|
| `prefix_text` | string | Body-prefix template, may contain the literal `[prefix_multiple_field]` placeholder |
| `prefix_multiple_field` | string | Field/token resolving to a `:`-separated list of names aligned with the `,`-separated To addresses |
| `mail_to_default_enabled` | bool | Redirect every message to one fixed address (for testing) |
| `mail_to_default_address` | string | The fixed test address |

`buildConfigurationForm()` calls the parent form, then:
- Hides CC and BCC: `$form['to']['cc_mail']['cc_mail']['#access'] = FALSE;` and the bcc equivalent —
  because individual sending would otherwise re-send the whole message to each CC/BCC recipient.
- Adds a "Message prefix" details group (`prefix_text`, `prefix_multiple_field`).
- Adds a "Send email to default" details group (`mail_to_default_enabled` checkbox +
  `mail_to_default_address` email field).

`submitConfigurationForm()` copies those four values back into `$this->configuration`.
`validateConfigurationForm()` errors if `mail_to_default_enabled` is TRUE but the default address
is empty, then calls the parent validator.
`getSummary()` renders the configured To (split on `,`) and From for the Emails/Handlers list.

## Send behaviour

`postSave(WebformSubmissionInterface $webform_submission, $update)`:
1. Computes `$state` (COMPLETED when results are disabled, else the submission's state).
2. Proceeds only when `$this->configuration['states']` contains `$state` (same gate as the core handler).
3. `$message = $this->getMessage($webform_submission);` — core method that resolves subject/body/To
   with token replacement and element mapping.
4. `$to_mail_list = explode(',', $message['to_mail']);` — the recipient list is whatever the To
   setting resolved to, split on commas.
5. If `prefix_multiple_field` is set, it token-replaces the original `to_mail` config and the
   names field and builds `$to_names_lookup[$mail] = $name` by zipping the two lists by index.
6. Loops each address: sets `$message['to_mail'] = $to_mail`, optionally prepends the
   salutation (`str_replace('[prefix_multiple_field]', $name, $prefix_text)`, wrapped in `<p>` when
   `html`), then `$this->sendMessage($webform_submission, $message);`. When
   `mail_to_default_enabled` is TRUE the recipient is overridden to `mail_to_default_address`.
   The body is restored to the original after each send.

`postDelete()`: when `WebformSubmissionInterface::STATE_DELETED` is in `states`, resolves the
message and loops the To list the same way (honouring `mail_to_default_enabled`), sending one
message per address.

## Notes

- The recipient list is driven by the handler's To setting; pointing it at a submission element or
  token that yields comma-separated addresses is what produces per-submitter recipients.
- Actual delivery uses core `sendMessage()` / the Webform mail manager; this module does not touch
  transport, TLS or headers.
- No config/schema is shipped, so the four added keys rely on the parent handler's schema; they are
  plain strings/booleans persisted in the webform's handler configuration.
