<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The default recipe

Source: `recipes/default/recipe.yml` (type `install`). Applied by `websecurity_install($is_syncing)`
in `websecurity.install` via `RecipeRunner::processRecipe(Recipe::createFromDirectory(__DIR__ . '/recipes/default'))`,
**unless** the module is being installed during a config sync (`\Drupal::isConfigSyncing()` returns early)
or as part of another recipe run (`$is_syncing` true — the recipe is already applying). After the recipe,
`FriendlyCaptchaKeysSubscriber::setKeys()` runs (see `api/friendlycaptcha-keys.md`).

## Modules the recipe installs (`install:`)
`recaptcha_v3`, `flood_control`, `honeypot`, `antibot`, `captcha`, `friendlycaptcha`, `seckit`,
`security_review`, `klaro`, `token`, `bpmn_io`, `eca_base`, `eca_form`, `eca_misc`, `eca_user`,
`login_emailusername`, and finally `websecurity` itself.

## Config imported from other modules (`config.import`)
- `recaptcha_v3: '*'`, `flood_control: '*'`, `antibot: '*'` — import all shipped config.
- `captcha: [captcha.captcha_point.user_register_form]` — the register-form CAPTCHA point.
- `strict: false` — respects a site owner's existing active config where it differs.

## Config actions (`config.actions`)
- `recaptcha_v3.settings` → set `langcode: en`.
- `captcha.settings` → `default_challenge: friendlycaptcha/friendlycaptcha`.
- `captcha.captcha_point.user_register_form` → `setStatus: true` (CAPTCHA shown on user registration).
- `friendlycaptcha.settings` → `api_endpoint: local`, `enable_validation_logging: false`
  (site/API keys are left empty here and filled with random values by the subscriber).
- `system.site` → `page.403: '/user/login'` (access-denied redirects to login).
- `user.role.authenticated` → **grantPermissions**: `bypass honeypot protection`, `skip antibot`,
  `skip CAPTCHA` (logged-in users are treated as trusted and skip the anti-bot challenges).
- `honeypot.settings` → `protect_all_forms: false`, `log: true`, `element_name: url`, `time_limit: 2`,
  `expire: 300`; protects `user_register_form`, `user_login_form`, `user_pass`, `node_webform_form`,
  `comment_comment_form`, webforms; leaves `search_form`, `search_block_form`, `views_exposed_form`,
  `honeypot_settings_form` unprotected.
- `seckit.settings` → CSP checkbox off (empty CSP directives, report-uri `report-csp-violation`);
  `x_xss.select: 2`; clickjacking `x_frame: "1"` (SAMEORIGIN), JS/CSS/noscript defense off;
  HSTS off; CSRF origin check off; `disable_autocomplete: true`.
- `user.flood` → `uid_only: false`, `ip_limit: 10`, `ip_window: 1800`, `user_limit: 8`,
  `user_window: 1800` (login flood thresholds).
- `security_review.settings` → `untrusted_roles: [anonymous]`, `log: true`.

Because the recipe is `type: install` and applies with the config installer in syncing mode, each
bundled module's own `hook_install()` does not re-apply sibling recipes — the module list and config
imports above are explicit for that reason.
