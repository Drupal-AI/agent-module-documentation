# Role login page — manual setup guide

**Role login page** (`role_login_page`) lets a single Drupal site offer **several
login pages** and send users to **different destinations** after they sign in,
depending on their roles. Sites with distinct audiences often want distinct
entrances: a staff login that lands on the editorial dashboard, a member login that
lands on the member area, a supplier portal whose login looks like the portal rather
than like Drupal, or a course participant sent straight to their current course.

Core gives you one login form and one destination rule, so without a module the
alternatives are a hand-written `hook_user_login()` redirect per site, or a pile of
paths with redirects bolted around them. This module turns that into simple
configuration: you define named login pages, each with its own path and its own
post-login destination per role.

The module works on Drupal 8 through 11 and its settings are gated by the
**Administer role login settings** (`administer role login settings`) permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add login pages and set their
   per-role destinations.

## Where it lives in the admin menu

Once enabled, manage login pages at **Administer → Configuration → Role login
settings → Role login settings list** (the `role_login_page.settings_list` route).
From there you add each login page and set its path and destinations.

## Two things to be precise about

Login is where a small mistake becomes a large one, so keep two facts in mind:

- **A distinct login page is presentation, not separation.** Every login form here
  authenticates against the *same* user table, so a member can log in at the staff
  page and vice versa. Only the destination differs — the credentials do not. If
  your requirement is that staff accounts *must not* be able to authenticate at the
  public entrance at all, that is a job for a domain/IP restriction or a genuinely
  separate site, not for this module.
- **Post-login redirects deserve care.** A destination taken from *configuration*
  (which is how this module works) is safe. A destination taken from a user-supplied
  request parameter would be an open-redirect surface — so keep destinations defined
  in the settings, not driven by untrusted input.
