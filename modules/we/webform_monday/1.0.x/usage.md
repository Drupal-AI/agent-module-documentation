<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Monday.com pushes Webform submissions into Monday.com boards through a Webform handler, mapping form elements to board columns.

---

Monday.com connections are modelled as `webform_monday_instance` config entities, each referencing a Key entity (`key.repository`) that holds the API token — the token is never stored in the module's own config. A `MondayClient` service talks to the Monday GraphQL API over the standard Guzzle HTTP client (`@http_client`, TLS verification at Drupal defaults; the token is sent in the `Authorization` header to the HTTPS `API_ENDPOINT`). It creates items (`create_item` mutation), lists boards, reads board groups/columns (filtering out read-only column types), caches board/column metadata for 5 minutes, and offers a `testConnection` (`{ me { name } }`) check. On a webform submission, the handler maps values to a board's columns and creates an item. Data flows outbound only — there is no inbound webhook or callback endpoint.

Manage instances and global settings (API version, timeout, debug logging) at `/admin/config/services/monday` under `administer webform_monday` (`restrict access: true`). Setup: create a Key with your Monday token, add a Monday instance pointing at that key, then attach the Monday handler to a webform and map elements to columns.
---
- Send webform submissions to a Monday.com board
- Create a Monday item per submission
- Map form fields to board columns
- Store the Monday API token in a Key entity, not config
- Configure multiple Monday instances
- Test a Monday connection before use
- List available boards for mapping
- Read board groups and columns
- Exclude read-only column types from mapping
- Cache board/column metadata for performance
- Set the Monday API version and request timeout
- Enable debug logging of API requests/responses
- Create labels on the fly if missing
- Route different webforms to different boards
- Restrict integration admin to `administer webform_monday`
- Handle GraphQL error responses gracefully
- Invalidate cached board data when an instance changes
- Integrate a contact form with a Monday CRM pipeline
