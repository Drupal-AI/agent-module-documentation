<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sharepoint Connector — agent index

Adds a **customizable connection to Microsoft SharePoint** (e.g. push Webform submissions into SharePoint).
Depends on `webform`. Version **1.0.7**. Core `^8.8||^9||^10||^11`.

**Security:** store SharePoint/Microsoft app credentials as **secrets**; HTTPS; data sent (form submissions)
may be PII (data-handling). Uses standard HTTP (TLS not disabled). No access role.
