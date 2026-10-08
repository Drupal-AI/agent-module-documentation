# Configuration

Email TFA is controlled entirely from one settings form. Until you open it and
turn the master switch on, no one is challenged.

## Open the settings form

1. Log in as a user with the **Administer email tfa** permission (an
   administrator by default).
2. Go to **Configuration → People → Email TFA settings**, or navigate directly
   to `/admin/config/people/email-tfa`.

If your `settings.php` has no `hash_salt`, the form shows a warning at the top —
fix that first (see [Installation](../installation/index.md)), because the
one-time code depends on it.

## The master switch

- **Status** — the on/off switch for the whole module. It ships **off**, so
  nobody is challenged until you turn it on. This is your instant site-wide
  enable/disable control.

## Who gets challenged

- **Tracks (enablement mode)** — choose how 2FA is applied:
  - **Globally enabled** — every user is challenged after login, minus the
    exceptions below.
  - **Optionally by users** — only users who tick the **Active** checkbox on
    their own account edit form are challenged. That checkbox only appears when
    the master switch is on and this mode is selected, so it's a good way to roll
    2FA out gradually.
- **Exclude user 1** — when globally enabled, you can exempt the root
  administrator account (user 1) from the flow. Handy during initial setup or
  recovery.
- **Role exclusion type** together with the **roles** list lets you target by
  role:
  - **Disable for** — the selected roles *skip* 2FA; everyone else is challenged.
  - **Force for** — *only* the selected roles are challenged; everyone else
    skips it. Use this to require 2FA just for privileged roles such as editors
    and admins.

## The one-time code

- **Security code length** — how many digits the emailed code has. Any value from
  **4 to 9** (default 4). Longer codes are harder to guess.
- **Timeout** — how long, in seconds, a code stays valid before it expires. The
  form requires at least **60** seconds; the default is **300** (five minutes).

## Flood control

To stop attackers hammering the verification page, the module rate-limits per
user:

- **Flood threshold** — the maximum number of TFA events allowed per user within
  the window (default 5).
- **Flood window** — the length of that window in seconds (default 3600, i.e. one
  hour).

## The email

- **Subject** — the subject line of the one-time-code email (default "One Time
  Password").
- **Body** — the email body. It runs through Drupal's token system, so you can
  personalize it. Two tokens matter most:
  - **`[user:email_tfa]`** — replaced with the actual one-time code. Your body
    must include this so the user receives their code.
  - Standard tokens like **`[user:name]`** and **`[site:name]`** let you address
    the user by name and brand the message with your site name.

## Verification-page text

Every label and message on the verification screen is editable and translatable:
the **security code field label** and its **description**, the **Verify** and
**Resend** button text, and the **success**, **failure**, and **not-authorized**
messages. Adjust these to match your site's tone or language.

## Testing and logging

- **Dev mode** — prints the code on the page instead of emailing it, so you can
  test the flow without checking an inbox. **Never leave this on for a live
  site** — it defeats the whole point of the second factor.
- **Log events** — records Email TFA events (code sent / login) to Drupal's log
  for auditing.

## Excluded routes

An **excluded routes** setting lists route names that should *not* trigger the
2FA interruption (for example, logout). Most sites can leave the defaults alone.

## Save

Click **Save configuration**. Changes take effect immediately — the next covered
login will trigger the email-code challenge.
