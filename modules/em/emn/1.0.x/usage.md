<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Machine Name surfaces the otherwise-hidden machine names of config entities directly in Drupal's admin list tables.
---
The module swaps the `node_type` list builder for its own `ContentListBuilder` (adding a Machine name column to the content-types listing) and uses `hook_form_FORM_ID_alter()` to inject a Machine name column into three core admin tables: the block layout form (`block_admin_display_form`, resolving each block's plugin id), the taxonomy vocabularies overview, and the user roles overview. No data is changed — the module is purely a read-only admin-UI convenience for developers and site builders who need to see machine names without opening each entity's edit form.

There are no routes, permissions, services, or configuration. Access is inherited from the core admin pages the columns are added to (each already requires the relevant administer permission). It is a small, single-purpose usability aid.
---
- See content-type machine names on /admin/structure/types.
- See vocabulary machine names on the taxonomy overview.
- See role machine names on /admin/people/roles.
- See block plugin ids on the block layout page.
- Copy a machine name for use in code without opening the edit form.
- Speed up config export / drush work by reading ids in the UI.
- Help onboard developers to an unfamiliar site's structure.
- Cross-reference machine names when writing hook_update or migrations.
- Confirm a content type's id before referencing it in a view or template.
- Verify a block's plugin id when theming or placing programmatically.
- Reduce clicks when auditing taxonomy vocabularies.
- Support QA by exposing machine names alongside human labels.
- Read a role's machine name when writing an access hook.
- Match a block's plugin id when overriding it in a theme.
- Document a site's structure by capturing ids from the UI.
- Avoid guessing machine names from human labels during config work.