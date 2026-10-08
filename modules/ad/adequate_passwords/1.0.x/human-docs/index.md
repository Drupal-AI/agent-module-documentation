# Adequate Passwords — manual setup guide

**Adequate Passwords** (`adequate_passwords`) makes Drupal actually *enforce* the
password strength it already advises. Core shows users a strength meter — weak,
fair, good, strong — as they type a new password, but it never stops them saving a
weak one. Adequate Passwords closes that gap: it turns the meter's own scoring into
a hard requirement, so the feedback users already see becomes the rule they must
meet.

It works entirely additively. When a password is submitted (on registration, on
the user profile edit form, and anywhere else core's password field appears), the
module recalculates a strength score using logic equivalent to core's own meter —
penalising passwords under 12 characters, and those missing lowercase letters,
uppercase letters, numbers, or punctuation, with a hard penalty if the password
matches the username. If the score is below the threshold you chose, the form is
rejected with the same improvement tips the meter shows. It only ever *adds* an
error; it never weakens, replaces, or bypasses core authentication.

You choose the required strength level, which user roles the policy applies to, and
whether to show a success message — all from one settings form. Anonymous users are
always exempt, and the random password Drupal generates during a command-line site
install is deliberately skipped so installs never break. It works on Drupal 8.8, 9,
10, and 11 and has no dependencies.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form: strength
   threshold, roles, and the success message.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → People → Adequate
Passwords** (`/admin/config/people/adequate_passwords`), gated by the core
*administer site configuration* permission. There is no other UI — enforcement
happens automatically on the password fields users already use.
