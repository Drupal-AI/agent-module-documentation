# Configuration

Entity Clone Multiple is configured through **clone settings** — one configuration
entity per entity type you want to be able to clone multiple times — plus a general
settings form. Everything lives under **Configuration → Content authoring → Entity
clone** (`/admin/config/content/entity-clone`).

## Open the settings

1. Log in as a user with the **Administer entity clone settings** permission.
2. Go to **Configuration → Content authoring → Entity clone**, or navigate directly
   to `/admin/config/content/entity-clone`.

You'll land on the **clone settings list**, which shows the per-entity-type settings
you have defined, with links to add, edit, and delete them.

## Add or edit a clone setting

Click **Add** (`/admin/config/content/entity-clone/add`) to create a new clone
setting, or edit an existing one from the list. A clone setting ties the
multiple-clone behavior to a specific entity type: it tells the module how to produce
several copies of that entity, spaced across time until an end date.

Because cloning is driven by a **date field** and a **repeat interval**, a clone
setting is where you connect those together for the chosen entity type — the module
then creates copies at that interval up to the specified date. The interval can be
any interval PHP's `DateInterval` class understands (for example daily, weekly, or a
custom span).

Clone settings are stored as **configuration entities**, so they are exportable and
travel with your configuration management workflow. Deleting a setting uses a
confirmation form gated by entity access; uninstalling the module removes the clone
settings it created.

## General settings

The **General settings** form at `/admin/config/content/entity-clone/settings`
holds site-wide options for the module and requires the **Administer site
configuration** permission (in addition to the module's own admin permission).

## Save

Save each clone setting or the general settings form when you are done. Because
these are configuration entities, remember to export your configuration if you manage
config in code.
