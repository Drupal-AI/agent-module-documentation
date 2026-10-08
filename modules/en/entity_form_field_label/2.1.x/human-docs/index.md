# Entity Form Field Label — manual setup guide

**Entity Form Field Label** (`entity_form_field_label`) lets you override a
field's **displayed label per form mode and per display mode** — so the same
field can read "Documents" on one form and "Attachments" on another, or show a
friendly marketing label on a public view mode and a technical one on an admin
form, all **without changing the field's global label** or its machine name.

It works by adding a **Rewrite label** checkbox and a **New label** textfield to
the settings of every field **widget** (on *Manage form display*) and every field
**formatter** (on *Manage display*). Tick the box, type a new label, and that
label replaces the field's title in that mode. Leave the new label empty and the
label is hidden entirely. It even handles composite fields like Date Range: you
can relabel each sub‑element separately by separating the labels with `||` (for
example `Event Start Date||Event End Date`).

The module depends only on core's **Field** module and works with Display Modes,
inline entity forms, and Layout Builder‑managed displays. It has **no
configuration page, no permissions, and no submodules** — the label overrides are
stored as third‑party settings inside the entity form/view display config, so
they export and deploy along with your display configuration. It works on Drupal
9.2, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the stored
setting keys and the hooks that apply the override — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no page of the module's own. You set the overrides on each field's
settings under **Structure → (entity type) → Manage form display** (for form
labels) or **Manage display** (for display labels).

## How to use it

To give a field a different label in a particular mode:

1. Go to **Manage form display** (for a label on an edit form) or **Manage
   display** (for a label on output) of the bundle and mode you want — for
   example `/admin/structure/types/manage/article/form-display`.
2. Click the gear/settings icon for the field.
3. Tick **Rewrite label**. A **New label** field appears.
4. Enter the new label — or leave it empty to remove the label entirely.
5. Click **Update**, then **Save**.

Repeat on each form or display mode to give the field different labels per mode.
For a composite field (Date Range, name, and similar), enter one label per
sub‑element separated by `||`. A "Label alterations: …" line is added to the
field's settings summary so you can see at a glance which fields are relabeled.

Note the module's own README mentions that a few unusual field types may not be
supported out of the box and could need a small code tweak. The underlying field
machine name and global label are always left untouched.
