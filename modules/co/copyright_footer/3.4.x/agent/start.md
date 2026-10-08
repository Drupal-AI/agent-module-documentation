<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Copyright Footer (copyright_footer) — agent index

One Block plugin (`copyright_footer`) that renders `Copyright © <year> <organization> <version>`,
with the current year computed on every build in the site timezone. No settings page, no configure
route (`configure: null`), no permissions, no services, no Drush, no plugin types. Depends on core
`block`. Branch 3.x declares `core_version_requirement: ^9 || ^10 || ^11 || ^12`.

- **Place & configure the block, all settings keys, single/range year logic, "All Rights
  Reserved." positions, custom format tokens, caching** → [configure/block.md](configure/block.md)

Key facts: block id `copyright_footer`, admin label "Copyright Footer", category "Custom".
Class `Drupal\copyright_footer\Plugin\Block\CopyrightFooter` implements `CopyrightFooterInterface`.
Settings keys (schema `block.settings.copyright_footer`): `organization_name`, `organization_url`,
`year_origin`, `year_to_date`, `version`, `version_url`, `all_rights_reserved_position`
(`none`/`organization`/`version`), `copyright_format`; `all_rights_reserved` is a deprecated
boolean kept for back-compat. Supported format tokens: `[copyright] [year] [start-year]
[end-year] [organization-name] [version]`. Empty `year_origin` (or equal to current year) → single
year; otherwise `year_origin-year_to_date` range with empty `year_to_date` defaulting to the current
year. Cache max-age is `Cache::PERMANENT` when both years are fixed, else expires at the next
site-local new year.
