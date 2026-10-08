<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sharepoint Connector adds a customizable connection to Microsoft SharePoint.

---

Sharepoint Connector adds a customizable connection between Drupal and Microsoft SharePoint — commonly
used to push data (such as Webform submissions) into SharePoint, or otherwise integrate SharePoint with the
site. It depends on the Webform module.

Use it to connect Drupal to SharePoint. Security notes: it authenticates to SharePoint/Microsoft with app
credentials (client ID/secret or a token) — **store those as secrets** (not in exported config) and operate
over HTTPS; data sent to SharePoint (e.g. form submissions) may contain personal data (a data-handling
consideration). Its API requests use Drupal's standard HTTP client (TLS verification is not disabled in this
module). It has no access-control role. Configure the SharePoint connection.

---

- Connect Drupal to Microsoft SharePoint.
- Push webform submissions to SharePoint.
- Integrate SharePoint with the site.
- Depend on the Webform module.
- Store SharePoint app credentials as secrets.
- Operate over HTTPS.
- Mind PII sent to SharePoint.
- Use standard HTTP (TLS not disabled).
- Have no access-control role.
- Configure the SharePoint connection.
- Send data to SharePoint.
- Handle credentials securely.
- Integrate SharePoint.
- Configure the connection.
- Push form data.
- Connect to SharePoint.
- Handle SharePoint integration.
- Configure credentials.
- Send submissions.
- Integrate Microsoft SharePoint.
