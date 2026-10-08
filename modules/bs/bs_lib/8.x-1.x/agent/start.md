<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BS Lib (bs_lib) — agent index

Component-oriented **Bootstrap 4** library for the `bs_base` theme family, plus Drush commands for
generating child themes. Version **8.x-1.0-rc3**. Core `^9.2 || ^10 || ^11`.
**No declared dependencies.**

**Documented from source. Enabling it without the `bs_base` theme kills the entire Drush CLI —
verified.**

```php
public function __construct(ThemeHandlerInterface $theme_handler) {
  $bs_base = $theme_handler->getTheme('bs_base');   // THROWS if not installed
  include_once "{$bs_base->getPath()}/bs_base.drush.inc";
}
```

Drush instantiates every `drush.command`-tagged service at bootstrap, so this constructor takes
down **every** Drush command on the site.

**The failure signature is what makes it dangerous:** the website kept returning **200** on the
front page and login while `drush status` failed with *"The theme bs_base does not exist."* A
deployment check that curls the site sees health; the breakage surfaces during a release.

**`drush pm:uninstall bs_lib` cannot run either** — recovery needed a direct `core.extension` DB
edit.

Drupal has no way for a module to require a *theme* at install time, so nothing prevents
`drush en bs_lib`. Install `bs_base` first, or do not install this.