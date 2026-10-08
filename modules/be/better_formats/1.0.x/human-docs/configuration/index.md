# Configuration

Better Formats has two places you work: one small **global setting**, and the
**per-field Text Formats fieldset** that does most of the work. It also adds three
permissions. None of this changes anything until you visit a field and configure
it, so this page walks through each piece.

## The one global setting

Go to **Configuration → Content authoring → Text formats and editors → Settings**
(`/admin/config/content/formats/settings`). You need the **Administer filters**
permission. The form has a single option:

- **Use field default** — off by default. When you turn it on, Better Formats lets
  you set a field's default text format through the field's normal **Default value**
  form (on the field settings page) even when you leave the field's value empty, and
  it uses that format as the default for new content in the field. Leave it off if
  you prefer to control the default purely through the per-field format order
  (below).

## The per-field Text Formats fieldset

This is where Better Formats earns its keep. For any **Text (plain, formatted)**,
**Text (formatted, long)**, or **Text (formatted, long, with summary)** field, open
its configuration form under *Structure → [entity type] → Manage fields → [your
field]*. You will see a new **Text Formats** fieldset with two toggles.

### Limit which formats are allowed

Tick **Limit allowed text formats** and a checklist of your site's text formats
appears. Check only the formats you want authors to be able to choose on this
field. The effect when someone edits the field:

- If **several** formats remain allowed, the format dropdown shows just those.
- If **only one** format remains allowed, the dropdown disappears entirely and that
  format is used silently — a clean single-format editing experience.
- If content was previously saved in a format you have now disallowed, the author is
  prompted to pick one of the allowed formats before saving (existing data is never
  changed behind the scenes).

This is how you get outcomes like "this Body field only offers *Basic HTML*" or "the
comment field is plain text with no selector."

### Override the default order

Tick **Override default order** and you get a drag-and-drop list of the formats.
Reorder them; when a user **creates** new content, the formats appear in your order
and the **top one becomes the default** — unless you turned on *Use field default*
globally, in which case the field's own default value wins. Use this to put your
house-style format first so authors fall into it by default.

Your choices are saved on the field itself (as third-party settings), so they are
included when you export configuration and deploy it to another environment.

## Permissions that hide parts of the editing UI

Better Formats adds three permissions on **People → Permissions**. They are applied
when the field form renders, and they are always **skipped for anyone with the
Administer filters permission** — admins keep the full selector, tips, and links.

- **Hide format tips** — hides the "About text formats" guidelines block that
  normally appears under a text field, for roles that hold this permission.
- **Hide more format tips link** — hides the "More information about text formats"
  link under the field.
- **Hide format selection for [entity type]** — hides the whole format selector for
  that entity type's fields. Better Formats generates **one such permission per
  fieldable entity type** (for example *node*, *comment*, *user*), so you can, say,
  hide the selector for user profiles while keeping it on nodes. Note this only
  hides the selector in the UI; the field still saves with its current format, so
  pair it with a single allowed format for a truly clean result.

## Save

Field settings save with the field form's **Save settings** button; the global
option and permissions save on their own forms. Changes take effect the next time
the affected edit form is loaded.
