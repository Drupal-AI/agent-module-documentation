# The SpamAway anti-spam Webform handler

SpamAway's whole surface is one Webform handler plugin:
`\Drupal\spamaway\Plugin\WebformHandler\AntiSpamHandler` (id **`spamaway_anti_spam_forms`**,
cardinality SINGLE). You attach it to individual webforms; there is no site-wide settings form.

## Add it to a webform

**UI:** open the webform → *Settings → Emails / Handlers* → *Add handler* →
**SpamAway - Anti spam handler** → configure → Save.

**PHP / drush:**

```php
use Drupal\webform\Entity\Webform;
$webform = Webform::load('contact');
$handler = \Drupal::service('plugin.manager.webform.handler')->createInstance('spamaway_anti_spam_forms', [
  'id' => 'spamaway_anti_spam_forms',
  'handler_id' => 'spamaway',
  'label' => 'SpamAway',
  'status' => TRUE,
  'weight' => 0,
  'settings' => [
    'spamaway_anti_spam_field_names' => 'message',
    'spamaway_anti_spam_allowed_ip_count' => 4,
  ],
]);
$webform->addWebformHandler($handler);
$webform->save();
```

## Where the config lives

In the webform config entity: `webform.webform.<id>` →
`handlers.<handler_id>.settings`. Inspect with:

```bash
drush cget webform.webform.contact handlers
```

## Handler settings (defaults)

| Key | Default | Meaning |
|---|---|---|
| `spamaway_anti_spam_field_names` | `message` | Comma-separated field names compared for similarity. Combine fields with `+` (e.g. `name+email`); include `ip` to fold the IP in (e.g. `field_a,field_b+ip`). |
| `spamaway_anti_spam_hash` | `sha256` | PHP hash algorithm used to store field values (only for forms that do **not** store results). |
| `spamaway_anti_spam_threshold_percentage` | `80` | Similarity % (via `similar_text()`) above which two values count as matching. One value, or a comma list per field. Used only when the webform stores its own results. |
| `spamaway_anti_spam_period` | `0` | Time window (seconds) for the similarity check; `0` disables the window (scan recent posts regardless of age). |
| `spamaway_anti_spam_allowed_count` | `5` | Number of similar submissions allowed before rejecting. One value or a comma list per field. |
| `spamaway_anti_spam_ip_period` | `36000` | Time window (seconds) for the IP-frequency check. |
| `spamaway_anti_spam_allowed_ip_count` | `4` | Submissions allowed from one IP within `ip_period` before rejecting. |
| `spamaway_ip_check_enabled` | `TRUE` | Enable/disable the IP-frequency check. |
| `spamaway_anti_spam_logging` | `0` | Log spam-detection events to the `spamaway_spam` logger channel. |
| `spamaway_query_limit` | `200` | Max prior submissions scanned per check (hard-capped at 200). |

## How the two checks work

- **IP check** (`baseIpCheck`): counts rows in `spamaway_webform_submission` for this webform with
  `field_name = 'ip'` and the same IP created within `spamaway_anti_spam_ip_period`; if the count
  exceeds `spamaway_anti_spam_allowed_ip_count`, the submission is flagged as spam.
- **Similarity check**: if the webform **stores results**, it compares the new field values to
  recent stored submissions with `similar_text()` against `threshold_percentage`; if the webform
  does **not** store results, it compares hashes of the chosen fields kept in
  `spamaway_webform_submission`. Exceeding `allowed_count` matches rejects the submission.

On rejection the handler calls `$form_state->setErrorByName('', 'Spam detected…')`, so the
submission fails validation. SpamAway's stored rows for a submission are deleted when that
submission is deleted (`postDelete`).

## Notes for an agent

- This is a **consumer** of Webform's handler plugin type; SpamAway defines no plugin type of its own.
- There is **no `configure` route** and no `config/install` — behaviour comes entirely from the
  per-webform handler settings (or the defaults above).
- Requires `webform`. The handler only runs for webforms it is attached to.
