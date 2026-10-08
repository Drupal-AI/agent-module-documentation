# Configuration

Setting up jsTree menu has two parts: choosing the jsTree theme on the module's
admin form, and placing a jsTree menu block for each menu you want to render as a
tree.

## Choose the jsTree theme

Log in as an administrator and open the module's settings form (config route
`jstree_menu.config`). There you can switch the tree's appearance between the two
bundled jsTree themes:

- **default** — the standard jsTree look.
- **proton** — a cleaner alternative theme (recommended; make sure you installed
  the proton theme files alongside the jsTree library, per the module's README).

Pick the one that suits your site and save.

## Place a jsTree menu block

The actual menus are rendered by blocks:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region where you want the navigation, click **Place block** and choose a
   **jsTree menu** block.
3. In the block's settings, select **which menu** it should render as a tree (for
   example the Main navigation, or a custom menu).
4. Configure the usual block options — title, region, visibility conditions — and
   save.

Repeat for any additional menus you want to display as trees. Each block renders
one menu.

## Notes

- The tree reflects the underlying menu and respects each menu item's access, so
  users only see links they are permitted to see.
- For icons to display correctly, install a Bootstrap theme / Bootstrap library or
  the **Font Awesome** module as noted in [Installation](../installation/index.md).
