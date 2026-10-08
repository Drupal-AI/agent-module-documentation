<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, enable & scaffold

## Enable the Drupal module
```
composer require drupal/automated_testing_kit
drush en automated_testing_kit -y
```
No dependencies, no configuration form, no permissions. Enabling it only activates the two
theme-preprocess hooks (node/term/media ID exposure) and the `file:properties` Drush command.
Intended for local / QA / CI environments, not production.

## Scaffold a test project — `module_support/`
- `module_support/atk_setup <playwright|cypress>` — copies tests and config files to the project
  root (uses `ATK_HOME`).
- `module_support/cypress.config.js`, `cypress.atk.config.js`, `playwright.config.js`,
  `playwright.atk.config.js` — example runner configs. The `*.atk.config.js` files hold ATK
  settings consumed by the helper commands: `drushCmd` (e.g. `"ddev drush"`), `logInUrl`,
  `logOutUrl`, `nodeDeleteUrl`, `email.provider`, and `pantheon` / `targetSite` transport blocks.
- `module_support/development/` — dev dependency manifests (`cypress.package.json`,
  `playwright.package.json`, `eslint.config.mjs`, `.prettierrc`).

Install Cypress/Playwright on the host OS (the README recommends against running them inside a
container), pointing at a Drupal site served by DDEV/Lando/Docksal.

## Fixtures — `data/`
- `qaUsers.json` — standard `admin` / `authenticated` QA account definitions (username, password,
  roles) consumed by `createUserWithUserObject` and login helpers.
- `testUser.json` — a single sample user object.
- `testMessages.json` — error-message strings referenced by helpers (e.g. `ATK_NID_MISSING`).
- `search.yml`, `atk_prerequisites.yml` — search fixtures and pre-flight prerequisites.
- image assets used by media/entity example specs.

## Demo
Enable the `automated_testing_kit_demo` submodule (or apply the ATK Demonstration Recipe) to
scaffold a working demo test project automatically. See
[../../modules/automated_testing_kit_demo/2.0.x/agent/start.md](../../modules/automated_testing_kit_demo/2.0.x/agent/start.md).

## Example specs
`cypress/e2e/**` and `playwright/e2e/**` mirror the same suites: `atk_register_login`,
`atk_entity/{node,media,taxonomy,user}`, `atk_caching`, `atk_contact_us`, `atk_page_error`,
`atk_search`, `atk_sitemap`, `atk_menu`. Copy and adapt them; they are examples, not a locked
suite.
