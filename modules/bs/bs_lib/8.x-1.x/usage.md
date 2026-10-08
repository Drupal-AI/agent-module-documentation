<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
BS Lib supplies a component-oriented Bootstrap 4 library and Drush commands for creating `bs_base`-compatible child themes.

---

It belongs to the `bs_base` theme family: the theme provides the Bootstrap foundation, and this module carries the shared component library, templates and the scaffolding commands that generate a new child theme from it. On a project already committed to that family it removes the boilerplate of standing up a theme by hand.

**Enabling it without the `bs_base` theme installed kills the entire Drush CLI for the site, and this was verified.** `BsLibCommands::__construct()` does:

```php
public function __construct(ThemeHandlerInterface $theme_handler) {
  $bs_base = $theme_handler->getTheme('bs_base');
  include_once "{$bs_base->getPath()}/bs_base.drush.inc";
}
```

`ThemeHandler::getTheme()` **throws** when the theme is not installed, and Drush instantiates every service tagged `drush.command` at bootstrap. So one module's command constructor takes down every Drush command on the site — including commands with no connection to it. Observed: the website kept returning 200 on the front page and the login page while `drush status` failed with *"The theme bs_base does not exist."*

That failure signature is the dangerous part. A deployment check that curls the site sees a healthy site; the breakage only appears when someone tries to run a Drush command, which on most projects is during a release. And **`drush pm:uninstall bs_lib` cannot run either** — recovery required removing the module from `core.extension` with a direct database edit.

`bs_lib.info.yml` declares no dependencies at all, and Drupal has no way for a module to require a *theme* at install time, so nothing stops `drush en bs_lib` on a site without `bs_base`. Install the theme first, or do not install this module. Documentation here is written from source for that reason.

---

- Add a Bootstrap 4 component library to a bs_base site.
- Generate a bs_base-compatible child theme.
- Scaffold theme files with a Drush command.
- Reuse shared Bootstrap components across themes.
- Install the bs_base theme before enabling the module.
- Diagnose a site where every Drush command fails.
- Recognise a healthy website with a dead CLI.
- Recover by editing core.extension directly.
- Understand why pm:uninstall cannot fix it.
- Check theme prerequisites before enabling a module.
- Audit modules that depend on themes implicitly.
- Plan a bs_base theme project.
- Avoid enabling it on a non-bs_base site.
- Test Drush after enabling any module with drush.services.yml.
- Guard command constructors against missing dependencies.