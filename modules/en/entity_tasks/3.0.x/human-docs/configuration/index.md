# Configuration

There are two independent ways to surface the tasks: as a **block** you place in a
region, and as a **toolbar** integration. Set up whichever you want — or both.

## Place the tasks block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place a new block in the **Content** region (or wherever you want the tasks to
   appear), choosing the Entity Tasks block.
3. In the block's settings, you can position the block on the **left‑hand side** of
   the screen; the **right** side is the default.
4. Save. Once placed, the tasks are displayed at a fixed position on the page,
   showing only the operations the current user has permission to perform.

## Choose the toolbar display mode

The module can also render the tasks in the admin toolbar. This is controlled by
its settings form.

1. Log in as a user with permission to administer the module's configuration.
2. Go to **Configuration → Entity Tasks** (`/admin/config/entity-tasks`).
3. Choose a **display mode** for the toolbar. The default is **disabled**; the
   three active styles are:
   - **Classic** — displays the tasks as the default items in the toolbar.
   - **Expanded** — displays all the tasks next to each other in the toolbar.
   - **Dropdown** — displays the tasks when you hover over the tasks button in the
     toolbar.
4. Save the form. The toolbar updates to show the tasks in your chosen style.

## Permissions

Entity Tasks provides its own permission (under **People → Permissions**) governing
who may use the tasks feature. Regardless of that, the individual tabs shown always
respect each user's access — a user never sees an Edit or Delete task they aren't
allowed to perform.
