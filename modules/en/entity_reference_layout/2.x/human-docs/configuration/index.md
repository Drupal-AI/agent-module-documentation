# Configuration

Configuring ERL is mostly about adding its field to a content type. There is also
a small global settings form, plus per-section options authors set as they build
content.

## Set up the field

1. **Have some paragraph types ready.** ERL arranges paragraphs, so you need at
   least one or two content paragraph types (for example "Text" or "Image").
2. **Create a "section" paragraph type** to act as the layout container — call it
   "Section". Its own fields are optional. (If you enabled the `erl_paragraphs`
   submodule, a ready-made Section type is already there.)
3. On the target content type go to *Structure → Content types → (your type) →
   Manage fields* and **add a field of type "Paragraph with Layout"**, referencing
   Paragraph, with cardinality set to **Unlimited**.
4. On **Manage form display** the field uses the *Entity reference layout* widget
   (the drag-and-drop editor); on **Manage display** the matching formatter
   renders each section through its layout.

> **Tip:** the raw storage option for this field type is intentionally hidden on
> the field-storage form (it works around a known Drupal bug). Always add the
> field using the **"Paragraph with Layout"** type option, not the low-level
> "Reference revisions" option.

## Global settings form

Go to **Configuration → Content authoring → Entity reference layout**
(`/admin/config/content/entity_reference_layout`). You need the **Administer site
configuration** permission. Two checkboxes control label visibility in the
editing widget (both off by default):

- **Show paragraph labels** — shows each paragraph type's label in the widget
  preview, so authors can tell what kind of paragraph each block is.
- **Show layout labels** — shows each section's chosen layout name in the widget.

Turn these on if authors find the widget hard to read without labels.

## Per-section options (set while editing content)

When an author adds or edits a section in the widget, the section form exposes:

- **Container classes** — free-text CSS classes added to the section's wrapper,
  for theming.
- **Background color** — a background color applied to the section wrapper.

These are entered per section as content is built, not on an admin form. The
values are rendered safely (HTML-escaped), but they are still free-form CSS
supplied by whoever can edit the content. If you would rather offer a fixed list
of choices instead of a free-text box, enable the **ERL Layouts** submodule and
use its "select from a list" or "force" modes.

## Permission

One permission, **Manage entity reference layout sections**, controls whether the
*Add Section* buttons appear in the widget. Grant it at *People → Permissions* to
the content-author roles that should be able to build layout sections. It is not a
"restrict access" permission, so treat it as an editorial capability rather than a
security boundary.
