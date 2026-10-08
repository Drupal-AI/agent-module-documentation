# Require Login — manual setup guide

**Require Login** (`require_login`) forces user authentication across your Drupal
site: any anonymous visitor is redirected to the login page, turning the whole site
— or just a subset of paths — into a private, login-gated experience. It's the
quickest way to lock down a staging or pre-launch site, build a members-only area,
gate an intranet, or set up a "coming soon, log in to preview" wall, all without
wiring up per-node access or complex permission schemes.

The important thing to know up front: **out of the box, every page requires login.**
As soon as you enable the module, anonymous users can reach essentially nothing but
the login, registration, and password-reset pages (and the CSS/JS/image assets
needed to render them). Once a user logs in, the site behaves normally. You then use
the settings form to *narrow* where login is required — for example only under
`/members`, or everywhere except a handful of public pages — by combining core
condition plugins.

Beyond the on/off gate, you can point anonymous users at a custom login path, show
them a "please sign in" message, send them to a fixed landing page after they log
in (or bounce them back to the page they originally wanted), and optionally extend
the gate to cover the 403 access-denied and 404 not-found pages too. Developers can
override the final decision per request with `hook_require_login_evaluation_alter()`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and understand that it gates everything immediately).
2. [Configuration](configuration/index.md) — the settings form field by field:
   login path, message, post-login destination, narrowing to specific paths, the
   403/404 options, and the permission that guards it.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Login Requirements**
(`/admin/config/people/login-requirements`), guarded by the **Administer require
login** permission.

## How to use it

1. Enable the module. Be aware this immediately requires login on **every** page —
   so make sure you (or an admin account) can still log in.
2. Open **Configuration → People → Login Requirements** and decide the scope:
   - Leave it as-is to keep the whole site private, or
   - Add a **Request Path** condition to require login only on certain paths (or
     everywhere *except* certain paths).
3. Optionally set a custom login path, a login message, and a post-login
   destination.
4. It's recommended to also enable the **403** and **404** options so those pages
   redirect to login rather than leaking their existence to anonymous visitors.
5. Save. Changes take effect immediately (the module clears caches on save).
