# Better Passwords — manual setup guide

**Better Passwords** (`better_passwords`) enforces a stronger password policy across
your Drupal site, following the password guidance in NIST 800‑63B. It layers onto
core's own password fields rather than replacing them: every password entered on
registration, on the user‑edit form, or through a one‑time‑login reset is checked
against two rules — a **minimum length** and a **minimum strength** — and, optionally,
admin‑created accounts can be given a strong auto‑generated password.

Strength is measured with the well‑regarded **zxcvbn** library, which scores a password
from 0 (trivial) to 4 (very strong) based on how hard it is to crack: it penalises
common‑password dictionary matches, dates and years, purely numeric strings, repeats,
sequences like `abcdef`, and keyboard‑adjacent runs like `qwerty`. The user's own name
and email are fed in as extra dictionary words, so a password containing them scores
lower. When a password is rejected, the user gets a clear *"Please choose a stronger
password"* message with a bulleted list of exactly what was wrong.

The whole policy is just three settings on one admin page, so it is quick to set up and
easy to export as configuration for repeatable deployment. There are no plugins, field
types, or Drush commands — and the rules apply to every account on the site, with a
single permission controlling only who may change the policy.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the zxcvbn
   library) and enable the module.
2. [Configuration](configuration/index.md) — the three policy settings, field by field.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Passwords**
(`/admin/config/people/passwords`), reachable by any role holding the **Administer
Better Passwords** permission. There is nothing else to click — once the policy is set,
it is enforced automatically on every password field.
