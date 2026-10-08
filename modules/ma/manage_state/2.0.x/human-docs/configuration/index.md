# Configuration

Manage State needs no setup — there's no settings form to fill in. What this page
describes is the **overview tool itself**: how to view, search, edit, and delete
State API values, and how to do it without breaking your site.

## Open the overview

Go to **Configuration → Development → State**
(`/admin/config/development/state`). You'll need the module's management
permission, which you should grant only to trusted administrators (see the
warning below).

## The state variables overview

The overview lists every variable currently stored in the State API, with a
**search/filter** box so you can narrow a long list to the key you're looking for.
For each entry you can:

- **View** the stored value — including complex/serialized values, rendered
  readably via Symfony's var-dumper.
- **Edit** the value — for **simple, less-complex variables**. Deeply nested or
  object-based values are shown for inspection but aren't safely editable through
  the form; leave those to code or Drush.
- **Delete** the variable individually.

## Deleting in bulk

Two bulk actions are available and should be used with care:

- **Delete selected** — tick the variables you want gone and remove them
  together.
- **Delete all state variables** — clears everything in the State API. This is a
  blunt instrument: it will wipe operational values many modules rely on (cron
  timing, update flags, and so on). Use it only if you genuinely understand the
  consequences.

## Please be careful

State holds live operational data. Editing a value or deleting a key changes how
the site behaves, and the wrong change can break functionality — this is why the
maintainers advise against casual use on production. Two habits keep you safe:

1. **Restrict the permission.** Only trusted administrators should be able to
   reach this screen. Grant its permission narrowly at **People → Permissions**.
2. **Look before you change.** View a value and understand what owns it before you
   edit or delete it, and take a database backup before any bulk delete.

There is nothing to save on a settings form here — your changes take effect the
moment you edit or delete a state entry.
