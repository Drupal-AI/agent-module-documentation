# Popup After Login — manual setup guide

**Popup After Login** (`popup_after_login`) shows a configurable popup message to
users **after they log in**. It is handy for terms-and-conditions reminders, welcome
notes, or role-specific announcements that you want people to see at the start of a
session. The popup is rendered with the **SweetAlert2** library.

You can run two kinds of popup, independently or together:

1. A **first-login popup** — a welcome message shown only **once**, the first time a
   user logs in.
2. An **always popup** — a message shown **every** time the user logs in.

Both are targeted by **role**: you pick which roles should see each message, and you
write the title and full-HTML message body for each. Leaving a title blank simply
disables that popup. When a user logs in, a small piece of JavaScript fetches the
appropriate message from a JSON endpoint and displays it; if the user is not in a
targeted role, nothing shows.

The popup content is entirely admin-configured (full HTML) and no untrusted user
input is reflected, so the security surface is minimal. Note, though, that this
module is **not covered by Drupal's security advisory policy**
(`security_advisory_coverage: not-covered`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the SweetAlert2
   dependency with Composer, and enable it.
2. [Configuration](configuration/index.md) — choose target roles and write the
   first-login and always-on messages.

## Where it lives in the admin menu

The settings form is at **`/admin/config/popup_after_login`**, behind the
**Administer site configuration** permission.
