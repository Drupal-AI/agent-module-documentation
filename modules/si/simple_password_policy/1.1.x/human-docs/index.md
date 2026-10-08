# Simple password policy — manual setup guide

**Simple password policy** (`simple_password_policy`) enforces a fixed but
configurable set of password rules on your site's user accounts — minimum length;
required counts of lowercase, uppercase, numeric and special characters; a
similarity-to-username check; password history; and password expiry. It is a
deliberately **lighter alternative** to the full
[Password Policy](https://www.drupal.org/project/password_policy) module: rather
than a pluggable per-role constraint system, it gives you a single settings form
with one fixed set of rules.

The thinking behind it: most sites don't have a written password standard — they
just need to stop people choosing `password`, and the full module is a large amount
of configuration surface for that. It works as soon as you enable it (it ships with
sensible defaults, including a 12-character minimum), and you tune the rules on its
settings form. It depends only on core's **User** module and has no submodules.

Enforcement here is **real and server-side**, not just an advisory strength meter.
The module overrides core's password field plugin and adds a validation handler to
the user form, so a non-compliant password on **registration or profile edit** is
rejected with a form error before it can be saved. Programmatic saves (`$user->save()`
in code, or Drush `user:password`) are handled differently: they aren't hard-blocked,
but a non-compliant password is stored as **expired**, and the next time that user
makes a request they are redirected to their edit form until they set a compliant
one. Beyond the rules, the module adds password expiry with a warning email, makes
Drupal's password *generator* produce policy-compliant passwords, and can optionally
disable the core password-reset link or force every user to reset or re-login after
you tighten the policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

### A word on password rules that's worth reading

Current security guidance — from NIST 800-63B and the UK's NCSC — has moved *away*
from mandatory character-class rules and from periodic forced expiry, because they
push people toward predictable transformations: `Password1!` satisfies most rule
sets and appears in every breach list, and forced rotation just produces
`Password2!`. What the same guidance recommends instead is a **generous minimum
length** plus **checking passwords against known-breached lists** (a job for a
module like `pwned_passwords`). So the most defensible way to configure this module
is often a high `min_length`, the character-class and expiry knobs left empty, and a
breach check doing the real work.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form, rule by rule,
   including expiry, exemptions and the two permissions.

## Where it lives in the admin menu

Once enabled, the settings form sits under **Configuration → People → Password
policy** at `/admin/config/people/password_policy` (route
`simple_password_policy.simple_password_policy_settings`). You need the
**Administer password policy** permission — which is marked as restricted, so grant
it only to trusted administrators.
