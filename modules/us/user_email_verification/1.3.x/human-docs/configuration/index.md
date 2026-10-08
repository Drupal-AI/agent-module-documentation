# Configuration

Configuring this module has **two parts**. First you must change core's account
settings (this is not optional — the module can't do its job otherwise). Then you
tune the module's own settings form.

## Part 1 — Required core setup

Go to **Configuration → People → Account settings**
(`/admin/config/people/accounts`).

Under **Registration and cancellation**:

- Set **Who can register accounts?** to **Visitors**.
- **Uncheck** *Require email verification when a visitor creates an account.* This
  is the key change: if you leave it checked, *core* handles verification and the
  user is **not** logged in immediately — which defeats the whole point of this
  module.

Under **Emails → Welcome (no approval required)**:

- Add the token **`[user:verify-email]`** to the email body so the message includes
  the verification link. (This token comes from the Token module, which is why it's
  recommended.) For the extended‑period email, the matching token is
  `[user:verify-email-extended]`.

Once core is set this way, a newly registered user is logged in right away and
receives the verification link in their welcome email.

## Part 2 — Module settings

Go to **Configuration → People → User Email Verification**
(`/admin/config/people/user-email-verification`). You need the **Manage user email
verification settings** permission to open it. The options:

- **Skip roles** — roles that are exempt from verification entirely (for example
  staff or administrators). Members of these roles are never blocked for being
  unverified.
- **Validate interval** *(default 604800 seconds = 7 days)* — how long a user has to
  verify before the account is blocked. Values are in seconds.
- **Number of reminders** *(default 0)* — how many reminder emails to send during
  the verification window. Leave at 0 for none.
- **Mail subject** *(default `[site:name]: Email verification`)* — the subject line
  of the verification/reminder email.
- **Mail body** — the body of that email; it should contain the
  `[user:verify-email]` token so the link is included.
- **Enable extended period** *(default off)* — turn on a second grace period *after*
  an account is blocked, giving the user another chance with a fresh link that
  re‑activates their account.
- **Extended validate interval** *(default 1209600 seconds = 14 days)* — the length
  of that extended window, in seconds.
- **Extended mail subject** *(default `[site:name]: Account blocked, please verify
  Email address`)* and **Extended mail body** — the subject and body of the
  extended‑period email; the body should contain `[user:verify-email-extended]`.
- **Delete account at end of extended period** *(default on)* — when the extended
  window ends without verification, delete the account (on) or leave it blocked
  (off). The actual delete‑vs‑block behavior also respects core's *"When cancelling
  a user account"* setting.

There are also two auto‑verify toggles that control edge cases: whether accounts
created through paths that would normally auto‑verify are left unverified, and
whether an administrator manually activating a blocked account automatically marks
that user's email verified (on by default — an admin activating the account is
treated as vouching for it).

Save the form. You can also set any value from Drush, for example:

```bash
drush cset user_email_verification.settings validate_interval 86400
```

If you enable **Configuration Translation**, a *Translate user email verification*
tab appears on the settings page so you can translate the email subjects and bodies.

## How enforcement runs

- **At registration**, a verification record is created for the new user.
- **On each cron run**, the module sends any due reminders (up to your configured
  count), blocks accounts whose verification window has passed, and — if the
  extended period is on — processes that window and deletes or keeps‑blocked
  accounts per your setting. The work is chunked through queue workers, so large
  sites process it in batches.
- **Verification** happens when the user clicks the emailed link. Users who need a
  fresh link can request one at `/user/user-email-verification`.

Because everything hinges on cron, make sure cron runs on a sensible schedule.
