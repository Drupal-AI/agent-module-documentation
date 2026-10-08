<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RecipeEventSubscriber

Source: `src/EventSubscriber/RecipeEventSubscriber.php`. Service
`automated_testing_kit_demo.recipe_subscriber` (`automated_testing_kit_demo.services.yml`), tagged
`event_subscriber`.

## Subscribed event
`getSubscribedEvents()` → `\Drupal\Core\Recipe\RecipeAppliedEvent::class => ['onRecipeApplied']`.
Fires only when a Drupal Recipe finishes applying (a CLI/admin operation).

## onRecipeApplied(RecipeAppliedEvent $event)
Guards on `$event->recipe->name === 'Automated Testing Kit - Demonstration Recipe'` — does nothing
for any other recipe. When it matches:
1. Logs the current working directory.
2. Runs the parent kit's scaffold script:
   `export ATK_HOME=.. && modules/contrib/automated_testing_kit/module_support/atk_setup playwright`
   via `shell_exec()` (fixed command string; no event/user data interpolated).
3. Rewrites the generated config for DDEV using `replaceLineInFile()`:
   - `../playwright.atk.config.js` → `drushCmd: "ddev drush",`
   - `../playwright.config.js` → `baseURL: '<protocol>://<host>/'` where protocol/host come from
     `$_SERVER['HTTPS']` / `$_SERVER['HTTP_HOST']`.
4. Runs `cron` (`$this->cron->run()`) to index the site.

## replaceLineInFile(string $filepath, string $searchKey, string $replacementLine): bool
Static helper. Returns false if the file is missing or not writable; reads the file into lines,
finds the first line containing `$searchKey`, preserves that line's line-ending, replaces it, and
writes back. Returns true on success.

## Constructor note
Declared `__construct(LoggerChannelFactoryInterface $logger_factory, CronInterface $cron)` but the
service definition also passes `@messenger` as a third argument; the `$messenger` property is never
initialised. No functional impact at runtime today.
