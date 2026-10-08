# SMS Blast (`sms_blast`) — agent index

Submodule of SMS Framework. One form to send a single message to all users with a verified
phone number. No config, no schema, no Drush.

- Route `sms_blast.blast` → **`/sms_blast`**, permission **`Send SMS Blast`**.
- `SmsBlastForm` (a `FormBase`): textarea → on submit queries
  `sms_phone_number_verification` where `status = 1` and `entity__target_type = 'user'`,
  de-duplicates by user, and calls `\Drupal::service('sms.phone_number')->sendMessage($user,
  $sms)` for each; shows sent/failed counts.
- Depends on `sms` + `user`. No solution docs needed (single trivial form).
- Parent: [../../../../2.4.x/agent/start.md](../../../../2.4.x/agent/start.md)
