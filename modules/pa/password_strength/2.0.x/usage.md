<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Password Strength adds a zxcvbn-based "Password Strength" constraint to the Password Policy
module, scoring passwords 0 (very weak) to 4 (very strong) via pattern matching and minimum
entropy rather than rigid character rules.

---

The module is a thin bridge between the [zxcvbn-php](https://github.com/bjeavons/zxcvbn-php)
library and Drupal's `password_policy` module. It registers a single `password_policy`
constraint plugin, `password_strength_constraint`, whose only setting is a minimum required
strength score (`strength_score`, an integer 0–4, default 3). When a user sets a password,
zxcvbn estimates its strength from "matchers" (dictionary words, l33t substitutions, dates,
years, digit runs, repeats, sequences, keyboard-spatial patterns) and the user's own account
name and email; if the computed score is below the policy's minimum the constraint fails with
a message reporting both the actual and required scores. Which zxcvbn matchers participate is
controlled globally by the `password_strength.settings` config (`enabled_matchers`), editable
at `/admin/config/security/password_strength/settings`. The module also defines a
`PasswordStrengthMatcher` plugin type so custom matchers can be added, and exposes a
`Drupal\password_strength\PasswordStrength` class whose `passwordStrength()` method returns
zxcvbn's raw result (`score`, `entropy`, `match_sequence`). Because scoring is holistic, it
promotes usable-but-strong passwords instead of forcing an exact character composition. The
module has no config UI of its own for the constraint — you configure it inside a Password
Policy. It depends on `password_policy` (`^3.1 || ^4.0`) and ships as an 8.x-2.0 **beta**
release.

---

- Enforce a minimum zxcvbn strength score (0–4) as part of a Password Policy.
- Replace rigid "1 uppercase, 1 number, 1 symbol" rules with holistic entropy scoring.
- Require very strong passwords (score 4) for administrator or privileged roles.
- Require a moderate score (score 2–3) for regular authenticated users.
- Reject passwords that are just the user's username or email address.
- Block dictionary-word passwords ("password", "sunshine") via the dictionary matcher.
- Block l33t-speak variants ("p@ssw0rd") that only superficially look complex.
- Reject keyboard-spatial passwords ("qwerty", "asdfgh") via the spatial matcher.
- Reject sequential passwords ("abcdef", "123456") via the sequence matcher.
- Reject passwords with long digit runs or embedded years/dates.
- Reject passwords that repeat a character or block many times ("aaaaaa").
- Give editors clear feedback: "score of 1 but the policy requires at least 3".
- Layer strength scoring alongside other password_policy constraints (length, history).
- Apply different strength thresholds per role by creating multiple policies.
- Tune sensitivity by enabling/disabling specific zxcvbn matchers site-wide.
- Add a custom matcher plugin for domain-specific weak-password patterns.
- Score a password programmatically in custom code via the `PasswordStrength` class.
- Estimate password entropy for logging or analytics without enforcing a policy.
- Encourage passphrases, which score highly, over short complex strings.
- Improve account security for sites that cannot mandate SSO or 2FA.
- Meet security-baseline requirements that call for strength estimation.
- Prototype password UX where usability and strength must be balanced.
- Gate password resets so users cannot re-set an easily-guessed password.
- Provide consistent, library-backed scoring instead of hand-written regex rules.
