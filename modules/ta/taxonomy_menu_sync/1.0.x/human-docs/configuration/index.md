# Configuration

Taxonomy Menu Sync does nothing until you create at least one sync configuration.
This page walks through that setup.

## Open the configuration listing

Go to **Structure → Taxonomy Menu Sync**, or navigate directly to
`/admin/structure/taxonomy_menu_item_extras`. This is the listing page for all your
term-to-menu sync configurations.

## Create a new configuration

1. Click the **Add New** button.
2. Fill in the configuration to match your requirements — choose the vocabulary
   whose terms should become menu items, and set how the links behave. The module
   can use the terms' default taxonomy paths, or point each link at a custom node
   URL, depending on how you set it up.
3. Click **Save** to store the configuration.

You can create several configurations — for example one per vocabulary.

## Synchronize terms into the menu

Creating the configuration defines the mapping; running a synchronization is what
actually generates and updates the menu items.

- From the listing page, use the **Synchronize** option in the drop-button (the
  operations menu) next to a configuration, **or**
- Open a configuration's edit page and use the **Synchronize** action there.

Each synchronization creates or updates the menu links so they mirror the current
terms in the vocabulary. Run it again whenever the vocabulary changes and you want
the menu brought back in step.

> **Heads up:** synced menu items intentionally cannot have their **title** or
> **parent link** edited directly through the menu UI — that protection keeps the
> menu faithful to the vocabulary. Manage those through the terms and the sync
> instead.

## Synchronizing from the command line

If you prefer scripting or want to run syncs from a deploy hook, the module also
provides a Drush command:

```bash
drush taxonomy_menu_sync:sync [IDS]
```

Pass the configuration IDs you want to synchronize. This does the same work as the
**Synchronize** button in the UI.
