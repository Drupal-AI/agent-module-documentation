# Custom Password Reset — manual setup guide

**Custom Password Reset** (`pwd_reset`) is the single module shipped by the legacy
`passwordpolicy` project. It is a small, form-alter-only module that customises the
behaviour of Drupal core's one-time-login **password-reset landing page** — the
page a user reaches from a reset link at `/user/reset/…`.

When someone lands on that page, pwd_reset:

- retitles the page to **"Reset password"**,
- appends a short block of **password guidelines** under the password field,
- enforces a fixed **complexity rule** on the new password (at least 8 non-space
  characters, with at least one lowercase letter, one uppercase letter, one digit,
  and one punctuation character),
- relabels the submit button to **"Login"**, and
- after the reset succeeds, **logs the user out and redirects them to the login
  form**.

That is the whole module. There are no settings, no routes of its own, no
permissions, and no dependencies — the behaviour is hard-coded in
`pwd_reset.module`. The complexity check runs *in addition* to Drupal core's own
password constraints, so the effective rule is whichever is stricter. It only
affects the reset landing page; passwords changed elsewhere (an admin editing
another account, or user registration) are untouched.

If you want configurable, role-aware password policies instead of a fixed rule,
use the maintained [Password Policy](https://www.drupal.org/project/password_policy)
module. Note that this project has no Drupal 11 release (it targets core
`^8 || ^9 || ^10`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the `passwordpolicy` project and
   enable the `pwd_reset` module.

There is **no configuration page** for this module — its behaviour is hard-coded,
with nothing to set up in the admin UI.

## Where it lives in the admin menu

pwd_reset adds no admin page. It only changes the core password-reset page shown at
`/user/reset/{uid}/{timestamp}/{hash}`. To change the guideline text or the
complexity rule you would edit `pwd_reset.module` directly.
