# Configuration

Simple password policy is driven by a single settings form. It works with sensible
defaults the moment you enable it, so everything here is tuning.

## Open the settings form

1. Log in as a user with the **Administer password policy** permission. This
   permission is marked *restricted*, so grant it only to trusted administrators —
   it controls every rule below.
2. Go to **Configuration → People → Password policy**, or navigate directly to
   `/admin/config/people/password_policy`.

## The rules, field by field

Each rule below has a default (shown in brackets). Leaving a rule **empty** skips
that check.

- **Minimum password length** *(default 12)* — the fewest characters a password
  may have. This is the single most effective rule; a generous floor here does more
  for security than the character-class rules below.
- **Minimum lowercase characters** *(default 1)* — how many `a`–`z` characters are
  required.
- **Minimum uppercase characters** *(default 1)* — how many `A`–`Z` characters are
  required.
- **Minimum numeric characters** *(default 1)* — how many digits `0`–`9` are
  required.
- **Minimum special characters** *(default 1)* — how many non-alphanumeric
  characters are required.
- **Similar to username** *(default empty)* — rejects a password that is too
  similar to the account's username.
- **Password history** *(default empty)* — how many previous passwords may not be
  re-used, optionally combined with a period during which old passwords are
  disallowed.

## Expiry and warnings

- **Expire period** *(default `1 year`)* — how long a password stays valid before
  the user is prompted to change it. Leave empty for no expiry.
- **Expiry warning** *(default `3 weeks`)* — how far ahead of expiry the user is
  warned. The module sends a warning email so people can change their password
  before it lapses.

## Exemptions — who and where the policy doesn't apply

- **Bypass password policy permission** — a user with this permission is exempt
  from the rules. Use it for a service or system account whose credentials
  shouldn't be forced through the interactive rules.
- **Ignored users** — a list of specific users the policy does not apply to.
- **Ignored routes** — routes on which the expiry check is not applied. The default
  list already includes the user edit form, AJAX, logout, the cache-flush action,
  the password-reset route, and public image-style URLs, so normal site operations
  aren't interrupted by the expiry redirect.

## Save

Click **Save configuration**. New rules apply to password changes from that point
on — check that they fire everywhere passwords are set: registration, profile edit,
password reset, and any programmatic or Drush-driven user creation.

## A recommendation worth repeating

As noted on the [main guide](../index.md), modern guidance (NIST 800-63B, UK NCSC)
favours a **long minimum length** over mandatory character-class rules and forced
expiry. If you want the strongest practical policy, consider setting a generous
**Minimum password length**, leaving the character-class minimums modest or empty,
and pairing this module with a breached-password check such as `pwned_passwords`.
