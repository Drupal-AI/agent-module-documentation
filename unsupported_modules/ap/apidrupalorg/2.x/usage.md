<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A small companion to the API module holding the customizations specific to the api.drupal.org site.

---
It provides three things: an admin Import form (`/admin/config/development/apidrupalorg/import`) that migrates comments from the old Drupal 7 api.drupal.org into the current API module's comment storage; an inbound path processor (`ExternalDocumentation`) that rewrites URLs for external-documentation branches so legacy links keep working; and a `FooterMessage` block plugin for the site footer.

The import route is tightly gated — it requires *all* of `administer comments`, `administer users` and `administer API reference` at once, so only a full administrator can run the migration. There are no anonymous or mutating endpoints; the path processor only rewrites request paths and the block only renders static footer markup. This module is only useful when running an api.drupal.org-style deployment on top of the API module.
---
- Migrate D7 api.drupal.org comments into the API module.
- Run the one-off comments import from the admin UI.
- Keep legacy external-documentation URLs resolving.
- Rewrite inbound paths for external doc branches.
- Show a custom footer message on an API docs site.
- Reproduce api.drupal.org behaviour on a self-hosted portal.
- Restrict the importer to full administrators only.
- Pair with the API module on a documentation portal.
- Preserve historical comment threads during an upgrade.
- Add site-specific chrome to an API reference site.
- Provide a footer block without a custom theme.
- Bridge Drupal 7 comment data into Drupal 9/10/11.
- Maintain backward-compatible documentation links.
- Centralise api.drupal.org tweaks in one module.
- Enable only on the api.drupal.org-style deployment.