# Configuration

Birthday Wish Mail needs to know which field holds each user's birthday and what
message to send, and it relies on cron to send at the right time.

## 1. Make sure users have a birthday field

The module reads a birthday date from your user accounts, so your users need a
birthday field populated for the greetings to fire. Add or confirm this field under
**Configuration → People → Account settings → Manage fields**
(`/admin/config/people/accounts/fields`).

## 2. Choose the field and write the email template

In the module's settings, select the birthday field it should read and compose the
email template — the subject and body of the greeting. Because the module depends on
the **Token** module, you can insert tokens (such as the user's name) so each message
is personalised.

## 3. Make sure cron runs reliably

Greetings are sent when Drupal's cron runs, so the module can only send on a given day
if cron actually runs that day. Check your cron setup under **Configuration → System →
Cron** (`/admin/config/system/cron`) and, on production, prefer a real system cron (or
`drush cron` on a schedule) over Drupal's automated cron so a day is never missed.

## Privacy notes

- The module uses users' **birthdays (personal data)** and their **email addresses**.
  Handle this data in line with your privacy policy, and only email users who expect
  it.
- The module has no access-control role of its own; controlling who receives mail is a
  matter of which users have a birthday field populated and your own policy.
