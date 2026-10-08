<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Bootstrap is **deprecated**. It provided Bootstrap 3 form theming for Webform, and only for the Drupal Bootstrap theme — not for other Bootstrap-based themes such as Radix.

---

The info file states the position twice: `lifecycle: deprecated`, `package: 'Webform [DEPRECATED]'`, with a `lifecycle_link` to the Webform FAQ entry on deprecated external libraries. Bootstrap 3 itself is long out of support, and the module's own description carries the warning that it must not be used with other Bootstrap Framework themes.

Two practical notes for anyone meeting it.

**It is a metapackage, not a project.** `composer require drupal/webform_bootstrap` resolves to nothing of its own and installs **webform**, with the module landing at `web/modules/contrib/webform/modules/webform_bootstrap`. There is no top-level `webform_bootstrap` directory, which is why tooling that looks for one reports it as failing to install when it did not.

**Do not adopt it.** On a new site use a theme that styles Webform's markup directly, or Webform's own element wrappers. On an existing Drupal Bootstrap site, treat removing it as part of the work of moving off Bootstrap 3 — which is due anyway.

---

- Recognise a deprecated Webform submodule on an inherited site.
- Understand why `webform_bootstrap` has no top-level directory.
- Explain a metapackage that resolves to another project.
- Plan removal alongside a Bootstrap 3 migration.
- Avoid installing it on a new site.
- Identify Bootstrap 3 dependencies during an audit.
- Confirm it applies only to the Drupal Bootstrap theme.
- Choose theme-level Webform styling instead.
- Check whether a site's theme still needs it.
- Remove it from a composer file after migration.
- Audit deprecated modules across a site.
- Trace a module shipped inside another project.
