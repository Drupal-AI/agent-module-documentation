# Configuration

Menu Migration gives you two ways to work: **saved definitions** (reusable Menu
Export / Menu Import entities you configure once and run repeatedly) and **quick
commands** (Drush one-liners that act on menus by ID with no saved configuration).
Everything lives under **Configuration → Development → Menu Migration**
(`/admin/config/development/menu-migration`).

> **Important:** only manually-created menu link content links are handled. Links
> that come from Views, taxonomy menus, or other dynamic sources are ignored. Also
> note that **importing a menu is destructive per menu**: the target menu's existing
> content links are cleared and rebuilt from the source, not merged.

## Menu Export entities

A **Menu Export** definition (found under *Menu Exports*) picks a **destination**, a
**format**, and the **menus** to export:

- **Codebase** — writes the export to a file on disk (in a directory you choose).
  Great for committing a menu to version control and importing it on another
  environment. Can export several menus at once.
- **Download** — streams the export as a downloadable file straight to your browser.
  Handy for a quick archive or to hand to a colleague. One menu at a time.
- **Another menu** — clones the selected menu's links into a *different* menu on the
  same site. You choose the target menu and can optionally have it **created** if it
  doesn't exist yet. (No file or format is involved for this one.)

For the file-based destinations, the **format** is JSON, YAML, or raw. Save the
definition, then run it from its **Export** operation link on the listing, or with
Drush (below).

## Menu Import entities

A **Menu Import** definition (under *Menu Imports*) mirrors the export side, picking a
**source**, **format**, and **menus**:

- **Codebase** — reads a previously exported file from a directory on disk.
- **File upload** — reads a file you upload through the form.

Run it from its **Import** operation link, or with Drush. Remember that importing
replaces the target menu's current links.

Both Menu Export and Menu Import entities are drag-orderable on their listing pages
(the order just controls how they're listed).

## Quick Action Settings

The **Quick Action Settings** form (the third item in the Menu Migration section)
sets the defaults used by the *quick* Drush commands — the ones that don't use a saved
entity. There are two settings:

- **Format** — the default serialization format for quick exports/imports (`json` or
  `yaml`).
- **Export path** — the directory quick exports are written to and quick imports read
  from.

You can also read or set these from the command line:

```bash
drush cget menu_migration.quick_export
drush cset menu_migration.quick_export format yaml -y
```

This form requires the *administer menu migration* permission.

## Drush commands

Menu Migration provides seven Drush commands. All commands that change data prompt
for confirmation — add `-y` to skip the prompt.

| Command | Alias | What it does |
|---------|-------|--------------|
| `menu_migration:export` | `mme` | Run a saved **Menu Export** entity by its id. |
| `menu_migration:export-list` | `mmel` | List the Menu Exports that can be run from Drush. |
| `menu_migration:import` | `mmi` | Run a saved **Menu Import** entity by its id. |
| `menu_migration:import-list` | `mmil` | List the Menu Imports that can be run from Drush. |
| `menu_migration:quick-export` | `mmqe` | Export menus by id, no saved entity needed. |
| `menu_migration:quick-import` | `mmqi` | Import menus by id from the quick directory. |
| `menu_migration:quick-clone` | `mmqc` | Clone links from one menu into another. |

### Quick command examples

The quick commands use the **Quick Action Settings** (format + directory) as their
defaults, and you can override the format per run with `--format=` (`json`, `yaml`, or
`raw`):

```bash
# Export the main and footer menus to the quick-export directory (default format):
drush mmqe main,footer -y

# Export just the main menu as YAML:
drush mmqe main --format=yaml -y

# Import the main menu back from that directory:
drush mmqi main -y

# Clone the main menu's links into main_backup, creating that menu if needed:
drush mmqc main main_backup --create-target -y
```

Unknown menu names are skipped with a warning rather than failing the whole command.

### Entity-backed command examples

```bash
# See which saved exports can run from Drush (and their destinations):
drush mmel

# Run a saved export / import by id:
drush mme main_to_codebase -y
drush mmi main_from_codebase -y
```

## Extending it (developers)

Destinations, sources, and formats are all pluggable, and a `MenuImportEvent` lets
other modules rewrite each menu item as it is imported (for example to swap a domain
in link URLs). See the [`agent/`](../agent/plugins/plugins.md) docs for how to add a
custom destination, source, or format, and the
[service/event docs](../agent/api/service-events.md) for the import event.
