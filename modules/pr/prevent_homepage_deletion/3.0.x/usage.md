<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prevent Homepage Deletion blocks deleting — and unpublishing — the nodes that back the site's front page, 404 page, 403 page and any extra paths you list, unless the user holds a dedicated permission.

---

The module is two access hooks plus a one-field settings form. `prevent_homepage_deletion_node_access()` implements `hook_node_access()`: on the `delete` operation it calls `_prevent_homepage_deletion_check()` and returns `AccessResult::forbidden()` when the node is protected and the account lacks the permission `delete_homepage_node` (returning `AccessResult::neutral()` otherwise). `prevent_homepage_deletion_entity_field_access()` additionally forbids `edit` access on a published node's `status` field, so a protected node cannot be unpublished either — the *Published* checkbox simply disappears from the node form. The protected set is computed on every check from `system.site:page.front`, `page.404` and `page.403` plus the newline-separated list in `prevent_homepage_deletion.settings:protected_urls`; each URI is turned into a `Url` object with `Url::fromUri('internal:' . $uri)`, and if it is routed its first route parameter is taken as the protected entity id. In addition, `\Drupal::service('path.matcher')->isFrontPage()` makes the check fire for the current request's front page. When an authenticated user hits a `/delete` URL or submits the `node_delete_action` bulk action against a protected node, `_prevent_homepage_deletion_show_message()` adds an explanatory message. The settings form lives at `/admin/config/system/prevent-homepage-deletion` (route `prevent_homepage_deletion.settings`, requirement `administer site configuration`, with a menu link under *Configuration → System* titled "Prevent page deletion"). Two caveats the module documents itself: a user with core's `bypass node access` permission overrules the module entirely, and the protected paths must be real internal paths starting with `/` — wildcards are not supported.

---

- Stop editors from deleting the node that is configured as the site front page.
- Protect the custom 404 "Page not found" node from deletion.
- Protect the custom 403 "Access denied" node from deletion.
- Add key landing pages (`/node/12`, `/about-us`) to a protected list.
- Prevent a protected node from being *unpublished* as well as deleted.
- Hide the *Published* checkbox on a protected node's edit form for non-privileged users.
- Remove the *Delete* tab from a protected node for users without the permission.
- Make bulk operations on the content overview skip protected nodes and explain why.
- Give a single "site owner" role the `delete_homepage_node` permission and nobody else.
- Protect legal pages (privacy policy, terms) from accidental deletion.
- Protect a "Contact" node linked from the main menu.
- Keep a maintenance/holding page node from being removed by mistake.
- Add a safety net on a multi-editor site where anyone can delete content.
- Protect the nodes referenced by `system.site` after a content migration.
- Ship the protected list as config (`prevent_homepage_deletion.settings:protected_urls`) between environments.
- Audit which paths are protected by reading one config value.
- Temporarily unprotect a page by removing its line from the settings textarea.
- Combine with a workflow module so archiving, not deleting, is the only way to retire the front page.
- Explain to editors why a delete failed via the module's messenger message.
- Protect an alias path (e.g. `/home`) as well as the raw `/node/N` path.
- Give a deployment role the permission temporarily to replace the front page node.
- Prevent an automated cleanup script (running as a normal user) from removing the front page.
