# Configuration

Everything Login Security does is driven by a single settings form. This page
walks through it field by field. A general rule to remember: for the count‑based
thresholds, a value of **0 disables that particular protection** — so you switch
on only the defenses you want.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → People → Login Security**, or navigate directly to
   `/admin/config/people/login_security`.

All values live in the `login_security.settings` config object, so they export and
deploy with `drush config:export` (or can be set with
`drush cset login_security.settings <key> <value>`).

## Thresholds

These decide when an account or IP gets blocked. Counts are measured within the
tracking window below.

- **Tracking window** (`track_time`, default **60** minutes) — the sliding window,
  in minutes, that failed attempts are kept and counted. Older records expire and
  stop counting (they're purged on cron). Shorten it to forgive attackers faster,
  lengthen it to count failures over a longer period.
- **Attempts per user account** (`user_wrong_count`, default **0**) — how many
  failed attempts are allowed for a **single account** before that account is
  blocked, regardless of which host is attacking. Blocking sets the account's
  status to disabled.
- **Attempts per host — soft** (`host_wrong_count`, default **0**) — how many
  failures are allowed from **one IP** before that IP can no longer submit the
  login form. The IP can still browse the site anonymously; it just can't attempt
  to log in.
- **Attempts per host — hard** (`host_wrong_count_hard`, default **0**) — how many
  failures are allowed from one IP before it's **banned outright** via the
  Ban/AdvBan module. (Requires Ban or AdvBan to be enabled.)
- **Attack‑detection threshold** (`activity_threshold`, default **0**) — the total
  number of failed attempts **site‑wide** before Login Security logs an "ongoing
  attack" warning and, if you've set notification emails, alerts admins. The alert
  resets automatically once activity falls back below a third of the threshold.

> **On public sites** where locking accounts could be abused (an attacker
> deliberately locking out real users), consider leaning on the **host** limits
> rather than the per‑user limit.

## Behavior and notifications

- **Hide core login errors** (`disable_core_login_error`, default off) — hides
  core's "Unrecognized username or password" messages to prevent username
  enumeration. Note this only hides the messages; it does **not** turn off core's
  flood control.
- **Notify user of remaining attempts** (`notice_attempts_available`, default off)
  — shows the user how many attempts remain before lockout.
- **Show last login timestamp** (`last_login_timestamp`, default off) — on a
  successful login, shows the user their previous login time.
- **Show last access timestamp** (`last_access_timestamp`, default off) — on a
  successful login, shows the user their previous site‑access time.
- **Blocked‑account notification emails** (`user_blocked_notification_emails`) — a
  comma‑separated list of addresses to email when an account is blocked. Leave
  blank for none.
- **Attack notification emails** (`login_activity_notification_emails`) — a
  comma‑separated list of addresses to email when the attack‑detection threshold is
  crossed. Leave blank for none.

## Messages and email templates

You can customize all the user‑facing messages and notification emails — the
remaining‑attempts notice, the soft‑ban and hard‑ban messages, the
account‑blocked message, and the subject/body of both the blocked‑account and
attack‑detection emails. These accept tokens such as `@username`, `@ip`, `@site`,
`@uid`, `@email`, `@date`, and various count tokens (for example
`@user_current_count`, `@ip_current_count`, `@activity_threshold`,
`@tracking_time`) so each message can include the specific details of the event.

## Clearing tracked data

The form includes a **Clear event tracking information** button that empties the
failed‑attempt tracking table on demand. (Expired rows are also purged
automatically on cron.)

## Important operational notes

- **Hard IP banning requires Ban or AdvBan.** Without one of them enabled, hard
  bans can't be applied and the status report will warn you.
- **Blocks are not automatically lifted.** Re‑enable a blocked account at
  **People** (`/admin/people`); remove a banned IP at
  `/admin/config/people/ban`.
- **This runs alongside core flood control.** Login Security layers its per‑account
  and per‑IP thresholds on top of Drupal's built‑in login flood protection rather
  than replacing it.

Click **Save configuration** when you're done.
