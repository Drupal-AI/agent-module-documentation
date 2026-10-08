# Configuration

Redirect Entity Manager has a single, small settings page. Its main job is to let
you decide which entity types get the **Redirects** tab, so the feature only
appears where you want it.

## Open the settings form

1. Log in as a user with the **Administer redirects** permission.
2. Go to **Configuration → Search and metadata → Redirect Entity Manager**, or
   navigate directly to `/admin/config/search/redirect-entity-manager` (route
   `redirect_entity_manager.settings`).

## Choose which entity types show the Redirects tab

The form lets you enable or disable redirect management per entity type —
**node**, **taxonomy term**, and **media**. Tick the entity types where editors
should be able to manage redirects from the content itself, and leave the others
unticked. This keeps the tab off content where it would only add clutter.

After saving, the **Redirects** tab appears on entities of the enabled types for
any user who holds the **Administer redirects** permission.

## Permissions

This module does not define permissions of its own — it reuses the Redirect
module's access model. A user needs **Administer redirects** to see and use the
Redirects tab and the settings page. Grant that permission at **People →
Permissions** (`/admin/people/permissions`) to the roles that should manage
redirects.

## Save

Click **Save configuration**. The set of entity types offering the Redirects tab
updates immediately.
