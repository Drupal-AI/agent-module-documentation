<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Content Access Simple

## Prerequisites
1. Enable `content_access` and `content_access_simple`.
2. On a content type's access form (`/admin/structure/types/manage/{type}/access`) enable **"Per content node access control settings"**.
3. In **Manage form display** for that content type, enable the **Content Access Simple** component (machine name `content_access_simple`).
4. Grant the `access content access simple` permission to the editor roles that may change view access.

## The node-form widget
On the node edit form an **Access and Permissions** details element appears with a "Visibility" checkboxes list of roles that may view the node. Submitting merges the checked roles (plus any hidden roles that were already granted) and calls Content Access to write node grants.

## Config-only settings (`content_access_simple.settings`)
Not yet exposed in the UI — edit via config import or `drush cset`:
- `role_config.hidden_roles` — roles removed from the list entirely (default: anonymous, authenticated, administrator).
- `role_config.disabled_roles` — roles shown but rendered as disabled checkboxes (e.g. to stop lower roles editing higher roles).
- `debug` — when true, logs "complex permission" scenarios to the `content_access_simple` channel.
- `help_text_view` — description under the Visibility checkboxes (Xss::filterAdmin).
- `unpublished_message` — message shown on unpublished nodes; if unset and `view_unpublished` is installed, the roles able to view unpublished content are listed dynamically.

## "Complex" nodes
If a node's per-node `view_own` differs from the content-type default, or a hidden role's `view` differs from the default, the node is flagged **complex** and the simple widget is read-only for it; use the full Content Access form at `/node/{nid}/access` instead.
