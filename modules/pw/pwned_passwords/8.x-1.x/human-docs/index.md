# Pwned Passwords — manual setup guide

**Pwned Passwords** (`pwned_passwords`) checks the passwords your users choose
against the **[Have I Been Pwned](https://haveibeenpwned.com/Passwords)** (HIBP)
breach corpus and warns — or blocks — when a chosen password is one that has
already appeared in a known data breach. This is exactly the measure current
guidance (NIST 800-63B among others) recommends: rules that merely demand "a symbol
and a digit" happily accept `Password1!`, which is in every breach list, whereas
checking against passwords attackers actually try is far more effective.

**The privacy design is the first thing people ask about, and it is correct.**
Pwned Passwords does **not** send the user's password anywhere. It uses HIBP's
**k-anonymity range API**: it computes the SHA-1 hash of the password locally,
sends only the **first five hex characters** of that hash to
`api.pwnedpasswords.com/range/`, receives back the set of matching hash suffixes,
and does the full comparison **on your server**. Neither the plaintext password nor
the complete hash ever leaves the site.

> **Three things to know before you deploy this release (8.x-1.4):**
>
> 1. **The shipped defaults only warn.** Out of the box the error threshold is
>    `0` and "block submit" is off, so the module only **warns** until you
>    configure it (see [Configuration](configuration/index.md)).
> 2. **Use the per-form options** (registration, profile edit, and optionally
>    login) rather than the global "validate all passwords" option.
> 3. **The check is a synchronous outbound request** with a two-second timeout,
>    built on a bare Guzzle client that ignores Drupal's proxy configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form field by field,
   including the thresholds you must set for it to actually enforce anything.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Pwned Passwords**
(`/admin/config/people/pwnedpassword`), behind the **administer pwned_passwords**
permission (a restricted permission). The configure route is
`pwned_passwords.admin_form`.
