# Configuration

Configuring Replicate UI is a two-part job: choose which entity types can be
cloned on the settings form, and grant the right permission to the roles that
should be able to clone.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → Replicate**
   (`/admin/config/content/replicate`).

## Choose the replicable entity types

The form lists the content entity types on your site. Tick each one you want to be
replicable — for example **Content** (nodes), **Taxonomy term**, **Media**, or
**Custom block**. Only content entity types that have a canonical page are
offered. Out of the box nothing is ticked, so nothing is replicable until you
enable at least one type.

When you enable a type and save, the module wires up everything needed for that
type:

- a `/{type}/{id}/replicate` route,
- a **Replicate** tab (local task) on the entity's page,
- a **Replicate** operation link on admin content listings,
- the confirm form used to name and create the copy, and
- a Replicate variant of the bulk **Action** and the Views link field.

## Require edit access on the original (optional)

The form has one extra toggle:

- **Check edit access** — when on, a user may only replicate an entity they are
  also allowed to *edit*. Leave it off to let anyone with the replicate permission
  and create access clone the item, even if they can't edit the original.

## The confirm form editors see

When an editor clicks **Replicate**, they get a confirmation form asking for a
**New label**, pre-filled with "*(original label)* (Copy)". Translatable entities
show one label field per language. Confirming creates the clone and sends the
editor to the new copy's page.

## Grant the permission

Enabling a type is not enough on its own — cloning is gated by permissions. On
**People → Permissions**, grant:

- **Replicate entities via UI** (`replicate entities`) — the master switch for
  using the Replicate UI. This permission is not "restrict access" flagged, so
  grant it only to trusted roles.

In addition, a user needs the **normal create access** for the target type (for
example *Create Article content*) and **view access** to the entity being cloned.
If you turned on *Check edit access*, they also need edit access to the original.
Granting the replicate permission alone is not enough — without create access the
Replicate tab stays hidden. A typical editor role therefore needs, for articles:

```bash
drush role:perm:add editor 'replicate entities'
drush role:perm:add editor 'create article content'
```

## Editing settings with Drush

The two settings live in the `replicate_ui.settings` config object. You can set
them from the command line, but note one gotcha: the routes and tabs are only
built during a cache rebuild, which the settings *form* triggers for you
automatically. If you write the config directly, you must rebuild caches yourself:

```bash
drush cset replicate_ui.settings entity_types.0 node -y
drush cset replicate_ui.settings check_edit_access true -y
drush cr   # required, or the Replicate route and tab won't appear
```
