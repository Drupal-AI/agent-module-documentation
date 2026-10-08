# Configuration

Ultimenu has two configuration surfaces: the **settings form** at
**Structure → Ultimenu** (`/admin/structure/ultimenu`, permission *Administer
ultimenu*), where you choose which menus and item-regions are active, and the
**per-block settings** on each placed Ultimenu block, where you control its look
and behaviour.

Because the module ships no defaults, the very first time you open the settings
form nothing is enabled yet. The form is built to be saved **one step at a time** —
each save reveals the next section.

## Open the settings form

Go to **Structure → Ultimenu**. You'll see three groups: **Ultimenu blocks**,
**Ultimenu regions**, and **Ultimenu goodies**.

## Step 1 — turn menus into Ultimenu blocks

Under **Ultimenu blocks**, tick each menu you want to become a mega-menu (for
example *Main navigation*) and **Save**. Every menu you tick becomes a placeable
block. After saving, clear the cache (`drush cr`) if the new block doesn't yet
appear at *Block layout* — the block derivatives are rebuilt on save.

## Step 2 — enable the item-regions

Once step 1 is saved, the enabled menus' top-level items appear under **Ultimenu
regions**. Tick the ones you want to be active flyout regions and **Save**. Only
enabled regions show up when you go to fill them with blocks.

## Step 3 — the goodies (optional)

The **Ultimenu goodies** section holds the remaining feature toggles. Some worth
knowing:

- **Menu description / description on top** — render a description line under (or
  above) each menu title in the flyout.
- **Title / hash / counter classes** — add CSS helper classes to menu items for
  styling.
- **Use hashed region keys** — use a stable hash rather than the item title as the
  region key, so renaming a menu item doesn't destroy its region and the blocks in
  it. Recommended.
- **Decouple main menu** — treat the Main menu like any other menu.
- **Expose regions to all front-end themes** — so switching themes doesn't force
  you to re-place blocks.
- **Force-remove region** — remove Ultimenu regions that were previously saved
  into a theme's `.info.yml`.

Other keys on this form include a custom **skins** directory path, the AJAX
**fallback text**, and an **AJAX max-width** below which panels auto-load on
demand.

## Place the Ultimenu block

Go to **Structure → Block layout** (`/admin/structure/block`), find your block
(search for *"Ultimenu:"*), and place it into an ordinary theme region such as the
header. **Do not** place an Ultimenu block into an Ultimenu region — that breaks
the layout. The Ultimenu regions are meant to be filled with *other* blocks.

### Per-block settings

On the block's configuration form you can set, among others:

- **Skin** — the visual style (e.g. dark/light or a custom skin).
- **Orientation** — the flyout direction.
- **Caret** — show arrows on items that have a panel.
- **Submenu** — render second-level menu items inside the regions (with
  collapsible / positioning options).
- **Off-canvas / hamburger** — turn this block into an off-canvas drawer or an
  always-hamburger menu (keep only one off-canvas Ultimenu block active per page,
  using block visibility rules).
- **Sticky** — make the header sticky as the user scrolls.
- **Ajaxify** — load the panel contents on demand instead of up front.

## Fill the flyout regions

Finally, go back to **Block layout** and drop your content blocks (promos, views,
images, menus…) into the generated **Ultimenu: &lt;menu&gt;: &lt;item&gt;** regions.
Whatever you place there becomes the flyout panel for that menu item.

## Making regions permanent (optional)

Regions are injected at runtime via a hook, so you never need to edit your theme's
`.info.yml`. If you'd rather store them permanently, the settings form shows a
copy-and-paste `regions:` block you can drop into a theme's info file; a region
defined in the theme wins unless you enable **Force-remove region**.
