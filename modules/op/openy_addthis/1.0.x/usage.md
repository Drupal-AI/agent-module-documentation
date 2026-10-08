<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Open Y AddThis provides a configurable block ("Open Y AddThis Block") that renders social-sharing icons/links (via the third-party AddThis service) so visitors can share the current page to social networks. It ships as part of the Open Y (YMCA) distribution but works as a standalone contrib module.

---

The module exposes a single settings form at `/admin/openy/settings/openy-addthis` (route `openy_addthis.settings`, gated by the `administer site configuration` permission) that stores its configuration in the `openy_addthis.settings` config object and a block plugin you place through Block Layout. It registers an uninstall validator (`openy_addthis_uninstall_validator`, class `AddThisUninstallValidator`) that blocks uninstall while block instances still exist, plus a `PrepareUninstallForm` at `/admin/modules/uninstall/openy-addthis` (gated by `administer modules`) to clean those up first. It has no module dependencies beyond Drupal core, defines no permissions of its own, and adds no Drush commands. Because it embeds the external AddThis widget, it inherits AddThis's third-party privacy/tracking characteristics — relevant now that the AddThis service itself has been discontinued by its owner.

---

- Add social-share buttons to article or landing pages by placing the AddThis block in a content region.
- Let visitors share the current page to Facebook, X/Twitter, LinkedIn and other networks from one widget.
- Ship consistent share controls across a YMCA/Open Y distribution site.
- Configure which share targets/appearance are used from a single admin settings form.
- Export the `openy_addthis.settings` config to replicate the share setup across environments.
- Restrict who can change share settings via the `administer site configuration` permission.
- Place the share block only on specific content types using core block visibility conditions.
- Provide a reusable share block instead of hard-coding markup in a theme template.
- Prepare the module for clean uninstall using the bundled prepare-uninstall form.
- Prevent accidental uninstall while share blocks are still in use (uninstall validator).
- Add share controls to a decoupled-ish theme without writing custom JS.
- Localize/gate the share block placement per region or per menu path.
- Give editors a no-code way to enable social sharing on new sections.
- Standardize social-sharing UX across multiple sites via shared configuration.
- Retire the block cleanly when migrating off AddThis (now that AddThis is discontinued).
- Audit where sharing appears by reviewing placed block instances before uninstall.
- Bundle social sharing into an install profile or recipe as a placeable block.
