<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Translation Sync copies translated configuration overrides from the config sync directory into active config.

---

Config Translation Sync targets a common multilingual deploy problem: `language.<langcode>.<config>`
translation overrides staged in the config **sync** directory not making it cleanly into **active**
config. Its service reads each such override from sync storage and writes it into active storage when
it differs, so translated config (site name, view labels, field labels, and other config strings)
stays consistent across environments. It manages translation config, not content, and holds no
access-control role beyond its admin permission. Depends on core Config Translation; package `Config`;
core `^10 || ^11 || ^12`.

The working entry point is the Drush command `config:resync-translations` (alias `crst`). The module
also ships a config-import event subscriber meant to run this automatically after `drush cim`, but in
1.0.2 that subscriber is not registered as a service, so run `crst` explicitly (e.g. as a deploy step).

---

## Drush command: `drush crst`

Options (all optional; each is a comma-separated list):

- `--config-names` — config names or `*`-wildcard patterns to include. Empty = every config in the
  sync directory.
- `--exclude` — config names or patterns to exclude. Empty = fall back to the module's
  `excluded_configs` setting.
- `--langcode` — restrict to these language codes. Empty = the `enabled_languages` setting, or every
  site language if that is empty.

Examples (from the command's own `#[CLI\Usage]` attributes):

```bash
# Resync all configs matching system.*
drush crst --config-names=system.*

# Resync all views except the frontpage view
drush crst --config-names=views.view.* --exclude=views.view.frontpage

# Resync all node types except article and page
drush crst --config-names=node.type.* --exclude=node.type.article,node.type.page

# Resync system.* configs for Russian and English only
drush crst --config-names=system.* --langcode=ru,en
```

Only `language.<langcode>.<config>` overrides that already exist in the sync directory are copied,
and only when the value differs from active config. Each write is logged to the
`config_translation_sync` logger channel.

## Settings form

At `/admin/config/development/config-translation-sync` (permission
`administer config translation sync`) you can set:

- **Enabled languages** — default target languages when `--langcode` is not passed.
- **Excluded configuration names** — one name/pattern per line, applied when `--exclude` is not passed.

These only supply defaults for the sync service; the form does not itself run a sync.
