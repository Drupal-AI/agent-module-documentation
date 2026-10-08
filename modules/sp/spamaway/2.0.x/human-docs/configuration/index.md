# Configuration

SpamAway has no site-wide settings page. Instead you configure it **per webform**,
on the handler you add to each form. That means you can protect a high-value form
aggressively while leaving a low-risk form alone.

## Add the handler to a webform

1. Go to **Structure → Webforms** and open the webform you want to protect.
2. Choose **Settings → Emails / Handlers**.
3. Click **Add handler**, pick **SpamAway - Anti spam handler**, and click **Add
   handler**.
4. Adjust the settings (below), then **Save**.

Repeat for each webform you want guarded — the handler only runs on forms it's
attached to. The settings are stored inside the webform's own configuration, under
its `handlers` section.

## The similarity check

This check rejects a submission that looks too much like recent submissions on the
same form.

- **Field names** (`spamaway_anti_spam_field_names`, default `message`) — a
  comma-separated list of the form's field names to compare. You can combine fields
  with a `+` so both must repeat together (for example `name+email`), and you can
  include the special token `ip` to fold the submitter's IP into a comparison (for
  example `field_a,field_b+ip`).
- **Threshold percentage** (`spamaway_anti_spam_threshold_percentage`, default
  `80`) — how similar two values must be (measured with PHP's `similar_text()`) to
  count as a match. Give one value for all fields, or a comma-separated list to set a
  different threshold per field. This applies when the webform stores its own
  results.
- **Allowed count** (`spamaway_anti_spam_allowed_count`, default `5`) — how many
  similar submissions are allowed before further ones are treated as spam. Again,
  one value or a per-field comma list.
- **Period** (`spamaway_anti_spam_period`, default `0`) — the time window in seconds
  for the similarity check. `0` disables the window, so recent posts are scanned
  regardless of age.

If the webform does **not** store its results, SpamAway can't compare full values,
so it stores hashes of the chosen fields in its own table and compares those. Two
settings govern that:

- **Hash algorithm** (`spamaway_anti_spam_hash`, default `sha256`) — the PHP hash
  used to store field values for comparison.
- **Query limit** (`spamaway_query_limit`, default `200`, hard-capped at 200) — the
  maximum number of prior submissions scanned on each check.

## The IP-frequency check

This check rate-limits how often a single IP address can submit the form.

- **Enable IP check** (`spamaway_ip_check_enabled`, default on) — turn the
  IP-frequency check on or off independently of the similarity check.
- **IP period** (`spamaway_anti_spam_ip_period`, default `36000` seconds) — the time
  window over which submissions from one IP are counted.
- **Allowed IP count** (`spamaway_anti_spam_allowed_ip_count`, default `4`) — how
  many submissions one IP may make within that window before further ones are
  rejected.

## Logging

- **Logging** (`spamaway_anti_spam_logging`, default off) — when enabled, SpamAway
  records spam-detection events (and bypasses) to a dedicated `spamaway_spam` logger
  channel. Turn this on while you're tuning thresholds, then review the log to see
  what's being caught.

## What a rejected submission looks like

When a submission trips either check, the handler adds a **"Spam detected…"** error
to the form, so the submission fails validation and is not saved. SpamAway also
cleans up its own stored data for a submission automatically when that submission is
deleted.

## Letting trusted users through (bypass)

There are two ways to skip all SpamAway checks:

1. **Permission** — grant the **SpamAway bypass spam detection**
   (`spamaway bypass spam detection`) permission to a trusted role, and its members
   skip every check on every webform.

   ```bash
   drush role:perm:add editor 'spamaway bypass spam detection'
   ```

2. **Global settings flag** — add `$settings['spamaway_bypass_anti_spam'] = TRUE;`
   to `settings.php` to disable spam checking entirely. This is handy for a dev or
   staging environment where you don't want to touch each webform.

When logging is on, a bypass is recorded on the `spamaway_spam` channel too.
