<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sharepoint API provides the base integration/client for connecting Drupal to SharePoint.

---

Sharepoint API integrates Drupal with SharePoint — providing the base client/services to authenticate against and call the SharePoint (Microsoft 365) API, and to expose Drupal services for SharePoint. Other modules (e.g. SharePoint File Download) build on it to read documents and data from SharePoint.

SharePoint app credentials (client id/secret, tenant) should be stored securely (env-backed), never committed. It's the connectivity layer with no content or access role of its own. Supports Drupal 8.8+ through 11.

---

- Integrate Drupal with SharePoint.
- Authenticate against the SharePoint API.
- Call Microsoft 365 SharePoint services.
- Expose Drupal services for SharePoint.
- Serve as a connectivity layer.
- Underpin SharePoint modules.
- Store app credentials securely (env-backed).
- Never commit credentials.
- Carry no content/access role.
- Support Drupal 8.8+ through 11.
- Read documents/data from SharePoint.
- Configure the connection.
- Bridge Drupal and SharePoint
- Handle OAuth/app auth
- Support intranets.
- Provide the base client.
- Integrate SharePoint.
- Connect to Microsoft 365
