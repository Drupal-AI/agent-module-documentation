# Configuration

There is no central settings page. You configure Quick Node Block by **placing
the block**, and each placement remembers its own node and view mode. Placing it
several times, each with a different node, is how you build up featured-content
areas.

## Place a block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the region you want the content to appear in and click **Place block**.
3. Choose **Quick Node Block** (it is listed under the "Quick Node Block"
   category).
4. The block form gives you two fields:
   - **Node** — an autocomplete field. Start typing a node's title (or its id)
     and select the node you want to display.
   - **Display** — a select list of the view modes available for that node's
     content type (for example *Teaser*, *Full content*, or any custom view mode
     you have defined). This field only appears once a node is chosen, and its
     options refresh automatically after you pick the node.
5. Set the usual block options if you wish — a title, visibility conditions,
   weight — then **Save block**.

The block now renders that node, in that view mode, in the chosen region.

## The "Add to Block" shortcut

On any node's page there is an **Add to Block** tab
(`/admin/node/{node}/quick_node_block`, which requires the **Administer blocks**
permission). It opens the same block-placement form with that node already filled
in, so you can feature the content you are looking at without going back to the
Block layout screen.

## Good to know

- **Access is respected.** If a visitor cannot view the selected node, the block
  does not show for them.
- **It stays in sync.** The block renders the live node through Drupal's view
  builder and tags its cache with the node, so editing the node updates the
  block. To change what a block shows, just edit the block and pick a different
  node or view mode — no code deploy needed.
- **Mix and match.** Place the same node twice — as a teaser in a sidebar and as
  full content elsewhere — or design a stripped-down custom view mode
  specifically for block placement and select it here.
