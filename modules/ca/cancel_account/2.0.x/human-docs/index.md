# Cancel Account Separate Form — manual setup guide

**Cancel Account Separate Form** (`cancel_account`) gives you a dedicated
"delete my account" form, separate from Drupal's core user‑edit page. Use it when
you want a clean, embeddable self‑service form that lets a signed‑in user cancel
(delete) their own account, confirming with their password first. It's a good fit
for GDPR "right to erasure" self‑service flows.

The form is built to be safe by design. It only shows the cancellation fields when
the current user is the account being cancelled (and is not anonymous), and the
superadmin (user 1) is explicitly excluded. A user can only ever cancel their **own**
account — the submit handler always acts on the logged‑in user, never on someone
else, even if an account id is passed in. It requires the user's current password
(checked with Drupal's timing‑safe password service) plus a confirmation checkbox,
and, being a standard Drupal form, it is CSRF‑protected by the form token.

Which cancellation method runs (block, delete, delete‑and‑anonymise, etc.) follows
your site's user settings unless the user is allowed to choose. After cancellation
the user is sent to the front page.

This module has **no settings page and declares no routes of its own** — it provides
the form for host code (a block or a custom page) to place. So the "setup" is
enabling the module, granting the right core permissions, and embedding the form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, enable it, grant the
   cancellation permissions, and embed the form.

## How to use it

1. Grant the core **Cancel account** permission (`cancel account`) to the roles that
   should be able to delete their own account.
2. Optionally grant **Select method for cancelling account**
   (`select account cancellation method`) so a user can pick how their account is
   cancelled; without it, the site default (`user.settings: cancel_method`) is used.
3. Place the form (id `cancel_account_form`, provided by the module's
   `CancelAccountForm`) where users should reach it — for example via a block or a
   custom route/page. The form accepts an optional account‑id argument, but that only
   affects display gating; the account actually cancelled is always the current user.

Whether the user is notified on cancellation follows your site's
`user.settings: notify.status_canceled` setting. Uninstalling the module creates no
leftover config entities.
