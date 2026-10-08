# Lowercase Username — manual setup guide

**Lowercase Username** (`lowercase_username`) enforces a lowercase‑only username
policy on your site. It adds a validation check to the user account forms
(registration and edit) that **rejects** any username containing a character
outside an allowed set — so you can keep account names tidy and consistent
(`johndoe` rather than `JohnDoe`), which makes lookups, URLs, and support cleaner.

The allowed set always starts with the lowercase letters `a–z`, and you decide
which extra characters to permit: **digits**, **dots**, **underscores**, and
**hyphens** are each individual toggles. If a submitted name contains anything
outside the resulting set — including any uppercase letter — the form fails with
*"The username contains an illegal character."* You can also set custom help text
that appears under the username field to tell people what's allowed.

A reassuring detail about how it works: the module **validates and rejects**, it
does **not** silently rewrite names. That means it never renames an existing
account and can't accidentally collapse two different accounts (`JohnDoe` and
`johndoe`) into the same identity — a name that would collide is simply rejected,
and Drupal core's existing case‑insensitive uniqueness check stays in force. There
is no account‑takeover or collision risk introduced here.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which extra characters to
   allow and set the help text.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Lowercase Username**
(`/admin/config/user-interface/lowercase_username`) and requires the
**Administer lowercase username** permission. The policy itself applies wherever a
username is entered — the registration form and the user edit form.
