# Configuration

Field Protect is configured in two places: the **per-field protection** you set on
Manage form display, and a small **admin page** with a "Forget" action.

## Protect a field

1. Go to **Structure → Content types → *(your type)* → Manage form display**.
2. Click the **gear icon** on the widget you want to guard.
3. Tick **Field Protect: Protect from accidental changes** and enter a warning
   **message** — the text shown to the editor when they go to unlock the field.
   (Both the on/off flag and the message are stored as third-party settings on the
   widget.)
4. **Update** the widget, then **Save** the form display.

On that bundle's **edit** form (creation forms are deliberately exempt) the widget
now renders locked, with an **"Unlock field"** button. When the editor clicks it and
confirms the warning, the module's JavaScript reveals the input for editing. A lock
summary also appears next to the widget in the form-display UI so you can see at a
glance which fields are protected. The warning text is filtered to plain text, so you
can't accidentally (or maliciously) inject markup through it.

## Remembering unlocks

If an editor holds the **Remember field unlock** permission, their decision to unlock
a field can be remembered so they don't have to unlock it every time. When they
unlock, the browser sends a request to `/field-protect/remember` and the module
records that the field is unlocked for them.

## The Forget action (admin page)

1. Log in as a user with **Administer site configuration**.
2. Go to **Configuration → Content authoring → Field Protect**
   (`/admin/config/content/field-protect`).
3. Click **Forget** to clear **all** remembered unlocks site-wide. Every protected
   field then shows locked again for everyone the next time they open an edit form —
   useful after a policy change when you want editors to re-read the warnings.

## Important: this is not access control

Field Protect only changes the widget UI. It does **not** restrict who may view or
save a field on the server side — it implements no `hook_entity_field_access`. A user
who can already save the field can still save it via the API or by manipulating the
form, regardless of the lock. Treat Field Protect as an ergonomics feature that
prevents accidental edits; for genuine field-level access control, use a module that
implements field access (for example Field Permissions).
