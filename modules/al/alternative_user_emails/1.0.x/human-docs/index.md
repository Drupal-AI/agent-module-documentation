# Alternative User Emails — manual setup guide

**Alternative User Emails** (`alternative_user_emails`) lets a user account store
**additional email addresses** beyond its primary one. If a person uses several
email addresses, this module lets those extra addresses be recorded on their
account.

It's a user/identity feature built on core's **User** and **Field** modules, and it
has no access-control role of its own — it simply stores the addresses.

There are important things to keep in mind, because email addresses are sensitive:

- Alternative emails are **personal data**. Store and expose them in line with your
  site's privacy policy.
- The module stores the addresses; it does not, by itself, verify them. If you (or
  another module) ever let people **log in or reset a password** using an
  alternative address, make sure those addresses are **verified** and **unique**
  first. An unverified or duplicated alternative email is an account-takeover /
  identity risk — enforce verification and uniqueness in whatever consumes the
  addresses.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds alternative-email field(s) to **user accounts**, so the addresses
are managed on the user's own account/edit form under **People** (`/admin/people`)
rather than on a separate settings page.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit a user account (the user's own edit form, or an administrator via
   **People**).
3. Add the alternative email address(es) for that account and save.

Treat the stored addresses as personal data, and verify them before using any for
login or password reset.
