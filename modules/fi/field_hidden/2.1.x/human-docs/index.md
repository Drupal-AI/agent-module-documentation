# Field Hidden — manual setup guide

**Field Hidden** (`field_hidden`) gives you form widgets that render a field as
an HTML `<input type="hidden">`. The value is still part of the form and is saved
normally when the entity is submitted — it just isn't shown to the person editing
the content, and they can't type into it. This is handy when a field should carry
a default, computed, or programmatically set value that editors shouldn't touch:
a legacy identifier on migrated content, an internal sort number, a fixed rate,
or a token your own JavaScript fills in before submit.

It is important to understand how this differs from Drupal's built‑in
**"‑ Hidden ‑"** choice on *Manage form display*. Core's "‑ Hidden ‑" removes the
field from the form entirely, so nothing is submitted and a default value is never
written on that form. Field Hidden instead keeps the field in the form as a hidden
input, so its value round‑trips through save. Use this module when you need the
value to survive submission without a visible widget.

The module works the moment you enable it — there is no settings page, no
permissions, and no dependencies beyond Drupal core. You "configure" it entirely
per field, by picking one of its three **"Hidden field"** widgets on a bundle's
*Manage form display* page. The three widgets cover the plain‑text and number
field types: one for `string` (Text, plain), one for `string_long` (Text, plain,
long), and one for the numeric types (`integer`, `decimal`, `float`). Formatted
(rich) text is deliberately not supported, because core's text‑processing can't be
represented in a hidden input.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Field Hidden adds no pages of its own. You reach it wherever you configure a
bundle's form, at **Structure → Content types → (your type) → Manage form
display** — for example `/admin/structure/types/manage/article/form-display`.
The same *Manage form display* tab exists for other entity types too (users,
taxonomy terms, media, and so on).

## How to use it

1. Go to the bundle's **Manage form display** page.
2. Find the field you want to hide (it must be a plain‑text or number field).
3. In that field's **Widget** column, pick **Hidden field** from the drop‑down.
4. Click **Save**.

From then on, that field is rendered as `<input type="hidden">` on the entity's
add/edit forms. Its default or programmatically set value is submitted and saved
on every form submission, but no editable widget appears. One deliberate
exception: on the field's own settings page (where you enter a default value) the
input stays visible, so you can still type the default there.
