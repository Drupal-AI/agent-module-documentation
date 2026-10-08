# Configuration

There is no module settings page. You configure visibility **per menu link**, and
the choices are saved against that specific link.

## Open a menu link's Visibility settings

1. Log in as a user who can administer menus.
2. Go to **Structure → Menus** (`/admin/structure/menu`), open the menu that holds
   the link, and click **Edit** next to the link (or **Add link** to create one).
3. Scroll to the **Visibility settings** fieldset the module adds to the form.

## The fields

### Roles

A list of checkboxes, one per user role. This answers "who should see this link?"

- **Tick one or more roles** — the link appears only for users who have at least one
  of the ticked roles.
- **Leave every role unticked** — the link is visible to everyone. (This is the
  default, so existing links are unaffected until you choose roles.)

The filter is applied when menus are rendered and it recurses into submenus, so
hiding a parent or a child link both work.

> **Important:** on its own, the roles setting is a **display filter**. It removes
> the link from the rendered menu, but it does **not** protect the page the link
> points to — a user who knows or guesses the URL can still reach it unless the
> target route enforces its own access. To also block the destination, use Path
> Access below (for node links).

### Path Access

A single checkbox, labelled around "Path Access". It is only meaningful for links
that point to a **node**.

- When **off** (default), nothing extra happens — the roles setting only hides the
  link.
- When **on**, the module additionally enforces access to the linked node: if the
  current user fails the same role check, they are **denied access** to that node's
  page (not just the menu link). This is the part that actually blocks content.

So, to fully restrict a node behind a menu link, tick the allowed **Roles** *and*
enable **Path Access** on the link that points to that node.

## Save

Save the menu link form as usual. The visibility choices take effect immediately;
reload a page as a user in a non-permitted role to confirm the link (and, with Path
Access, the node) is hidden.
