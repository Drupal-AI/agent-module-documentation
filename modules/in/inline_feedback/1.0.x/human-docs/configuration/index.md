# Configuration

Inline Feedback has one settings form, and visiting it is a required first step:
until you allow at least one role, nobody can create or read feedback.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Inline Feedback**, or navigate
   directly to `/admin/config/content/inline-feedback`.

The form is short and covers two things: who may use the feature, and how the
on‑page markers look.

## Allowed roles

This is the heart of the module. You choose which roles are permitted to **create**,
**view**, and **delete** feedback. Because the comments are internal editorial
notes — often frank critiques of someone's work — keep this list to editorial
staff (for example *Administrator* and *Editor*). Roles you do not select here see
no markers and cannot add comments, so anonymous and general‑authenticated
visitors stay unaware of the review layer entirely.

Grant these role permissions deliberately: anyone allowed to view feedback can
read every reviewer's notes on a page, and anyone allowed to delete can remove
them.

## Marker appearance

The second part of the form controls the look of the visual marker that pins a
comment to an element. You can set:

- **Background color** — the fill color of the marker/badge that appears on an
  element that has feedback.
- **Text color** — the color of the marker's text or icon.

Pick colors that stand out against your content so reviewers can spot at a glance
which elements already carry comments, without the markers clashing with the
page design.

## Save

Click **Save configuration**. Your changes take effect immediately: reload a node
page as an allowed user and you'll see the markers rendered in your chosen colors,
and **Ctrl+Click** (or long‑press on mobile) will open the feedback dialog on any
visible element.
