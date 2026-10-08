<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SharePoint Integration — agent index

Establishes a **connection between Microsoft SharePoint and Drupal** (miniOrange — integration/SSO/content).
Config at `sharepoint_integration.connection`; provides permissions. Version **1.1.0**. Core `^10||^11`.

**Credentials:** store SharePoint/Azure app credentials as secrets; HTTPS. The module also includes a
miniOrange support/trial-query helper (`MOSupport::callService`), separate from the SharePoint connection path.
