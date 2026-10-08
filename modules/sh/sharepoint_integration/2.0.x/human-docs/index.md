# SharePoint Integration — manual setup guide

**SharePoint Integration** (`sharepoint_integration`), by miniOrange, provides secure,
automated content synchronization between Microsoft SharePoint / OneDrive and your Drupal
site using the **Microsoft Graph API** and the **SharePoint REST API**. Once you connect a
SharePoint site through a Microsoft Entra ID (Azure AD) application registration, the module
keeps its document libraries, lists, list/library views and site pages available inside
Drupal — so your users can browse, preview, download and upload SharePoint content directly
from Drupal, according to their Drupal roles and permissions, without a separate SharePoint
login.

The module is configured on its own client-configuration form (route
`mo_sharepoint.client_configuration`, at
`/admin/config/mo-sharepoint-integration/client-config`) and provides its own permissions to
control who can administer it and who can view synchronized content. It sits in the
*miniOrange SharePoint Integration* package and supports Drupal 10 and 11. It has no
submodules and no required contrib dependencies.

As with any SharePoint integration, treat the app credentials (Tenant ID, Client ID and
Client Secret) as secrets — store them securely, restrict the administer permission to trusted
roles, and operate the connection over HTTPS.

This guide is written for a **human** setting the module up. If you want terse, token-cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — connect a SharePoint site and grant access.

## Where it lives in the admin menu

The module adds a **SharePoint Integration** area under
**Administration » Configuration** (route `mo_sharepoint.client_configuration`). From there
you enter the connection details, add SharePoint site(s), and reach the Import/Export, Log
Settings and (premium) AI Assistant / Copilot settings. See
[Configuration](configuration/index.md) for what to fill in.
