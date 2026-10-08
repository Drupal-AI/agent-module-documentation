# No Request New Password — manual setup guide

**No Request New Password** (`noreqnewpass`) does one small, focused thing: it
removes Drupal's "Request new password" (password reset) link and disables the
password-reset flow. When enabled and switched on, it hides the reset link from the
user login block and the user pages, and it blocks the `/user/password` route so
nobody can request a reset there.

Why would you want that? Two common cases. On **sandbox or demo sites**, you often
don't want test users resetting the shared account passwords. And when
authentication is handled by a **third-party system** — LDAP, SSO, and the like —
Drupal's own password-reset flow is meaningless or even confusing, so it's cleaner
to remove it entirely.

The module is inert out of the box: after enabling it you must tick a single
checkbox on its settings form to actually turn the behavior on. It has **no
dependencies** and **no submodules**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the single checkbox that switches the
   behavior on.

## Where it lives in the admin menu

The settings form is at **Configuration → People → No Request New Password**
(`/admin/config/people/noreqnewpass`, route `noreqnewpass.settings_form`), gated by
the **Administer noreqnewpass** permission.
