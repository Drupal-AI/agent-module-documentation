# Configuration

There's no admin settings page for Table of Contents. Setting it up is two steps: enable it on a
field, then place the block it generates.

## 1. Enable the TOC on a field

1. Go to the **Manage fields** screen for the content type (or other fieldable entity) that has
   your long‑text field — for a content type that's **Structure → Content types → [type] → Manage
   fields**.
2. Edit the field you want a table of contents for. It must be a **long text** field — either a
   *Text (formatted, long)* (`text_long`) or *Text (formatted, long, with summary)*
   (`text_with_summary`) field, such as the standard **Body** field.
3. On the field's edit form you'll find a **Flexible Table of Contents** section with two settings:
   - **Enable the TOC block for this field** — tick this to switch the feature on for the field.
   - **CSS selector** — which heading elements become entries in the table of contents. The default
     is `h2`; change it to target a different level (for example `h3`) or any other selector that
     matches the headings in your content.
4. Save the field. Toggling the checkbox rebuilds Drupal's blocks, so the new block (below) appears
   or disappears accordingly.

## 2. Place the table‑of‑contents block

Enabling the setting creates a dedicated block for that specific field:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region where you want the table of contents (a sidebar is common), click **Place block**.
3. Look under the **Table of Contents** category for a block named **TOC for: [entity] › [bundle] ›
   [field]** — one exists for each field where you enabled the setting. Select it.
4. Configure its visibility as you would any block (for example, restrict it to the relevant content
   type), and save.

Because the block needs the entity and language context to read the field, place it where those are
available — typically on the node view of the content type that has the field.

## What the reader sees

On a rendered page, the block outputs a linked list of the matching headings. Clicking an entry
jumps to that heading. Headings that already have an `id` are linked directly; headings without one
get an id generated automatically (a small bundled JavaScript assigns the matching id to the heading
in the page so the jump works). The block automatically hides when the field is empty, and it only
appears to users who are allowed to view the host content and that field.

## Tips

- **Multiple tables of contents:** enable the setting on more than one field, or on the same field
  across different content types, to get separate TOC blocks — one per field/bundle.
- **Different heading levels:** if your authors structure content with `h3` sub‑headings, set the
  selector to `h3` (or a combined selector) so those appear too.
- **CKEditor content:** the TOC is built from the rendered field markup, so headings authored in
  CKEditor are picked up just like hand‑written ones.
