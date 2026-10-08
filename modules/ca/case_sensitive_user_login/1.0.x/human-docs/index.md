# Case Sensitive User Login — manual setup guide

**Case Sensitive User Login** (`case_sensitive_user_login`) makes the username
typed at the login form match the stored username's case *exactly*. Out of the
box, Drupal treats usernames as case-insensitive at login — if your account is
`admin`, you can sign in as `admin`, `Admin`, or `ADMIN` and it all works. This
module adds a validation step to the login form that looks up the exact-case
username and rejects the attempt (with the normal "unrecognized username or
password" message) whenever the case differs.

It works the moment you enable it — there is nothing to configure. It depends
only on core's **User** module, and it touches nothing but the login form:
password reset, API logins, and the rest of core behave exactly as before.

A couple of things are worth understanding before you rely on it. First, this is
a **purely restrictive** addition — it layers on top of core's own login
validation and never replaces authentication or opens a bypass, so the worst it
can do is reject a mismatched-case login. Second, and more importantly, its
extra check runs a database query with `=`, and whether that comparison is
case-sensitive depends on your **database collation**. Under the common
case-insensitive MySQL default, the check is effectively a no-op. So if
case-exact login genuinely matters to you, make sure your database uses a
case-sensitive collation — do not treat this module as a hard security boundary
on its own. (Note too that Drupal core already enforces case-insensitive
username *uniqueness*, so you cannot normally have both `admin` and `Admin` as
separate accounts in the first place.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. Once enabled, it enforces
case-exact login automatically.

## How to use it

Install and enable it — that is the whole setup. From then on, users must type
their username with the same capitalization it was stored with. If you want the
check to actually bite, confirm your database uses a case-sensitive collation;
otherwise the module is installed but inert.
