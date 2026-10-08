# Configuration

Setting up Local Task Splitter is a three-step process: create a **split
configuration** that says which tabs belong together, place a **block** for it in
a region, and configure how that block renders. Once you have done this, the tabs
you selected appear in your chosen block instead of (or as well as) the default
"Tabs" block.

## Step 1 — Create a split configuration

1. Log in as a user who can administer the module.
2. Go to **Configuration → User interface → Local Task Split**, or navigate
   directly to `/admin/structure/local_task_splits`.
3. Create a new split configuration. A split defines **which local tasks it
   captures**, chosen by their routes. You group tabs either by:
   - **Inclusion** — list the specific routes that this split should contain, or
   - **Exclusion** — capture everything *except* the routes you list.

   You can also choose to **hide the split tasks from the default core tab
   blocks**, which avoids showing the same tabs twice once you place your own
   block.

Create as many splits as you need — for example, one split for primary actions and
another that gathers secondary actions like *Delete* and *Revisions*.

## Step 2 — Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Local Task Split Tabs** block in the region where you want those
   tabs to appear.

## Step 3 — Configure the block

In the block's settings:

- **Select the split configuration** you created in step 1, so the block knows
  which tabs to render.
- **Choose whether to render as a dropbutton** — turn this on to collapse the
  group of tasks into a single space-saving dropdown instead of a row of tabs.
- If you have the **UI Icons** module installed, you can add **icons** to the
  dropbutton for a clearer, more compact presentation.

Save the block. Repeat steps 2–3 for each split you want to display.

## Verify it worked

Visit a page that has the relevant local tasks (for example a node's edit page).
The tabs you assigned to a split should now appear in the block/region you chose —
and, if you enabled it, rendered as a dropbutton. Confirm they no longer duplicate
in the default Tabs block if you chose to hide them there.
