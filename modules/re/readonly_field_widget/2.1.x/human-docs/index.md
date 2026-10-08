# Read-only Field Widget — manual setup guide

**Read-only Field Widget** (`readonly_field_widget`) gives you a field widget
that, instead of an editable input box, shows the field's *formatted* value
right on the entity edit form. In other words, when an editor opens a node (or
any other entity) to edit it, the field appears as read-only text or markup —
exactly the way it would look when viewing the entity — rather than as a
text box, checkbox, or upload control.

This is handy for values that are set somewhere other than the edit form: a
UUID or external ID, a "last updated" timestamp, a computed price, a field
populated by a migration or a background sync, or a reference an editor should
see for context but not change. The widget works on virtually every field type,
because it automatically becomes available for any field that has at least one
display formatter.

You choose *which* formatter renders the value (for example the `image`
formatter for an image field, or the default text formatter for a body field),
along with a few display options — where the label sits, whether the field's
help text is repeated underneath, and whether validation errors still show. The
widget also respects view access: a value is shown to users who can view the
field even if they can't edit it, and hidden entirely from users who can't view
it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no central settings page for this module — it has no configuration
route of its own. You turn it on one field at a time, on each bundle's **Manage
form display** page (for example, for the Article content type:
**Structure → Content types → Article → Manage form display**, or
`/admin/structure/types/manage/article/form-display`).

## How to use it

1. Go to the bundle's **Manage form display** page for the form mode you want to
   affect (the default form mode, or any custom one).
2. Find the field you want to lock down and change its **Widget** dropdown to
   **Readonly**.
3. Click the gear/cog icon on that field's row to open the widget settings.
4. Choose your options:
   - **Format** — the formatter used to render the read-only value. Pick one
     that suits the field type (for example an image style for an image field,
     or a date format for a date field). Any settings that formatter offers
     appear here too.
   - **Label** — where the field label appears: above, inline, hidden, or
     visually hidden.
   - **Show Description** — repeat the field's configured help text under the
     read-only value.
   - **Error Validation** — keep flagging validation errors on the field even
     though it isn't directly editable (a read-only widget normally suppresses
     them).
5. Click **Update**, then **Save**.

A couple of things worth knowing: the widget renders nothing when the field is
empty, so it won't appear on a brand-new entity that has no value yet (set a
default value if you need it to show). And it deliberately refuses to act as the
*default value* widget on a field's own configuration form — there's nothing to
edit there — so pick a normal editable widget in that spot.
