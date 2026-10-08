# Reroute Email for Symfony Mailer — mechanism

Enable with `drush en reroute_email_symfony_mailer -y` (pulls in `reroute_email` and
`symfony_mailer`). Once enabled, mail sent through the Symfony Mailer transport is rerouted
using the same `reroute_email.settings` as the parent module. No new settings route — it reuses
`reroute_email.settings`.

## Why the submodule exists

Core Reroute Email intercepts mail in `hook_mail_alter()`. Symfony Mailer builds and sends
mail through its own adjuster pipeline and never invokes `hook_mail_alter()`, so this submodule
plugs the reroute logic into Symfony Mailer's pipeline instead.

## Plugins provided

- **`RerouteEmailHandler` plugin — `SymfonyMailer`** (`applied = {"symfony_mailer_adjuster"}`).
  Subclasses `RerouteEmailHandlerPluginBase`, adapting the shared reroute logic to Symfony
  Mailer's `EmailInterface` (get/set To/Cc/Bcc, headers, text & HTML body). Aborting a message
  throws `Drupal\symfony_mailer\Exception\SkipMailException`.
- **`EmailAdjuster` plugin — id `reroute_email`** (`RerouteEmailAdjuster`). Runs the handler
  during `build()` (reroute) and `postRender()` (body update) via
  `plugin.manager.reroute_email_handler->processAllByType('symfony_mailer_adjuster', $email, ...)`.
  Its settings form offers **Use global configuration** (checkbox, default on → uses
  `reroute_email.settings`) or per-policy overrides (address, allowlist, roles, mail-key
  filters), built by reusing `SettingsForm::buildSettingsForm()`.
- **`EmailBuilder` plugin — id `reroute_email`**, sub-type `test_email_form`,
  `common_adjusters = {"reroute_email"}`. Lets the Reroute Email test form send through
  Symfony Mailer (`email_factory->sendTypedEmail('reroute_email', 'test_email_form', $params)`).

## Hooks in the submodule

- `hook_form_reroute_email_test_email_form_alter()` — displays the mailer policy on the test
  form and swaps the submit handler to send via `email_factory`.
- `hook_mailer_adjuster_info_alter()` — bumps the `reroute_email` adjuster weight to
  `max(weight) + 100` so it runs after every other adjuster.

Config schema: `symfony_mailer.email_adjuster_plugin.reroute_email` (keys: `use_global`,
`address`, `roles`, `allowed`, `description`, `message`, `mailkeys`, `mailkeys_skip`).
