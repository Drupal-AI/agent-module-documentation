# Media Library Edit — manual setup guide

**Media Library Edit** (`media_library_edit`) adds a per-item **Edit** button to
Drupal's core Media Library form widget. Core's media library widget — the one you
get on entity-reference-to-media fields — lets editors add, remove, and reorder
media, but it has no way to *edit* an item that is already selected. This small
module fills that gap: each selected media item gets a pencil edit link that opens
the media entity's edit form in an AJAX modal, so editors can fix alt text, a
caption, a title, or any other field without leaving the content form they are
working on.

The module works by extending the core `media_library_widget` through third-party
widget settings and field-widget alter hooks — it has **no admin page or routes of
its own**. You turn it on per widget, on a form display, where it adds two options:
a **Show edit button** checkbox and a **Form mode** select that chooses which media
form mode the edit modal renders. That means you can expose a trimmed-down "quick
edit" form mode in the widget while keeping the full media form elsewhere, and you
can enable the button only on the widgets where editors actually need it.

Access is respected per item: the edit button only appears for media the current
user has permission to update, and only when the media type defines an edit form.
When an editor saves in the modal, the dialog closes and the item's thumbnail
refreshes in place without a full page reload. The delete action is hidden inside
the quick-edit modal to prevent accidental deletion.

Media Library Edit is dependency-light — it needs only Drupal core's Media Library
(9.2, 10, or 11) — and adds no permissions of its own; visibility is governed by
core media update access. Its settings are stored as configuration on the form
display, so they export and deploy with `drush config:export`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is **no settings page**. You enable the edit button per widget under **Manage
form display** for whichever entity has a media-reference field — for example
**Structure → Content types → Article → Manage form display**
(`/admin/structure/types/manage/article/form-display`).

## How to use it

To turn on the edit button for a media field:

1. Go to the entity's **Manage form display** (for example
   `/admin/structure/types/manage/article/form-display`).
2. Find a field that uses the **Media library** widget, and open that widget's
   settings by clicking its gear icon.
3. Two extra settings appear (they only show for the Media library widget):
   - **Show edit button** — tick this to add the per-item edit link.
   - **Form mode** — choose which media form mode the edit modal should render.
     Use the default media form mode, or pick a dedicated "quick edit" form mode you
     have created to expose just the fields editors should touch. This option is
     only shown once **Show edit button** is checked.
4. Save the form display. The widget's settings summary will now show that the edit
   button is on and which form mode it uses.

From then on, whenever that widget shows selected media, each item the current user
can update displays an edit link. Clicking it opens the media entity's edit form in
a modal; saving closes the modal and refreshes the item in place. Because the
setting lives on the form display's configuration, you can export it and deploy the
same behavior to other environments. Enable it only on the widgets where it helps —
for instance on a gallery field's widget but not everywhere — and use bundle-specific
form modes to tailor exactly which fields the modal shows.
