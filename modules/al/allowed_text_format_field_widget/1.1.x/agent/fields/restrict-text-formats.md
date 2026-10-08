<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Restrict which text formats a formatted field offers

## When this applies
The field is a **`text_long`** ("Text (formatted, long)") field and you want its format selector to
offer only a chosen subset of text formats — optionally different per form display. Does **not**
apply to `text_with_summary` (the standard Body field) or single-line `text`; the widget is not
offered for those field types.

## Steps (UI)
1. Enable the module (`drush en allowed_text_format_field_widget`). It pulls in core `field` and
   `filter`, both normally already on.
2. Go to the entity's **Manage form display** (e.g. `admin/structure/types/manage/<bundle>/form-display`).
3. For the `text_long` field, change the **Widget** to **"Allowed Text Format"**.
4. Click the widget's gear/settings. Under **Available formats**, tick the formats this field
   should offer. Leave everything unticked to mean "offer all formats" (the default).
5. Save. The widget's summary shows `Allowed formats : <labels>`.

## What the settings do (source of truth: `AllowedTextFormatFieldWidget.php`)
- Setting key: `allowed_format`, a `checkboxes` element listing every text format's label keyed by
  machine name.
- On render, the widget sets the text area's `#allowed_formats` to the machine names of the ticked
  formats. An **empty** selection is treated as **all** formats, not "none".

## The important guarantee
The list an editor actually sees is `your ticked formats ∩ formats that editor may use`. Core's
`TextFormat` element re-intersects `#allowed_formats` with `getFormatsForAccount($user)`, so:
- You can never *grant* a format a user lacks the `use text format X` permission for by ticking it.
- A user who has access to **none** of your ticked formats gets a **disabled** field with an
  access-denied notice (core's fallback) — plan your allowlist so intended editors have at least one.

## Scope limits to remember
- The restriction is on this **form display's widget only**. A second form display, a migration,
  JSON:API, REST, or a webform can still write any format the user is permitted to use.
- This is editorial/content-model shaping, not a security control. To actually forbid a format, use
  the format's **role permissions** (`use text format X`), not this widget.
