Automated Testing Kit (ATK) is a library of ready-made Cypress and Playwright end-to-end tests plus helper commands that drive Drush for testing Drupal sites.

---

ATK gives QA engineers and developers a starting library of about three dozen end-to-end test specs and two dozen reusable helper commands, written for both Cypress.io and Playwright, that exercise common Drupal functionality: authentication, entity CRUD, caching, search, sitemap, menus, error pages and more. The helpers wrap Drush (run locally, over SSH, or to Pantheon via Terminus) so tests can create and delete users, log in via a one-time-login link, read/write configuration and delete nodes without clicking through the UI. It adds a small Drupal module with two theme-preprocess hooks that expose node/term/media IDs to the rendered page so tests can locate them, a `file:properties` Drush command, and an `automated_testing_kit_demo` submodule (plus a Demonstration Recipe) that scaffolds a runnable test project in your repo root. AXE accessibility checks and Google Lighthouse performance checks are supported. Version 2.0 targets Drupal 11; it is developer/CI tooling meant for local, QA and CI environments, not production.

---

- Bootstrap an end-to-end testing practice on a Drupal 11 site with a ready-made Cypress or Playwright test suite instead of writing everything from scratch.
- Copy and adapt example specs for login, logout and new-user registration flows.
- Test the password-reset (forgot password) flow end to end.
- Verify the Contact Us / site-wide contact form submits and sends mail.
- Assert correct 404 (page not found) and 403 (access denied) responses.
- Confirm page caching behaviour and cache headers.
- Test node create/update/delete journeys through the UI and via Drush.
- Test media entity creation and reference (using the media ID exposed by the preprocess hook).
- Test taxonomy term create/update/delete.
- Test user account create/update/cancel journeys.
- Validate the XML sitemap output (with the XML Sitemap module).
- Test menu rendering and menu-link behaviour.
- Test site search results.
- Run FedRAMP-oriented compliance checks shipped as example specs.
- Create QA users from JSON fixtures (`data/qaUsers.json`) via `cy.createUserWithUserObject` / Drush `user:create`.
- Log in instantly as any user with a Drush one-time-login link (`logInViaUli` → `drush user:login --uid`) to skip form login in tests.
- Generate random throwaway users and strings for data-driven tests (`createRandomUser`, `createRandomString`).
- Look up a user's UID or username by email during a test (`getUidWithEmail`, `getUsernameWithEmail`).
- Read and write Drupal configuration from a test (`getDrupalConfiguration` / `setDrupalConfiguration` wrapping `drush cget`/`cset`).
- Delete users by email, UID or username, and delete nodes by NID, as test setup/teardown.
- Run Drush against local, remote-SSH, or Pantheon (Terminus) targets from the same test code via `execDrush`.
- Assert that a specific email was received using Mailpit or testmail.app (`expectEmail`).
- Add accessibility assertions to any page using the bundled AXE support.
- Add performance budgets to pages using Google Lighthouse support.
- Integrate with the QA Accounts module for standard test accounts.
- Scaffold a complete local demo test project quickly with the `automated_testing_kit_demo` submodule and Demonstration Recipe.
- Use the `file:properties` (`fprop`) Drush command to inspect a file's directory, size and timestamps as JSON in CI scripts.
