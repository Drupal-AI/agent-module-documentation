# Registration codes — manual setup guide

**Registration codes** (`regcode`) gates user registration behind a **code**. It
sits between two extremes: fully open registration (which invites spam) and fully
closed registration (where an administrator has to create every account). With
Registration codes, sign-up stays self-service — but only for people who were
given a valid code.

That fits a lot of real situations: invitation-only sign-ups, conference
attendees who receive a code with their ticket, members of a partner
organisation, a beta cohort, promotional codes, or "medallion"-style registration
where a physical purchase entitles someone to an account. You generate codes in
bulk, manage them from an admin listing, and require one on the registration form.

Because **Views** is a dependency, the code list is itself a View — so you can
filter, sort and export codes just like any other Drupal listing. The module
provides an **Administer registration codes** permission to control who can manage
them.

Two things about how you configure it decide whether codes are genuinely a
control. Whether a code is **single-use** decides whether one leaked code opens the
door indefinitely (a code posted in a public forum is a code everyone has), and
whether codes **expire** decides how long a leak stays useful. Both are settings,
and both are worth setting deliberately — see [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings that decide whether
   codes are actually a control, plus generating and managing codes.

## Where it lives in the admin menu

Registration codes lives under **Configuration → People**. The main areas are:

- **Manage codes** — `/admin/config/people/regcode/manage` — the code list (a
  View you can filter and export).
- **Create codes** — `/admin/config/people/regcode/create` — generate codes in
  bulk.
- **Settings** — `/admin/config/people/regcode/settings` — the configuration form
  (`regcode.admin_settings`).

All of these require the **Administer registration codes** permission.
