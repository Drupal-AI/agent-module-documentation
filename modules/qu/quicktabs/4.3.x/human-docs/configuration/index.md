# Configuration

Quick Tabs is configured by building **tab sets** — there is no global settings
form. Each tab set you create becomes a placeable block. To manage tab sets, log in
as a user with the **Administer quicktabs** permission and go to **Structure → Quick
Tabs** (`/admin/structure/quicktabs`). From the list you can **Add**, **Edit**,
**Duplicate**, or **Delete** a set.

## Creating a tab set

Click **Add** (`/admin/structure/quicktabs/add`) to open the tab-set form.

### Label

A human-readable name for the set. Drupal derives a machine name from it; that
machine name is what identifies the config entity (`quicktabs.quicktabs_instance.*`)
and the derived block.

### Renderer

Choose how the whole set is presented:

- **Quick tabs** — the classic horizontal tab bar (always available).
- **Accordion tabs** — a collapsible jQuery UI accordion (only if you enabled the
  *Quicktabs Accordion* submodule).
- **UI tabs** — jQuery UI tabs (only if you enabled the *Quicktabs jQuery UI*
  submodule).

The options shown further down the form change depending on the renderer you pick.

### Tabs

Add one row per tab. For each tab you set:

- **Title** — the label shown on the tab.
- **Weight** — controls the order of the tabs (lower weights come first).
- **Type** — the *tab type*, which decides what content the tab loads (see below).
- **Content** — the settings for the chosen type (which node, which View, and so
  on).

You can add as many tabs as you like and reorder them by weight.

## Tab types — what each tab loads

The **Type** dropdown offers four built-in content sources:

- **Node content** (`node_content`) — show a single node. You pick the node, a
  **view mode** (teaser, full, etc.), and whether to hide the node title.
- **Block content** (`block_content`) — show a block (a custom block, a menu, a
  Views block, etc.). You choose the block and whether to display its title.
- **View content** (`view_content`) — show a View. You choose the View, which
  **display** to use, and any contextual **arguments** to pass in.
- **Quick Tabs content** (`qtabs_content`) — embed *another* Quick Tabs set inside a
  tab, by its machine name, so you can nest tab sets.

## Instance options

These apply to the whole set:

- **Hide empty tabs** — drop any tab whose content renders empty, so the tab bar
  only shows populated tabs.
- **Default tab** — which tab is open when the block first loads.
- **Remember last clicked tab** — re-open the tab a visitor last clicked on their
  next visit, stored in a browser cookie (this is what the `js_cookie` dependency
  powers).

## Renderer-specific options

**Quick tabs** (the classic renderer) adds:

- **Ajax** — load each tab's content on demand over AJAX instead of all at once,
  which speeds up the initial page load.
- **Style** — a shipped CSS theme for the tab bar: none, *pamela*, *on-the-gray*,
  *tabsbar*, or *material-tabs*.
- **Custom classes** — extra CSS classes to add to the markup.
- **Direct linking** — make each tab deep-linkable so a visitor can share a URL that
  opens a specific tab.

**Accordion tabs** (the accordion submodule) adds:

- **Collapsible** — allow all sections to be closed at once.
- **Height style** — how section heights are calculated: *auto*, *fill*, or
  *content*.

## Saving and placing the block

Click **Save**. Quick Tabs derives a block from the set, listed under the
"QuickTabs" category on **Structure → Block layout** (`/admin/structure/block`).
Place it into a region exactly as you would any other block, and configure
visibility conditions there if needed.

## Alternative: render a View's rows as tabs

You do not always need to build a tab set. If you just want a View to present its
own result rows as tabs, edit the View, and under **Format** choose the **Quick
Tabs** style. This is independent of the tab sets described above.
