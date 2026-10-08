# Configuration

There is no global settings page. You turn Autofill on per field, in that field's
widget settings on **Manage form display**.

## Enable Autofill on a field

1. Go to the bundle's **Manage form display** — for a content type that is
   **Structure → Content types → (type) → Manage form display**
   (`/admin/structure/types/manage/<bundle>/form-display`).
2. The target field must be a **plain text (`string`)** field. Click the **cog
   (settings)** icon next to it to open its widget settings.
3. Tick **Enable Autofill from another field**. (This option is disabled if the
   form has no other eligible `string` field to copy from.)
4. Choose the **Autofill source field** from the dropdown — the field whose value
   should be copied into this one.
5. Click **Update**, then **Save**.

The form-display summary for the field then shows a line like **"Autofill from:
&lt;source field&gt;"** so you can see the wiring at a glance. You can repeat this
for several target fields on the same form, each pointing at its own source.

## What happens on the edit form

Once configured, a small JavaScript behavior mirrors the source field into the
target as the editor types:

- While the target is still untouched, each keystroke in the source is copied into
  the target (and dependent behaviors, like the maxlength character counter,
  refresh).
- As soon as the editor types into the **target** field, mirroring stops for that
  field — manual edits are never overwritten.
- If the target already holds a value that differs from the source when the form
  loads (for example when editing existing content), Autofill leaves it alone.

## Limitations

- **Single-value `string` fields only.** Multi-value fields and non-string widgets
  (formatted text, numbers, references, and so on) are not wired up.
- The copy is **one-directional** (source → target) and is designed for initial
  data entry, not two-way sync.
