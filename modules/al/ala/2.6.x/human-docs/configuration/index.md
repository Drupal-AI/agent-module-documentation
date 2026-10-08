# Configuration

Advanced Link Attributes has one small **site‑wide** settings form. It holds two
things that are shared across every Advanced Link Attributes field on the site:
the reusable list of link classes, and the list of extra attribute names editors
can fill in. Everything else — which controls appear, how the link is rendered —
is set *per field* on the field's *Manage form display* and *Manage display* tabs
(see the [main guide](../index.md)), not here.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default — this module adds no permission of its own).
2. Go to **Configuration → Content authoring → Advanced Link Attributes**, or
   navigate directly to `/admin/config/ala`.

## The form fields

- **Define possibles classes** — the site‑wide "Global List" of allowed link
  classes. Enter **one class per line** in the form `key|label`:

  ```
  btn btn-default|Default button
  btn btn-primary|Primary button
  ```

  The **key** (before the `|`) is the class string actually placed on the link —
  separate multiple classes with a space, as in `btn btn-primary`. The **label**
  (after the `|`) is the friendly name editors see in the dropdown. If you leave
  out the `|`, the whole line is used as both the class and its label. Any Link
  field whose widget is set to **Global List** class mode offers editors exactly
  these choices.

- **Extra attributes** — a **comma‑separated** list of HTML attribute *names*
  (for example `title,data-test`). When a field's widget has "Enable extra
  attributes" turned on, each name here becomes an editable text field on the link
  edit form, so editors can fill in that attribute's value.

The install default is an empty class list.

## Save

Click **Save configuration**. The global list is immediately available to any
field widget set to use it. Remember that turning the class selector, icon, color,
roles, or extra‑attribute controls on or off for a specific field happens in that
field's widget settings under **Manage form display**, and how the link is
displayed is controlled by the **Advanced Link Attributes** formatter under
**Manage display**.
