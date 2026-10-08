Submodule of Automated Testing Kit that scaffolds a runnable demonstration test project when the ATK Demonstration Recipe is applied.

---

automated_testing_kit_demo is a helper submodule that turns a fresh Drupal 11 site into a working Automated Testing Kit demo. It listens for the "Automated Testing Kit - Demonstration Recipe" being applied and, in response, runs the parent module's `atk_setup` script to copy Playwright tests and configuration into the project root, rewrites the generated `playwright.atk.config.js` Drush alias to `ddev drush` and the `playwright.config.js` `baseURL` to the current site URL, then runs cron to index content. Its install hook also runs cron. It is developer tooling for local and QA environments and should not be enabled on production.

---

- Stand up a ready-to-run Playwright demo of Automated Testing Kit on a local DDEV site.
- Automatically copy the kit's example tests and config files into your project root via `atk_setup`.
- Auto-configure the generated Playwright config to use `ddev drush` and the correct site base URL.
- Trigger site indexing (cron) after the demo recipe is applied so search/sitemap tests have data.
- Follow the RecipeEventSubscriber as a worked example of reacting to `RecipeAppliedEvent`.
- Provide a repeatable onboarding path for new QA engineers evaluating the kit.
- Use alongside the Automated Testing Kit Demonstration Recipe video/written tutorials.
