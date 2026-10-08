# Configuration

Spambot works with sensible defaults the moment it is enabled, but its settings
form is where you tune how aggressively it checks visitors and whether it also
polices your existing accounts.

## Open the settings form

1. Log in as a user with the core **Administer site configuration** permission —
   an administrator by default.
2. Go to **Configuration → System → Spambot**, or navigate directly to
   `/admin/config/system/spambot`.

## Registration protection and thresholds

- **Protect the user registration form** — on by default. This adds the Stop
  Forum Spam check to new registrations.
- **Email criteria** — block a registration if the email has been reported to
  Stop Forum Spam at least this many times. Default **1** (blocks on any report).
  Set to **0** to skip the email check.
- **Username criteria** — same idea for the username. Default **0**, meaning the
  username check is **off** by default, because usernames produce more false
  positives (many people share common handles). Raise it above 0 to enable it.
- **IP criteria** — same for the visitor's IP address. Default **20**, so a single
  stray report will not block a whole shared IP. Set to **0** to skip the IP check.

Setting all three to 0 turns off every remote lookup — Spambot then makes no
request at all.

## Delay and logging

- **Blacklisted delay** — deliberately pauses a blocked attempt for a few seconds
  to slow down repeat spambots. Default is a short delay; set to none if you
  prefer instant rejection.
- **Log blocked registrations** — on by default. Blocked attempts are written to
  Drupal's log (and trigger a hook other modules can react to).

## Blocked messages

Three separate messages are shown to a blocked registrant depending on what
tripped the block — **email**, **username**, or **IP**. Each defaults to a generic
"Your email address or username or IP address is blacklisted." You can customize
each one, and use tokens like `@email`, `@username`, and `@ip` to include the
offending value.

## Whitelists

Three textareas — one for **emails**, one for **usernames**, one for **IPs** —
list trusted values (one per line) that are never checked or blocked. Use these to
exempt staff or known-good addresses.

## Scanning existing accounts (cron)

Spambot can scan accounts you already have, a batch at a time during cron:

- **Accounts to check per cron run** — how many existing accounts to check each
  time cron runs. Default **0**, which means cron scanning is **off**. Set a
  modest number (for example 50) to stay within Stop Forum Spam's daily query
  limit.
- **Also scan already-blocked accounts** — off by default; leave it off to skip
  accounts you have already blocked.
- **Action on a match** — what to do when a scanned account is found to be a
  spammer: **None** (just log, the default), **Block**, or **Delete**.
- **Continue scanning after this user id** — the scan cursor. The scan works
  through accounts by ascending user id; set this to 0 to restart the scan from the
  beginning.

Note that users with the *protected from spambot scans* permission are never
blocked or deleted by these scans.

## Reporting API key

- **Stop Forum Spam API key** — needed only if you want to *report* spammers back
  to the service from the per-user Spam tab. Get a free key at
  stopforumspam.com. Checking visitors does not require it. The key is stored in
  configuration, so treat it as a credential.

## Caching and connection

- **Enable caching** — on by default. Stop Forum Spam responses are cached to cut
  down API traffic.
- **Cache lifetimes** — you can set separate lifetimes for "is a spammer" hits and
  "not a spammer" misses. The defaults keep results permanently until the cache is
  cleared.
- **Use HTTPS** — on by default for API calls. Disable it only if your server
  cannot make HTTPS requests to the service (for example a very old server lacking
  SNI support).

## Save

Click **Save configuration**. Your registration protection changes take effect
immediately; cron-scan changes apply on the next cron run.

## The per-user Spam tab

Separately from this form, each account has a **Spam** tab (visible to users with
**Administer users**) at `/user/{user}/spambot`. From there you can check that one
account against Stop Forum Spam live, report its nodes and comments to the service
(needs the API key), unpublish or delete all of its content, and block or delete
the account.

## Exempting trusted users

Grant the **Protected from spambot scans** permission (on **People →
Permissions**) to roles you trust, such as staff. Holders of it bypass every
Spambot check — the registration validator is skipped for them and cron scans take
no action against their accounts. Grant it sparingly, since it disables spam
filtering entirely for those users.
