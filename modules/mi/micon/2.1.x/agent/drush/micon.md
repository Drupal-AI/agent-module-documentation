<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: `drush micon <path>`

One command, registered via `drush.services.yml` (`Drupal\micon\Commands\MiconCommands`,
injected with `micon.icon.manager`).

```
drush micon themes/my_theme/src/scss/base
```

- **Argument** `<path>`: a directory **relative to the Drupal root**, no trailing slash. It must
  already exist or the command aborts with "Location directory not found".
- **Output**: writes `<path>/_micon.scss` containing a `@mixin micon($package, $icon, $position)`
  and a `$micons` Sass map of every icon in every **active** package →
  `<prefix><name>: '<hex>'` (e.g. `fa-user: '\f007'`), so a theme can emit icon glyphs in CSS
  via `@include micon(fa, user)`.
- Icons with multiple names emit one map entry per name; hex comes from `MiconIcon::getHex()`
  (font packages only). Regenerate whenever packages change — the file header warns not to edit
  it by hand.

No other Drush commands are provided.
