# Configuration

Field Label Long Text is controlled from a single settings form. There you
decide whether field labels use a text field with a raised character limit, or a
textarea for longer multi‑line labels.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration** and open the module's settings form — its route is
   `field_label_long_text.admin_settings`, reachable at a path such as
   `/admin/config/field_label_long_text`.

## Choose the label input type

The form lets you pick how the **field label** input behaves on field edit
forms:

- **Text field** — keep the label as a single‑line input, but with an
  **increased character limit** (see the next setting). Choose this when you just
  need labels longer than core's 128‑character default but still on one line.
- **Textarea** — switch the label input to a multi‑line textarea, giving you room
  to write and read a long, question‑length label comfortably. Choose this for
  survey‑style or full‑sentence labels.

## Character limit

When the label input is a **text field**, you can set the **maximum character
length** for labels — raising it above Drupal's default of 128 to whatever length
your longest label needs. Set it high enough to accommodate your longest planned
label.

## Save

Click **Save configuration**. Your choice applies to the field label input on
field edit forms from that point on — edit any field to see the label field
rendered as your chosen input type with the character limit you set.
