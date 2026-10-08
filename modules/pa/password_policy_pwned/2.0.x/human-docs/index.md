# Password Policy Pwned Passwords — manual setup guide

**Password Policy Pwned Passwords** (`password_policy_pwned`) adds a new
constraint to the [Password Policy](https://www.drupal.org/project/password_policy)
module that rejects passwords known to have appeared in public data breaches. When
a user sets or changes a password, the constraint checks it against the
[Have I Been Pwned](https://haveibeenpwned.com/) breach corpus and blocks it if it
has been seen too many times — a simple, effective way to cut credential‑stuffing
risk and satisfy guidance like NIST 800‑63B that says new passwords should be
screened against a breached‑password list.

The check is privacy‑preserving. It uses the Have I Been Pwned **k‑anonymity range
API**: the password is hashed with SHA‑1 and only the **first five characters** of
that hash are sent to the third‑party service. The API returns all hash suffixes
sharing that prefix, and the module matches the rest locally — so the full password
and full hash never leave your site. There is one setting, the minimum number of
breach occurrences that triggers rejection (default 1, i.e. reject any password
seen even once).

The constraint "fails open": if the Have I Been Pwned API is unreachable or times
out, the password is allowed (the outage is logged) so account changes aren't hard
blocked by a service problem. There is no fail‑closed option out of the box.

This module has no settings page of its own — you use it by adding its constraint
to a Password Policy, alongside other constraints like length and character types.
It depends on the **Password Policy** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Password Policy)
   with Composer and enable it.

## Where it lives in the admin menu

The module adds no page of its own. You use its constraint inside Password Policy
at **Configuration → Security → Password Policy**
(`/admin/config/security/password-policy`).

## How to use it

1. Make sure both **Password Policy** and this module are enabled.
2. Go to **Configuration → Security → Password Policy**
   (`/admin/config/security/password-policy`) and add or edit a policy.
3. On the **Constraints** step, add **Pwned Passwords**.
4. Set **Minimum number of occurrences** — a password is rejected when its breach
   count is greater than or equal to this number. `1` rejects any password that has
   appeared in a breach even once; raise it to be more lenient. It must be a
   positive number.
5. Save the constraint, then finish the policy and **assign it to one or more
   roles**. The check runs whenever a user those roles applies to sets or changes
   a password. (You can also use Password Policy's password‑reset behavior to push
   existing users to change compromised passwords.)

If a user submits a breached password, they see a message like *"Password has been
exposed N time(s) in data breaches…"* and must choose a different one. An empty
password passes this constraint (core's "required" handling covers that).

### For developers

The lookup is wrapped in an injectable `pwned_passwords_client` service whose
`getOccurrences($password)` returns the breach count (0 on none or on error). You
can call it from your own code, or override the service — for example to point at a
self‑hosted Have I Been Pwned mirror or add caching — by providing a class that
implements `PwnedPasswordsClientInterface`.
