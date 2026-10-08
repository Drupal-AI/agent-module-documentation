<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Copyright Footer — agent index

One Block plugin (`copyright_footer`) that renders `Copyright © <year> <organization> <version>`
with the current year computed on every build. No settings page, no configure route
(`configure: null`), no permissions, no Drush, no plugin types. Depends on core `block`.

- **Place & configure the block, its six settings keys, single vs. range year logic** →
  [configure/block.md](configure/block.md)

Key facts: block id `copyright_footer`, category "Custom". Settings keys:
`organization_name`, `organization_url`, `year_origin`, `year_to_date`, `version`,
`version_url` (schema `block.settings.copyright_footer`). Empty `year_origin` (or equal to
current year) → single year; otherwise `year_origin-year_to_date` range with empty
`year_to_date` defaulting to the current year.
