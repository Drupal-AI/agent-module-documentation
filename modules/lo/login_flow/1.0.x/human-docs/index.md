# Login Flow — manual setup guide

**Login Flow** (`login_flow`) is a plug‑in framework for the Drupal login process.
Rather than each authentication module having to alter the login form or build its
own alternative, Login Flow provides a shared system into which modules contribute
**Authentication** and **Challenge** plug‑ins. That lets different modules handle
authentication for specific accounts, and lets you add extra verification steps —
the building blocks of a multi‑step login flow.

By itself, Login Flow doesn't change much: a **Password Authentication** plug‑in is
enabled by default and simply replicates Drupal's standard username‑and‑password
login. The real functionality arrives when you enable one of its sub‑modules or
another module that provides a plug‑in. The base module also lets you edit the
label and description of the username field, and allows login by username *or*
email address.

Two companion sub‑modules ship with the project:

- **Login Flow Email Link** — passwordless login via a one‑time link sent by email.
- **Login Flow Email Code** — passwordless login via a code sent by email, or an
  additional security step on top of the normal username‑and‑password login.

Because Login Flow sits directly in the authentication trust path, treat it with
care: its security depends entirely on the challenge plug‑ins you enable. Make
sure any challenge you add cannot be skipped or bypassed, that it fails closed, and
that it is implemented securely — a challenge plug‑in ultimately governs who gets
logged in.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and add the sub‑module(s) that provide the login behaviour you want.

The base module's own configuration is a plug‑in list, described below — there is
no separate settings walkthrough because the meaningful options come from whichever
plug‑ins you enable.

## How to use it

1. Enable Login Flow and at least one plug‑in provider — either a bundled
   sub‑module (Email Link or Email Code) or another module that implements a Login
   Flow plug‑in. On its own the base module only replicates standard core login.
2. Open the Login Flow configuration form. It lists all available plug‑ins and the
   **order** in which they are evaluated. Each plug‑in provides its own settings to
   determine which user accounts it handles.
3. Order matters: the **first Authentication plug‑in that handles authentication
   for a given account is the only one used** for that account. Arrange the list so
   the right plug‑in takes precedence for the accounts you intend.
4. Add Challenge plug‑ins where you want extra verification steps layered onto the
   login. Review each one carefully — every challenge is part of what decides who
   is allowed in.
