<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SharePoint File Download proxies SharePoint file downloads via a shareable ID, gated by a permission.

---

Sharepoint file download enables users to download files by providing a shareable URL ID — offering a convenient route to download SharePoint-hosted documents through Drupal (proxying the file from SharePoint via the Sharepoint API), so intranet users can access shared documents without direct SharePoint access.

Downloading is gated by the `download sharepoint files` permission, and files are fetched from SharePoint using the admin-configured Sharepoint API connection (credentials env-backed) — restrict the permission to trusted roles. Depends on `sharepoint_api`; supports Drupal 8 through 11.

---

- Download SharePoint files via Drupal.
- Use a shareable URL ID.
- Proxy files from SharePoint.
- Serve intranet users.
- Avoid direct SharePoint access.
- Gate with `download sharepoint files`.
- Fetch via the Sharepoint API connection.
- Keep credentials env-backed.
- Restrict the permission to trusted roles.
- Depend on `sharepoint_api`.
- Support Drupal 8 through 11.
- Provide easy downloads.
- Access shared documents
- Configure the connection
- Handle file requests.
- Support document sharing.
- Download by ID.
- Integrate SharePoint files
