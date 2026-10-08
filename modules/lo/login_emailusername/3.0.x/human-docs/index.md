# Login with Email or Username — manual setup guide

**Login with Email or Username** (`login_emailusername`) lets people sign in with
**either** their username **or** their email address, using the same input box on
Drupal's standard login form. Unlike some alternatives, it doesn't take the username
away — accounts keep their usernames, and email simply becomes an additional accepted
login identifier. It's the small quality‑of‑life fix for users who remember their email
but not the username they picked months ago.

On the login form it relabels the "Username" field to **"Username or email address"**,
updates the description to match, and adds a validation step: it first tries to match
the input as a username, and only if that fails does it fall back to looking the
account up by email — rewriting the submitted value to the matching username so Drupal's
normal authentication proceeds unchanged. The same email‑to‑username resolution is
applied to the JSON/REST login and password‑reset endpoints, so decoupled and mobile
clients get the same convenience, and the password‑reset form accepts either a username
or an email.

The module is intentionally minimal: it depends only on core's **User** module, adds no
content types, config entities, permissions, or settings, and requires Drupal
`^10.3 || ^11.0`. **Enabling the module is all it takes** — there is nothing to
configure, and uninstalling reverts cleanly to username‑only login.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it. That's the whole setup.

## Where it lives in the admin menu

Nowhere — there is no settings page and no configuration. Once the module is enabled,
the change is visible on the standard login form (`/user/login`), whose field is now
labeled **"Username or email address"** and accepts both.

## How to use it

There's nothing to switch on. After enabling the module:

- On **`/user/login`**, users can type **either** their username or their email address
  in the first field, along with their password, and log in.
- On the **password‑reset** form (`/user/password`), users can request a reset by
  supplying **either** their username or their email address.
- **REST/JSON login and password‑reset** requests (`user.login.http` /
  `user.pass.http`) accept the email address too, so app and decoupled clients behave
  the same way.

Core's flood control and blocked‑account checks continue to apply exactly as before.

> **Not to be confused with Email Registration.** That module *replaces* the username
> field and generates usernames from email addresses. Login with Email or Username
> keeps meaningful usernames and only *adds* email as an accepted way to sign in.
