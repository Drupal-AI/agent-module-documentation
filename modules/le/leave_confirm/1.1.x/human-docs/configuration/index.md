# Configuration

Leave Confirm is managed from a single admin screen where you decide **which
forms** get the unsaved‑changes warning. It starts with sensible defaults, so
configuration is mostly a matter of trimming or extending that list.

## Open the form points list

1. Log in as a user whose role has permission to configure Leave Confirm.
2. Go to **Configuration → User interface → Leave Confirm**
   (`/admin/config/user-interface/leave-confirm-points`).

You will see the list of **form points** — the forms where the leave‑confirmation
dialog is active. On a fresh install this already includes common forms (user
forms, node forms, webform forms).

## Manage the form points

- **Enable / disable per form.** Each point has a toggle. Turn a point off to stop
  warning on that form, or on to protect it. This is the main control: enable the
  warning where it genuinely prevents lost work, and disable it where it would fire
  spuriously.
- **Add a new form point.** To protect a form that is not listed, add a new point
  identified by its **form ID**. (If the warning does not appear on a form you
  added, double‑check the form ID matches the intended form exactly — a mismatched
  ID is the usual cause.)

## Set who can configure it

Access to these settings is role‑based. Grant or restrict the module's permission
from **People → Permissions**, filtered to this module
(`/admin/people/permissions/module/leave_confirm`), so that only the roles you
trust can change which forms are protected.

## Keep the mechanism's limits in mind

When deciding what to protect, remember what the browser prompt can and cannot do:

- The **message text is the browser's** and cannot be customised.
- It **only appears after the user has interacted** with the page, and it **cannot
  fire on programmatic (JavaScript) navigation** — a decoupled or AJAX‑heavy
  interface needs its own handling.
- **Avoid false positives.** A form whose widgets rewrite values on load, or a
  WYSIWYG that normalises whitespace, can make Leave Confirm think there are
  unsaved changes on every exit; a warning that is always wrong gets ignored.
  Disable the point for such forms rather than leaving a misfiring warning in
  place.

## Save

Save your changes on the form points screen. Then test a protected form: edit a
field and attempt to leave — the browser prompt should appear — and confirm a form
you disabled no longer warns.
