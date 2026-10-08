# Toastify — manual setup guide

**Toastify** (`toastify`) restyles Drupal's status, warning, and error messages as
animated "toast" pop‑ups instead of the default inline message boxes. Toasts float
above the page (so they don't push content down), slide in and out, and can
auto‑dismiss after a set time — a friendlier, less disruptive way to give feedback
after a form submission or an AJAX action.

It works for both server‑rendered messages and messages added by JavaScript, so
anything Drupal would normally show in its message area becomes a toast. You don't
have to change any code: keep adding messages the normal way (for example
`\Drupal::messenger()->addStatus(...)`), and Toastify handles the rest.

Toasts are only shown to users whose role has the **Show toastify messages**
permission; everyone else sees Drupal's normal messages, so you can roll it out to
just some audiences. It also detects the **Gin** admin theme and matches its
styling automatically. It has no dependencies of its own and works on Drupal 8
through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The settings form sits at **Configuration → User interface → Toastify**
(`/admin/config/user-interface/toastify`), gated by the **Administer toastify
configuration** permission.

## How to use it

### 1. Grant the permission

At **People → Permissions**, give **Show toastify messages** to the roles that
should see toasts (often the same audience as *access content*). Without this
permission a user just sees the standard Drupal messages.

### 2. Choose where toasts appear

On the settings form, the **Enable for** section has two toggles — **admin theme**
and **frontend theme** — both on by default. Turn one off to keep standard messages
in that context. Turning both off disables toasts everywhere (another quick way to
switch the feature off).

### 3. Tune the look and behaviour per message type

The form has an identical set of options for each of the three message types —
**status**, **warning**, and **error** — so you can style them differently to
reinforce severity:

- **Duration** — milliseconds before the toast auto‑dismisses (default 5000).
- **Gravity** — anchor the toast to the **top** or **bottom** of the screen.
- **Position** — **left**, **right**, or **center**.
- **Offset X / Offset Y** — nudge the toast away from the edge, useful for clearing
  a fixed header or the admin toolbar.
- **Close button** — show a manual close (×) so a message stays until dismissed.
- **Colors** — gradient start colour, gradient end colour, and progress‑bar colour,
  plus a **gradient direction**. If the [jQuery Colorpicker](https://www.drupal.org/project/jquery_colorpicker)
  module is installed you get a colour‑picker widget here; otherwise the browser's
  native colour input is used.

> **Using the Gin admin theme?** Toastify matches Gin automatically and hides the
> colour fields — Gin controls those, so any stored colour values are ignored while
> Gin is active.

### 4. Trigger a toast

Just add a Drupal message the usual way and, when Toastify is active for that user
and theme, it appears as a toast:

```php
\Drupal::messenger()->addStatus(t('Saved.'));   // shown as a green toast
```
