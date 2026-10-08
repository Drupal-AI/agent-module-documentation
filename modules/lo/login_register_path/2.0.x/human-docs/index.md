# Login Register Path — manual setup guide

**Login Register Path** (`login_register_path`) lets you change the **URLs of the
login and register pages**. Instead of the default `/user/login` and
`/user/register`, you can serve those forms at custom, friendlier paths — for
example `/signin` and `/join` — for branding or a little extra polish.

It's a small, focused module. The forms themselves are unchanged: they still
enforce Drupal's normal authentication and registration logic and access rules.
This is a **path change, not an authentication change**.

Worth being clear on one point: changing the path is **not a security control**.
The custom path is about presentation and branding, not obscurity — don't rely on
a renamed login URL to hide the login form, since the default paths may still be
reachable or discoverable. Login Register Path has no access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the custom login and register
   paths.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Login Register Path**
(`/admin/config/user-interface/login-register-path`), gated by the core
**Administer site configuration** permission.
