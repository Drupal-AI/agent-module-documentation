<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Access Logo gives every domain in a Domain (Domain Access) installation its own site logo, so one Drupal site serving several branded hostnames can show a different mark per domain without duplicating themes or resorting to CSS hacks.

---

The core site logo is a theme setting and themes are not domain-aware, so out of the box every domain shows the same logo. This module adds one settings form at `/admin/config/domain/domain_access_logo` (route `domain_access_logo.settings`, permission `administer domains access logos`) that renders a managed-file upload per Domain record, restricted to image types (`png gif jpg jpeg svg`) and stored under `public://files`. The chosen file id for each domain is saved as `logos.<domain_id>` in the `domain_access_logo.settings` config object. At render time the module implements `hook_preprocess_block` and, only for the core `system_branding_block`, asks the `domain_access_logo` service (`getActiveDomainLogo()`) for the active domain's logo URL and swaps it into the block's `site_logo` element. Because it hangs off the active Domain rather than the active theme, the per-domain logo follows the domain across theme switches; because the images are managed files on disk, they change without a deployment and are not part of a config export. Dependencies are core `file` and `domain` (composer `drupal/domain ^2.0 || ^3.0`), on core `^10.2 || ^11`.

---

- Show a different logo on each domain of a Domain Access site.
- Brand affiliate or regional sites separately from the main site.
- Avoid duplicating a whole theme per domain just to change the logo.
- Let a delegated admin manage per-domain logos without full site-config access.
- Keep per-domain branding out of theme settings.
- Serve regional variants of a brand from a single install.
- Give a campaign microdomain its own identity.
- Manage logos from a tab inside the Domain admin area.
- Switch a domain's logo without a deployment.
- Keep one shared theme across many branded domains.
- Restrict logo management to the `administer domains access logos` permission.
- Support a multi-brand editorial team on one codebase.
- Roll out a rebrand domain by domain.
- Upload PNG, GIF, JPG/JPEG, or SVG logos per domain.
- Fall back to the theme's default logo when a domain has no logo set.
- Read the active domain's logo URL from the `domain_access_logo` service in custom code.
- Reduce theme count in a multi-domain build.
- Onboard a new domain with its own branding in minutes.
- Clear a domain's logo and have the old file cleaned up automatically.
- Have new logos appear immediately (the form invalidates `system.site` cache tags).
- Migrate 1.x logo config into the 2.x `logos` structure via `drush updatedb`.
- Swap only the branding block's logo while leaving theme markup untouched.
