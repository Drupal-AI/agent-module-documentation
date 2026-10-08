# Configuration — define and use link attributes

Menu Link Attributes has one job to set up: decide **which** attributes editors can
put on a menu link. You do that on the **Menu link attributes** configuration page
by editing a small YAML document. After you save it, those attributes appear as
fields in an **Attributes** section on every menu-link edit form.

This page walks through both halves: first defining the available attributes, then
setting them on an actual menu link.

## Step 1 — Open the configuration page

1. Go to **Configuration → Menu Link Attributes**
   (`/admin/config/menu_link_attributes/config`). You can also reach it as the
   **Available attributes** tab under **Structure → Menus**.
2. You will see a **Configuration** textarea containing YAML. Out of the box it
   defines three attributes — `container_class`, `class`, and `target`:

![The Menu link attributes configuration page with the default YAML](../images/settings.png)

## Step 2 — Edit the attribute definition

The textarea holds a single YAML document. Under a top-level `attributes:` key you
list one entry per attribute. The **key** you use (for example `class` or `target`)
is the actual HTML attribute name that will be written to the link. Every sub-key is
optional:

```yaml
attributes:
  container_class:
    label: 'Container class(es)'
    description: 'CSS class for the menu list item (<li>). Separate multiple classes by space.'
  class:
    label: 'Link class(es)'
    description: 'CSS class for the link (<a href>). Separate multiple classes by space.'
  target:
    label: 'Link target'
    description: ''
    options:
      _blank: 'New window (_blank)'
      _self: 'Same window (_self)'
    default_value: ''
```

What each sub-key does:

- **`label`** — the field label shown on the menu-link form. If you leave it out,
  the module builds a label from the attribute name.
- **`description`** — help text shown under the field to guide editors.
- **`type`** — the kind of form element to render. The default is a plain
  `textfield`. Other useful values are `select`, `checkboxes`, `radios`, and
  `managed_file`. If you provide `options` but no `type`, the field automatically
  becomes a select list.
- **`options`** — a map of stored value → human label, used by `select`,
  `checkboxes`, and `radios`. In the `target` example above, editors pick between
  *New window (_blank)* and *Same window (_self)*.
- **`default_value`** — a value pre-filled on new menu links.

To offer a new attribute, add another entry. For example, to let editors set an
`id` and a `rel` on links, add:

```yaml
  id:
    label: 'ID'
    description: 'Unique HTML id for anchor or JavaScript targeting.'
  rel:
    label: 'Rel'
    description: 'Link relationship, e.g. nofollow or noopener.'
```

### Container attributes vs link attributes

Most attributes are written to the link's `<a>` element. If you want an attribute to
apply to the menu item's `<li>` container instead, name it with a `container_`
prefix — which is exactly what the built-in `container_class` does. That is how you
add a class to the wrapper around a link (useful for styling dropdown or mega-menu
containers) rather than to the link itself.

## Step 3 — Save

Click **Save configuration**. Your attribute definitions take effect immediately for
every menu-link form on the site.

## Step 4 — Set attributes on a menu link

With the definitions saved, editors can now use them:

1. Go to **Structure → Menus** (`/admin/structure/menu`).
2. Choose a menu (for example *Main navigation*) and click **Edit menu**, or click
   **+ Add link** to create a new link.
3. On any menu link, click **Edit**.
4. Open the **Attributes** section. You will see one field for each attribute you
   defined — a text field for `class`, a select list for `target`, and so on — each
   showing the label and description from your YAML.
5. Fill in the values you want (for example type `btn btn-primary` into
   **Link class(es)**, or pick *New window (_blank)* for **Link target**).
6. Click **Save**.

The values you enter are stored on the menu link and rendered automatically through
Drupal's menu theming, so the class, target, or other attribute now appears on the
link (or on its `<li>` container for `container_` attributes) wherever the menu is
displayed.
