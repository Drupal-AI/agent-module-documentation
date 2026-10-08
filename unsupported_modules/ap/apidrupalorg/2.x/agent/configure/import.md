<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# apidrupalorg — comments import & customizations

## Import form
- Route `apidrupalorg.import` → `/admin/config/development/apidrupalorg/import`.
- Access requires **all** of: `administer comments`, `administer users`, `administer API reference` (comma-joined `_permission` = AND). Effectively full-admin only.
- Migrates comments from the legacy Drupal 7 api.drupal.org into the current API module's comment storage (`src/Form/ImportForm.php`).

## External-documentation path processor
- Service `apidrupalorg.path_processor.external_documentation` (tagged `path_processor_inbound`, priority 100) rewrites inbound URLs for the API module's external-documentation branches so old links keep resolving. Read-only path rewriting.

## Footer message block
- `src/Plugin/Block/FooterMessage.php` — place via Block layout to render the site footer message.

Only relevant when hosting an api.drupal.org-style site on the API module.
