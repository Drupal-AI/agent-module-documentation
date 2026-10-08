# Hooks (`symfony_mailer.api.php`)

Emails pass through phases named in `EmailInterface::PHASE_NAMES`
(`init`, `build`, `pre_render`, `post_render`, `post_send`). Hooks fire per phase, and you
can scope them by the email's type/sub-type tag — from broad to specific:

## hook_mailer_PHASE(EmailInterface $email)
Runs for **every** email in that phase, e.g. `hook_mailer_init()`, `hook_mailer_build()`,
`hook_mailer_post_render()`, `hook_mailer_post_send()`.
```php
function my_module_mailer_post_send(EmailInterface $email): void {
  $to = $email->getHeaders()->get('To')->getBodyAsString();
  \Drupal::messenger()->addMessage(t('Sent to %to', ['%to' => $to]));
}
```

## hook_mailer_TYPE_PHASE(EmailInterface $email)
Only emails of a given base type. e.g. `hook_mailer_user_build()` for all user emails.

## hook_mailer_TYPE__SUBTYPE_PHASE(EmailInterface $email)
Only one sub-type. e.g. `hook_mailer_user__password_reset_pre_render()`.
(Note the double underscore between TYPE and SUBTYPE.)

## hook_symfony_mailer_info_alter(array &$mailers)
Alter the discovered component-mailer (`MailerInfo`) definitions — add, remove, or change
which mailer handles which tag.

Adjuster and override definitions have their own alter hooks in the respective submodules
(`hook_mailer_adjuster_info_alter`, `hook_mailer_transport_info_alter`,
`hook_mailer_override_info_alter`).
