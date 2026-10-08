# Configuration

What you configure depends on which enhancement you want. Two of the features need
a setup step; the operation link on the usage tab works as soon as the module is
enabled.

## Prerequisite: configure Entity Usage first

Every feature here reads Entity Usage's data. Before you rely on any of it, make
sure Entity Usage is installed, configured to capture the relationships you care
about, and that you've **run its batch update on all content**. If you use
revisions, note that Entity Usage still counts usage in previous revisions.

## Show child entities on the usage tab

To add a list of the child entities referenced by the current entity to its usage
tab:

1. Go to the settings page at
   `/admin/config/entity-usage/settings/entity-usage-plus`.
2. Enable the option to display child entities.
3. **Clear the cache** (for example with `drush cr`) so the change takes effect.

The usage tab will then include the extra list of referenced child entities.

## Build a view of unreferenced entities

The "unreferenced entities" feature is a Views filter you apply to a view you
create:

1. Create an administrative **View** of the entities you want to audit — for
   example media items.
2. Add the **"Limit to unreferenced entities"** view filter to it.
3. Save and run the view.

The result is a list of entities that nothing references — handy for finding, for
example, media that was never used and can be removed. The list is only as good as
Entity Usage's data, so confirm your tracking configuration and batch update are up
to date before trusting it.

## Access

Entity Usage Plus does not add its own permissions — it uses **Entity Usage's
permissions**. Manage access through Entity Usage's permissions on **People →
Permissions** (`/admin/people/permissions`).
