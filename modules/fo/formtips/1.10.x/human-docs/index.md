# Form Tips — manual setup guide

**Form Tips** (`formtips`) declutters your forms by moving each field's
description text into a small tooltip that appears next to the field on hover (or
on click), instead of printing every description inline. Long, busy forms — a
content-creation form, a checkout, a settings page full of help text — become much
easier to scan, while the help is still one interaction away when someone needs
it.

It is a small, purely client-side enhancement. It has no plugins, services, or
entities: on every non-admin page it attaches a little JavaScript that rewrites
Drupal's form descriptions into tooltips, driven by a handful of settings you
control from one form. There is nothing to place and no per-form code to write —
once enabled and configured, it applies site-wide.

The behavior is tunable: tooltips can open on hover or on click (click is
touch-friendly), you can cap their width, exclude specific fields, limit Form Tips
to certain themes, and fine-tune the hover timing so tooltips don't flicker. If
you also enable the optional [`form_placeholder`](https://www.drupal.org/project/form_placeholder)
module, Form Tips will cooperate with it so descriptions can additionally become
input placeholders.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The settings form sits at **Configuration → User interface → Form Tips**
(`/admin/config/user-interface/formtips`) and requires the *Administer formtips*
permission. Form Tips starts working on non-admin forms the moment it is enabled;
the form only tunes how the tooltips look and behave.

## How to use it

Enable the module, then open the settings form to adjust any of the following.
Every option is optional — the defaults produce working click-to-open tooltips.

- **Trigger action** — whether tooltips open on **click** (the default,
  touch-friendly) or on **hover**.
- **Max width** — the maximum width of the tooltip box, as any CSS length (default
  `500px`). Lower it (for example `320px`) so long descriptions wrap neatly.
- **Selectors to exclude** — a newline-separated list of CSS/jQuery selectors
  whose fields should keep their inline descriptions instead of becoming tooltips.
  Useful for a wizard step or a field where the help must stay visible.
- **Themes** — an optional allow-list of theme machine names. Leave it empty to
  apply Form Tips everywhere, or list a single theme (for example your front-end
  theme) to leave others, such as the admin theme, untouched.
- **Hover intent settings** — only shown when the trigger is *hover*. These knobs
  (interval, sensitivity, and timeout, plus a switch to use the bundled
  hoverIntent plugin) tune how deliberately the user must pause on a field before
  its tooltip appears, and how long it lingers, so tooltips don't flicker on fast
  mouse movement.

Click **Save configuration** and the change takes effect on the next page load.
The settings are stored as ordinary configuration (`formtips.settings`), so you
can also read or set them with `drush cget formtips.settings` /
`drush cset formtips.settings …` and deploy them between environments.
