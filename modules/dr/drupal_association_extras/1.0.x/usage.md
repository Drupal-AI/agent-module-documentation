<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupal Association Extras is a small add-on from the Drupal Association that, at 1.0.0-alpha1, adds a single "🚀 Ready to launch?" link to the bottom of Drupal 11's admin Navigation toolbar.

---

Install it like any module (`composer require drupal/drupal_association_extras` then enable it, or `drush en drupal_association_extras`); it requires Drupal core **11.2+** and core's **Navigation** module, which it lists as a dependency. It has **no settings page and nothing to configure**. All it does is run once at install time: its `hook_install()` uses core's config-action system to add a navigation link block to `navigation.block_layout` at a high delta (so it appears last among the main items), labelled internally "Launch" and displayed as **🚀 Ready to launch?**, linking to `https://drupal.org/drupal-cms/launch`. The link is skipped when the module is enabled during a configuration import (`$is_syncing`). Because the link is written into core Navigation's own configuration, you manage it there afterwards — edit or remove the entry in `navigation.block_layout` (for example with `drush config:edit navigation.block_layout`); reinstalling the module re-adds it. The module ships no runtime code (no controllers, routes, services, permissions, or plugins) and is published as an alpha container that the Drupal Association intends to grow with further initiative- and program-related features over time.

---

- Add a "Ready to launch?" call-to-action link to the admin Navigation toolbar.
- Promote the Drupal CMS launch page to site administrators.
- Support a Drupal Association initiative on a Drupal 11 site.
- Install a Drupal Association-provided feature in the admin UI.
- Try the module inside a Drupal CMS trial experience.
- Confirm the module requires core Navigation and Drupal 11.2+.
- Enable the module with Composer or Drush.
- Verify the launch link appears last in the navigation toolbar.
- Edit the launch link's title or URL in `navigation.block_layout`.
- Remove the launch link by deleting its entry from navigation config.
- Re-add the link by reinstalling the module.
- Understand why an inherited site shows a "Ready to launch?" navigation item.
- Audit which module added a given navigation toolbar link.
- Check that the module adds no settings page and nothing to configure.
- Skip the link injection cleanly during configuration import.
- Grant `access navigation` so a user can see the added link.
- Track the module as the Drupal Association adds further program features.
- Plan for substantial change between alpha releases before adopting it.
- Uninstall it if the Drupal Association program does not apply to your site.
- Report accurately that today it only adds one static navigation link.
