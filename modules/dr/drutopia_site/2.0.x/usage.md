<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drutopia Site is a configuration-only base feature that installs the shared authoring baseline (text formats, CKEditor 5, block content types, and role permission grants) used across the Drutopia distribution.
---
The module ships no PHP logic of its own beyond three update hooks; its value is the exported configuration under `config/install` and `config/actions`. On install it creates three text formats (`basic_html`, `full_html`, `restricted_html`) with matching CKEditor 5 editors, two `block_content` bundles (`basic`, which has a `body` field, and `slide`, which references a `slide` paragraph) plus their default form and view displays, and one autosave setting. Its `config/actions` files (processed by `drutopia_core`'s config actions) additively add text-format, workflow-buttons, block-content, menu, and role-delegation permissions to six existing site roles: `anonymous`, `authenticated`, `contributor`, `editor`, and `manager`, plus an `autosave_form.settings` tweak enabling autosave of new/unsaved content.

It pulls in a broad dependency set (Admin Toolbar with its Tools and Search submodules, Display Suite, Paragraphs, Entity Reference Revisions, Menu Admin Per Menu, Role Delegation, Autosave Form, and `drutopia_core`) so a Drutopia site has a consistent authoring toolbar, per-menu delegation, and content-editing baseline. The three update hooks (`drutopia_site_update_8101/8102/9201`) swap the obsolete `admin_links_access_filter` for `admin_toolbar_links_access_filter` and install the newer dependencies. There are no routes, services, permission definitions, or controllers in this module — nothing is exposed to anonymous users beyond what the imported roles and text-format permissions grant. This checkout is a `2.0.x` dev branch (its `.info.yml` has no `version:` key), and higher-level Drutopia content features layer on top of it.
---
- Install the Drutopia baseline text formats and CKEditor 5 editors in one step.
- Provide `basic` and `slide` block content types for site building.
- Add a `body` field to the `basic` block type and a `slide` paragraph reference to the `slide` block type.
- Configure default and columnar view displays for the `slide` block type.
- Grant editorial roles their text-format and workflow permissions (contributor, editor, manager).
- Give the `manager` role block-content, block-type, menu, and role-assignment permissions.
- Delegate role assignment with `role_delegation` without granting full user administration.
- Restrict per-menu editing with `menu_admin_per_menu`.
- Enable autosave of unsaved/new content on forms via `autosave_form`.
- Give editors the Admin Toolbar with search and links-access filtering.
- Standardise text-format permissions across a fleet of Drutopia sites.
- Bootstrap a new Drutopia install's editorial configuration.
- Migrate an older site off `admin_links_access_filter` via the update hook.
- Manage the created roles at `/admin/people/roles` and permissions at `/admin/people/permissions`.
- Edit the installed text formats and editors at `/admin/config/content/formats`.
- Create reusable `slide` blocks for carousels or hero regions.
- Keep authoring UX consistent across many Drutopia sites.
- Layer Drutopia content-type features (article, blog, campaign) on top of this base.
- Export or override the shipped config in a site-specific feature.
- Review the granted permission set per role after install.
- Combine with `drutopia_core` and other Drutopia features for a fuller base.
