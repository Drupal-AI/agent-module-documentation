# Configuration

Simple password policy is driven by a single settings form that writes to one
configuration object (`simple_password_policy.settings`). It works with sensible
defaults the moment you enable it, so everything here is tuning.

## Open the settings form

1. Log in as a user with the **Administer password policy** permission. This
   permission is marked *restricted*, so grant it only to trusted administrators —
   it controls every rule, the expiry behaviour, and the reset-route toggle below.
2. Go to **Configuration → People → Password policy**, or navigate directly to
   `/admin/config/people/password_policy`.

## The rules, field by field

Each rule below has a default (in brackets). For every rule, an **empty value skips
that check** entirely. For the character-class rules, a value of **`0` inverts the
meaning** to *must not contain any of that class*.

- **Minimum length** *(default 12)* — the fewest characters a password may have.
  This is the single most effective rule.
- **Minimum lowercase** *(default 1)* — required count of `a`–`z`. `0` means the
  password must contain none.
- **Minimum uppercase** *(default 1)* — required count of `A`–`Z`. `0` means none.
- **Minimum numeric** *(default 1)* — required count of digits `0`–`9`. `0` means
  none.
- **Minimum special** *(default 1)* — required count of non-alphanumeric
  characters. `0` means none.
- **Similar to username** *(default empty)* — an upper similarity threshold from 0
  to 100 percent. `0` means the password may not equal the username; `100` allows
  anything; empty skips the check.
- **Password history / minimum old** *(default empty)* — how many previous passwords
  may be re-used. `0` means a password may never be re-used. This relies on the
  password-history table created when you installed the module.
- **Minimum old age** *(default empty)* — restricts the history check to entries
  newer than this many **seconds**, so only recent passwords count as "used". Empty
  counts all history.

## Expiry and the warning email

- **Expire period** *(default `1 year`)* — how long a password stays valid. You can
  enter a number of seconds or a plain phrase like `3 months`. Empty means passwords
  never expire.
- **Expiry warning** *(default `3 weeks`)* — how far ahead of expiry the user is
  warned. Empty means no warning.
- **Warning email** — the subject and body of the advance-warning email. The body
  supports tokens, including one for the configured expiry period. Leaving the
  "from" address empty uses the site default.

When a password is expired, the module redirects the user to their edit form on their
next request until they set a compliant password (AJAX requests and the ignored
routes below are exempt from this redirect).

## Exemptions — who and where the policy doesn't apply

- **Bypass password policy** *(permission)* — a user holding this permission (through
  any role) is fully exempt: none of the length, complexity, history or expiry checks
  apply to *their own* password. Note the important subtlety: bypassing applies only
  to the bypassing user's own password. It does **not** let that user create *other*
  accounts with non-compliant passwords — for that, the target account must also have
  a bypass role. Use it for service or system accounts.
- **Ignored users** — a list of usernames or email addresses (matched exactly) that
  are exempt from the whole policy.
- **Ignored routes** — routes on which the *expiry redirect* is suppressed. The
  default list already covers the user edit form, AJAX, logout, the cache-flush
  action, the password-reset route and public image-style URLs, and the module always
  additionally ignores the CSS/JS asset routes, so normal site operation isn't
  interrupted.

## Reset and logout controls

- **Disable password reset** *(default off)* — when enabled, the core password-reset
  route (`user.pass`) is closed off, removing the "reset your password" link.
- **Force password reset** *(a checkbox on save)* — when ticked, saving the form
  batch-expires **every** user's password, forcing everyone to set a new one. This is
  an action taken at save time, not a stored setting.
- **Force logout** *(a checkbox on save)* — when ticked, saving the form deletes all
  active sessions, forcing every user to log in again.

## A gotcha worth knowing

When you save the form, the ignored-routes and ignored-users lists are split on a
literal `\n` token rather than a real newline, so multi-line entries in those text
areas may not split as you expect. If in doubt, enter one value, save, and verify it
was stored correctly before adding more.

## Save

Click **Save configuration**. New rules apply to password changes from that point on.
Check that they fire everywhere passwords are set — registration, profile edit,
password reset, and programmatic or Drush-driven user creation (the reset route is a
special case).

## A recommendation worth repeating

As noted on the [main guide](../index.md), modern guidance (NIST 800-63B, UK NCSC)
favours a **long minimum length** over mandatory character-class rules and forced
expiry. The most defensible configuration is often a high **Minimum length** with the
character-class and expiry knobs left empty, paired with a breached-password check
such as `pwned_passwords` to do the real work.
