# Configuration

SharePoint Integration is set up on its own connection form. This is where you tell
Drupal how to reach your SharePoint / Azure app so the two systems can connect.

## Open the connection form

1. Log in as a user with the module's administer permission (an administrator by
   default — the module provides its own permissions, so review them at
   **People → Permissions** if you want to delegate access).
2. Go to the **SharePoint Integration** connection configuration form (route
   `sharepoint_integration.connection`), reached from the module's link in the
   site's Configuration area.

## Set up the connection

On the connection form you provide the details of your SharePoint / Azure app
registration — the client ID and secret (and related connection settings) that let
Drupal authenticate to SharePoint. Enter those values, save, and the module uses
them to establish the connection for integration, SSO, and content access.

Treat the client ID and secret as secrets: store them securely and make sure the
connection runs over HTTPS.
