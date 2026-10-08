# Configuration

SharePoint Integration is set up on its own client-configuration form. This is where you tell
Drupal how to reach your SharePoint / Azure app so the two systems can connect, then add the
SharePoint site(s) you want to bring into Drupal.

## Open the connection form

1. Log in as a user with the module's administer permission (`mo_administrator`). This
   permission is marked *restricted* because it grants access to the stored Microsoft Entra ID
   client credentials — grant it only to trusted roles at **People → Permissions**.
2. Go to **Administration » Configuration » SharePoint Integration**
   (route `mo_sharepoint.client_configuration`, at
   `/admin/config/mo-sharepoint-integration/client-config`).

## Connect your Entra ID application

On the **Connection** tab, enter the **Tenant ID**, **Client ID** and **Client Secret** from
your Microsoft Entra ID application registration (or select a client certificate if you use
certificate-based authentication with the optional `custom_certificate` module). Save, then
fetch a token to verify the connection.

If the token cannot be fetched, re-check the Tenant ID, Client ID and Client Secret, confirm
the client secret has not expired, and confirm the Graph API permissions have been granted
admin consent in Microsoft Entra ID.

Treat the client secret as a secret: store it securely and make sure the connection runs over
HTTPS.

## Add a SharePoint site and sync

On the **Site Configuration** tab, add the SharePoint site(s) you want to connect and run a
sync. Synchronization pulls the site's document libraries, lists, list/library views and site
pages into Drupal. You can re-sync on demand, on Drupal cron (premium), or from the command
line with `drush sharepoint_integration:sync-site`. The free tier supports one SharePoint
site; Premium supports multiple.

## Grant end-user access

Grant the appropriate end-user permissions at **People → Permissions** to the roles that
should see synchronized content:

| Permission | Purpose |
| ---------- | ------- |
| `mo_administrator` | Configure the module (restricted — trusted roles only). |
| `mo_access_file` | View and download synchronized files. |
| `mo_access_list` | View synchronized lists. |
| `mo_access_view` | View list and library views. |
| `mo_access_page` | View synchronized SharePoint pages. |

The front-end SharePoint Files, Lists, Views and Pages surfaces (under `/mo-sharepoint/…`) are
permission-controlled; a role only sees a surface once you grant it the matching permission.

## Optional settings

- **Import & Export** (`/admin/config/mo-sharepoint-integration/configuration/import-export`) —
  move a configuration between environments.
- **Log Settings** (`/admin/config/mo-sharepoint-integration/settings/logger`) — control how
  much API activity is logged; review entries at **Reports → Recent log messages** filtered by
  type `sharepoint_integration`.
- **AI Assistant / Copilot settings** (`/admin/config/mo-sharepoint-integration/copilot-settings`) —
  a premium chat widget backed by Microsoft Copilot Studio or Azure OpenAI + Graph.
