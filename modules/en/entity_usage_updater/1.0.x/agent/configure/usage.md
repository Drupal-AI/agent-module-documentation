<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using Entity Usage Updater

## Prerequisite
Install and configure **Entity Usage** and let it track the reference types you care about — only
tracked references can be updated here.

## Repoint references
1. Grant `update referenced entities` (permission is `restrict access: true`) to trusted roles.
2. Go to `/admin/content/update-references` (menu: Content → Update entity references).
3. Enter the target entity to find and the id of its replacement; submit to rewrite all tracked
   references. Updates may create new revisions and are applied directly to content — back up first.

## Remove links
`/admin/config/content/link-remover` strips links to a chosen entity out of content (HTML/Link/Linkit).

## Settings
`/admin/config/content/entity-usage-updater` (`administer site configuration`) configures the module
and which `EntityUsageUpdater` plugins apply.

## Extend
Add a plugin under `Plugin/EntityUsageUpdater` (Annotation or Attribute discovery) to support a new
reference type; see the shipped EntityReference, HtmlLink, Link and LinkIt plugins.
