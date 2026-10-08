# Password Stats — manual setup guide

**Password Stats** (`password_stats`) is a small security‑audit tool that reports
on the **hashing algorithms** used by the passwords stored on your site. Since
Drupal 10.1, core stores and verifies passwords with PHP's native `password_hash()`
and `password_verify()` functions. Accounts created on older versions may still
carry hashes made with Drupal's previous hashing algorithm — and those are the
accounts you want to know about, because they are candidates for rehashing to the
stronger scheme.

The module surfaces two numbers: the **total** number of stored password hashes,
and the number of active users whose passwords were hashed **before Drupal 10.1**.
It also gives you a practical recommendation: if no active users still have
pre‑10.1 hashes, it suggests you can safely disable the **Password Compatibility**
module.

A few important points about what this module does and does not do. It reads only
the **hashed** password values — it cannot and does not read anyone's plaintext
password. It classifies those hashes by algorithm; that is the whole job. It has no
settings form and grants no special access. But do remember that password hashes
are still **sensitive data**: keep the report and the Drush commands to trusted
administrators, and do not expose the counts to untrusted users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form. You
read its output from the Status report or via Drush, as described under "How to use
it" below.

## How to use it

Password Stats presents its findings in two places:

- **Status report.** Go to **Administration → Reports → Status report** and look
  under the **Password Compatibility** heading. There you will see the total number
  of stored hashes and the number of active users still on pre‑10.1 hashes, plus
  the recommendation about the Password Compatibility module.
- **Drush.** The module adds two commands for scripting and quick checks:
  - `drush password_stats:legacy` — the number of passwords stored with legacy
    (pre‑10.1) hashing algorithms.
  - `drush password_stats:total` — the total number of hashed passwords.

Use these to decide whether any accounts need their passwords rehashed (which
generally happens automatically the next time those users log in) and whether the
Password Compatibility module is still needed.

> **Keep the output private.** Password hash counts are sensitive. Restrict access
> to the Status report and the Drush commands to trusted administrators.
