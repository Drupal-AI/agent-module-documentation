<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Guide Tests is a hidden, developer-only module that provides automated functional tests which verify the Drupal User Guide's instructions and generate the screenshots and site backups the guide ships.
---
It contains no runtime functionality — only WebDriver/PHPUnit FunctionalJavascript tests (one class per language) that build the User Guide's demo site step by step, assert the UI text used in the guide is present and works, capture screen images, and write database + files "backups" representing the demo site at the end of each chapter. Tests run on DrupalCI/GitLab CI or locally with chromedriver; helper shell scripts (`cropimages.sh`, `compareimages.sh`, `copybackups.sh`) post-process the captured images and backups. Restorable backups per language/chapter live under `backups/`.

This module is `hidden: TRUE` and pulls in the Honey theme, Admin Toolbar and Backup & Migrate as test dependencies. It is intended for maintainers of the User Guide project, not for site building. Setup involves the full Drupal test harness (chromedriver, phpunit.xml output dirs) as documented in its README.
---
- Verify User Guide task steps against the live UI.
- Assert that UI text used in the guide is present.
- Generate screenshots for the User Guide.
- Produce per-chapter database backups of the demo site.
- Produce per-chapter files-directory backups.
- Clone the User Guide demo site at any chapter from backups.
- Run the tests per language (one test class each).
- Crop captured screenshots with `cropimages.sh`.
- Compare new vs. previous images with `compareimages.sh`.
- Copy generated backups with `copybackups.sh`.
- Run tests on DrupalCI / GitLab CI pipelines.
- Run tests locally with chromedriver + PHPUnit.
- Add a new language test class extending the base.
- Provide translated `$demoInput` for a language.
- Debug tests with `stopTheTestForDebug()` / `scrollWindowUp()`.
- Regenerate images after a Drupal core UI change.
- Keep the User Guide screenshots in sync with core.
- Restore a chapter backup to reproduce a documented state.
- Validate the demo-site build end to end.
- Supply Honey theme + Admin Toolbar + Backup & Migrate for tests.
