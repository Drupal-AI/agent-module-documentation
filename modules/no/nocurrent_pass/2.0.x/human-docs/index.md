# No Current Password — manual setup guide

**No Current Password** (`nocurrent_pass`) makes Drupal's **"Current password"**
requirement on the user edit form optional. By default, when someone changes their
email address or password, core makes them re-enter their existing password first — and
an administrator editing another account faces the same prompt. That friction is
unnecessary on plenty of sites (staff-managed accounts, low-security internal tools, or
SSO/externally-authenticated users who have no local password to type). This module
lets you switch that requirement off.

It's a small, focused module: it adds a single **"Do not require current password"**
checkbox to core's account settings form. When that box is ticked, the current-password
field is hidden on the user edit and change-password forms and its validation is
skipped, so users and admins can change email or password without the extra step. The
one built-in exception is **user 1** (the superadmin), who always keeps the
current-password field regardless of the setting — a safety measure for the site's most
privileged account.

Worth knowing: the module ships with the requirement **already turned off** — enabling
the module removes the current-password prompt out of the box. If you'd rather keep
core's behaviour and only relax it selectively, just untick the box on the settings
form. There is **no permission, Drush command, or plugin** — only that one config flag —
and the module has no dependencies beyond Drupal core.

This guide is written for a **human** toggling the setting in the admin UI. If you want
terse, token-cheap references for an AI coding agent — the config key, the form-alter
mechanics, and the uid-1 exemption — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the single "Do not require current
   password" checkbox and what it does.

## Where it lives in the admin menu

The module adds no page of its own. Its one setting is a checkbox injected into core's
account settings form at **Configuration → People → Account settings**
(`/admin/config/people/accounts`).
