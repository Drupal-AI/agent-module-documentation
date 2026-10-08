# Disable Login Page — manual setup guide

**Disable Login Page** (`disable_login`) hides Drupal's public `/user/login` form
from anonymous visitors unless the request carries a **secret key** in the URL.
Without the key, `/user/login` returns Access Denied; with it —
`/user/login?key=yoursecret` — the normal login form appears. It is a simple,
effective way to keep bots, scanners, and the general public away from the sign-in
page on sites that have no public registration.

This is useful on corporate sites, personal blogs, and members-only intranets
where only a known set of staff ever needs to log in. You give those people a
single bookmarkable URL containing the secret, and everyone else — including
brute-force scripts and credential-stuffing bots — simply cannot see the login
form at all. It is a lightweight layer of "security through obscurity" that pairs
well with flood control and two-factor modules.

You choose both the **name** of the query parameter and its **secret value**, so
your private login URL can look like whatever you want (`?key=…`, `?entry=…`, and
so on). The secret can also be rotated programmatically — for example changed
every month or pulled from an environment variable — through a small hook, so you
are not tied to a static value baked into config. Importantly, the module ships
**no default configuration**, which means protection is **off until you turn it
on and save**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the config keys, the access
logic, and the key-rotation hook — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turn on protection, set the query
   parameter name and secret, and recover if you lock yourself out.

## Where it lives in the admin menu

The settings form is at **Configuration → Security → Disable Login Page**
(`/admin/config/security/disable-login`), available to users with the **Administer
site configuration** permission.

## How to use it

Enable the module, then open the settings form and turn protection on, choose a
query parameter name (for example `key`), and set a secret value. Save, then
share the resulting URL (`/user/login?key=yoursecret`) with the people who need to
log in. Everyone else who visits `/user/login` gets Access Denied. See
[Configuration](configuration/index.md) for the step-by-step, and for how to
recover if you ever forget the key.
