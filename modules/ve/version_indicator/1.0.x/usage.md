<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Version Indicator displays a site release-version string as a badge in the Drupal core Navigation footer, so editors and admins can see which release is deployed.
---
An admin sets the version string on a small settings form (`/admin/config/system/version-indicator`, permission `administer version indicator`, config `version_indicator.settings:version`, default `v0.0.0`). The `version_indicator.info` service reads that value and exposes cache tags. A block plugin (`version_indicator_navigation_footer`, class `NavigationVersionBlock`) renders the value using the `navigation:badge` SDC component with info styling and the config cache tag.

On install the `NavigationFooterManager` service programmatically inserts that block into the Navigation `block_layout` footer region (generating a component UUID), and removes it on uninstall; a `hook_block_alter` implementation marks the block `allow_in_navigation` and hides it from the general Block UI so it is managed only through the Navigation layout. The module targets Drupal 11.1+/12 and depends on the core `navigation` module.
---
- Set the deployed release version at `/admin/config/system/version-indicator`.
- Show the version badge in the Navigation footer to admins/editors.
- Update the version string after each deployment.
- Read the current version via the `version_indicator.info` service.
- Reuse the `version_indicator_navigation_footer` block in the Navigation layout.
- Restrict access with the `administer version indicator` permission.
- Let the block auto-install into the Navigation footer on enable.
- Have the block auto-remove on uninstall.
- Rely on cache tag `config:version_indicator.settings` to refresh the badge.
- Render the version using the core `navigation:badge` SDC component.
- Keep the block hidden from the general Block UI (managed via Navigation).
- Style the badge via the `version_indicator/navigation_footer` library.
- Communicate the current release to content editors at a glance.
- Track which build is live across environments.
- Depend on core `navigation` being enabled.
- Change the badge label by re-saving the settings form.
- Integrate release/version display without a custom block.
- Confirm the default version is `v0.0.0` until configured.