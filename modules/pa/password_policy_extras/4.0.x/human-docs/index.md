# Password Policy Extras — manual setup guide

**Password Policy Extras** (`password_policy_extras`) polishes the live-validation experience
that the [Password Policy](https://www.drupal.org/project/password_policy) module shows on
password forms. Out of the box Password Policy displays a three-column table of constraints
(the rule, whether it passed, a description) that only refreshes on page interaction. This
module makes that feedback feel modern: the constraint table **re-checks the password over
AJAX as the user types**, and you get admin toggles to slim it down, hide clutter, and place
it where it reads best.

Through a short settings form you can show **only the failed rules** instead of the full
table, **hide Drupal core's default password suggestions**, move the status display **below
the main password field**, reveal the table only **when the field gains focus**, turn off the
AJAX throbber, and set how long to wait after a keystroke before re-checking. There are also
accessibility fixes to the status feedback.

Under the hood the module also fixes a real gap: it makes Password Policy validate correctly
on forms that don't carry a user entity in form state, and it introduces two events that let
other code decide, per route or user, whether the status table should show and whether
validation should run. Three optional submodules use that event system to make Password
Policy work on password forms provided by other contrib modules (User Registration Password,
PRLP, and Password Separate Form).

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Password Policy
   dependency) with Composer, enable it, and pick submodules.
2. [Configuration](configuration/index.md) — the settings form, option by option.

## Where it lives in the admin menu

The settings form sits under Password Policy's own admin area at **Configuration → Security →
Password Policy → Extras**
(`/admin/config/security/password-policy/extras/settings`), gated by the **Administer site
configuration** permission. The module adds no permissions of its own.
