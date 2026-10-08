# Leave Confirm — manual setup guide

**Leave Confirm** (`leave_confirm`) warns a user who tries to navigate away from a
form with **unsaved changes**, using the browser's built‑in leave‑confirmation
prompt ("Leave site? Changes you made may not be saved"). Losing work is the kind
of thing that damages trust in a site faster than almost anything else, and
Drupal's long forms make it easy: a node with dozens of fields and several
paragraphs can represent twenty minutes of work held only in the browser, and a
mistaken menu click, a back‑button gesture, or an accidental tab close discards
all of it with no warning and no recovery. Leave Confirm adds the warning.

Rather than applying everywhere, the module works from a configurable list of
**form points** — specific forms where the warning should be active. It
pre‑configures common ones on installation (user forms, node forms, webform
forms), and you can enable or disable each point and add new forms by their form
ID. You manage all of this from a friendly admin screen, and permissions control
which roles may change the settings.

Three things are worth knowing about the browser mechanism this relies on,
because it is more constrained than it looks:

- **Browsers deliberately limit it.** The message wording is the *browser's*, not
  yours — it cannot be customised — and modern browsers only show it if the user
  has actually interacted with the page, precisely to stop the prompt being abused
  to trap people.
- **It cannot fire on programmatic navigation.** A JavaScript‑driven route change
  in a decoupled or AJAX‑heavy interface bypasses it entirely and needs its own
  handling.
- **False positives are what make people turn it off.** A form that reports
  changes because a widget rewrote a value on load, or because a WYSIWYG
  normalised whitespace, warns on *every* exit — and a warning that is always
  wrong gets dismissed reflexively, including the one time it was right. Enable it
  where it genuinely helps.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — manage the form points, toggle them
   per form, add new ones, and set the role permissions.

## Where it lives in the admin menu

Once enabled, manage the form points at **Configuration → User interface → Leave
Confirm** (`/admin/config/user-interface/leave-confirm-points`). Role access to
those settings is controlled from the permissions page
(`/admin/people/permissions/module/leave_confirm`).
