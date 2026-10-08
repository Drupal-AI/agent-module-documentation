# SMS Blast — permission & the blast form

## Permission

| Permission | Grants |
|---|---|
| `Send SMS Blast` | Access `/sms_blast` and send a bulk message. |

(The machine name really is `Send SMS Blast` — capitalised — from `sms_blast.permissions.yml`.)

## The form

`Drupal\sms_blast\SmsBlastForm` (route `sms_blast.blast`, path `/sms_blast`, menu link "SMS Blast",
form id `sms_blast_form`). Fields: a single **Message** textarea and a **Send** button.

On submit it builds one `Drupal\sms\Message\SmsMessage` with the entered text, then queries all
`sms_phone_number_verification` entities with `status = 1` (verified) and `entity__target_type = 'user'`,
loads the associated users, deduplicates so each user gets one message, and calls
`\Drupal::service('sms.phone_number')->sendMessage($user, $sms_message)` for each. It reports counts
of successes and failures. Delivery itself goes through the parent framework
([send flow](../../../../2.4.x/agent/api/services.md)) — i.e. queued and dispatched by the
configured gateway on cron (or immediately for a skip-queue gateway).

Prerequisite: users must have a phone number field bound and verified via
[phone-number settings](../../../../2.4.x/agent/configure/settings.md) on the `user`/`user` bundle,
otherwise there are no recipients.
