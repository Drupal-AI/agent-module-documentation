# Simple password policy — manual setup guide

**Simple password policy** (`simple_password_policy`) enforces a basic set of
password rules on your site's user accounts — minimum length, how many lowercase,
uppercase, numeric and special characters are required, a check that the password
isn't too similar to the username, password history, and password expiry. It is
deliberately a **lighter alternative** to the full
[Password Policy](https://www.drupal.org/project/password_policy) module: rather
than a pluggable per-role constraint system, it gives you one settings form with a
fixed set of configurable rules.

The thinking behind it: most sites don't have a written password standard — they
just need to stop people choosing `password`. The full Password Policy module is a
large amount of configuration surface for that, and Simple password policy is a
reasonable, smaller choice. It works as soon as you enable it (it ships with
sensible defaults, including a 12-character minimum), and you tune the rules on its
settings form. The module depends only on core's **User** module and has no
submodules.

The module also notifies users when their password is about to expire (with an
advance warning email) and can exempt accounts from the policy — via the
**Bypass password policy** permission, a list of ignored users, or a list of routes
where the expiry check is skipped.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

### A word on password rules that's worth reading

Current security guidance — from NIST 800-63B and the UK's NCSC — has actually
moved *away* from mandatory character-class rules and from periodic forced expiry,
because they push people toward predictable transformations: `Password1!` satisfies
most rule sets and appears in every breach list, and forced rotation just produces
`Password2!`. What the same guidance recommends instead is a **generous minimum
length** plus **checking passwords against known-breached lists** (a job for a
module like `pwned_passwords`). So the most defensible way to configure this module
is often a high length floor and little else, letting a breach check do the work the
complexity rules were meant to do.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form, rule by rule.

## Where it lives in the admin menu

Once enabled, the settings form sits under **Configuration → People → Password
policy** at `/admin/config/people/password_policy` (route
`simple_password_policy.simple_password_policy_settings`). You need the
**Administer password policy** permission — which is marked as restricted, so grant
it only to trusted administrators.
