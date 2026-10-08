<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hotkeys for Save — manual setup guide

**Hotkeys for Save** (`hotkeys_for_save`) lets you save a Drupal form by pressing
**Ctrl+S** (Windows/Linux) or **Cmd+S** (Mac) instead of scrolling down to click
the Save button — and it stops the browser's own "Save As" dialog from popping up
when you do. It is a small productivity boost for editors and admins who save
constantly.

It is almost entirely a bit of JavaScript. When you press the shortcut, it finds
the right button on the page and clicks it. It is smart about which button: it
prefers a "Save and continue" / wizard "Next" button if one is present, and
otherwise falls back to the plain Save/Submit button — including the awkwardly
generated ids used by admin themes like **Gin**. It also works while your cursor is
inside a CKEditor rich-text field, which would otherwise swallow the keystroke.

The shortcut only turns on for users who have the **Use hotkeys for save**
permission. That permission is granted to the administrator role when you install
the module, and it is intentionally not for everyone — because it suppresses the
browser's native Ctrl+S behavior, the module recommends you do not give it to
ordinary users. There is no settings form and nothing else to configure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no configuration page. The only thing to manage is the **Use hotkeys for
save** permission, described below.

## Where it lives in the admin menu

There is no settings page. You control who gets the shortcut at **People →
Permissions** (`/admin/people/permissions`), under the **Use hotkeys for save**
permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). The administrator
   role gets the permission automatically.
2. To give the shortcut to another role, tick **Use hotkeys for save** for that
   role at **People → Permissions** — or run
   `drush role:perm:add editor 'use hotkeys for save'`.
3. On any form, press **Ctrl+S** (or **Cmd+S** on a Mac) to trigger Save. The
   browser's "Save As" dialog is suppressed.

> **A word of caution:** this permission overrides the browser's built-in Ctrl+S,
> so grant it only to trusted editors and admins, not to ordinary users.
