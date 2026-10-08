<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Links Filter (elf) — agent index

Text-format filter (`filter_elf`) that flags external and `mailto:` links in filtered content
by adding CSS classes (`elf-external` / `elf-mailto` plus a configurable icon class). It can
also add `rel` tokens (`nofollow`/`noopener`/`noreferrer`), open external links in a new tab,
append an accessible screen-reader label, and route external links through an internal
`/elf/redirect` endpoint. Display-only: it rewrites the rendered markup, not the stored text.

- Core: `^8 || ^9 || ^10`. Depends on core `editor`. Requires the PHP `DOM` extension
  (`elf_requirements()` errors without it).
- Settings page: `/admin/config/content/elf` (route `elf.admin_settings`, permission
  `administer site configuration`).
- No custom permissions. No drush commands. Defines no plugin types (it provides one core
  Filter plugin, `filter_elf`).

## Solutions
- **Enable and tune the filter on a text format** → [configure/filter.md](configure/filter.md)
- **Set module-wide options (internal domains, icon class, new tab, accessible, redirect)** → [configure/settings.md](configure/settings.md)
- **Build or handle the internal redirect URL for an external link** → [api/redirect.md](api/redirect.md)

## Key facts
- Filter plugin id `filter_elf` (class `Drupal\elf\Plugin\Filter\FilterElf`), type
  `TYPE_MARKUP_LANGUAGE`; per-filter settings `elf_nofollow`, `elf_noopener`,
  `elf_noreferrer` (all default `false`).
- Config object `elf.settings` — keys `elf_domains` (sequence of internal domains),
  `elf_icon_class` (default `elf-icon`), `elf_window` (bool), `elf_accessible` (bool),
  `elf_redirect` (bool). Schema in `config/schema/elf.schema.yml`.
- Service `elf.manager` → `Drupal\elf\ElfManager` (constructor arg `@private_key`); method
  `getRedirectUrl($external_url)`.
- Redirect route `elf.redirect` at `/elf/redirect` (permission `access content`), controller
  `Drupal\elf\Controller\ElfController::elfRedirect`.
- Added classes: `elf-external`, `elf-mailto`, `elf-img` (external link wrapping an `<img>`),
  plus the configured icon class.
- Library `elf/elf_css` (attached on filter output). Menu link `elf.admin_settings` under
  `system.admin_config_content`. Help hook `elf_help` (renders README.md).
