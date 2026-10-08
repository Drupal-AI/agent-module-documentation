# Extend — the interception mechanism

## How mail is intercepted

`reroute_email.module` implements `hook_mail_alter()` and uses
`hook_module_implements_alter()` to force its implementation to run **last** (and to keep
`queue_mail` after it, so queued mail is still rerouted). The alter hook delegates to the
`RerouteEmailHandler` plugin manager:

```php
$manager = \Drupal::service('plugin.manager.reroute_email_handler');
$manager->processAllByType('hook_mail_alter', $message);
```

## The `RerouteEmailHandler` plugin type

- Manager: `Drupal\reroute_email\RerouteEmailHandlerPluginManager`
  (service `plugin.manager.reroute_email_handler`).
- Plugin dir: `src/Plugin/RerouteEmailHandler/`.
- Annotation: `@RerouteEmailHandler(id = "...", applied = {"hook_mail_alter"})` — `applied`
  lists the invocation contexts the plugin handles (`hook_mail_alter` or
  `symfony_mailer_adjuster`).
- Interface: `RerouteEmailHandlerPluginInterface`; base class
  `RerouteEmailHandlerPluginBase` (implements the shared `process()` / `processBody()` reroute
  logic; subclasses just adapt get/set of To/Cc/Bcc/headers/body to their transport).
- Bundled plugin: `HookMailAlter` (core `hook_mail_alter` messages). The
  `reroute_email_symfony_mailer` submodule adds a `SymfonyMailer` plugin for
  `symfony_mailer_adjuster`.

To support a new transport, subclass `RerouteEmailHandlerPluginBase`, implement the
getters/setters against your message object, and annotate with the appropriate `applied` type.

`processAllByType($applied_type, &$email, $reroute_proceed = TRUE, $update_body = TRUE, $reroute_settings = NULL)`
runs every plugin whose `applied` includes `$applied_type`; pass `$reroute_settings` to
override the global `reroute_email.settings` values.

## Alter registered handlers — `hook_reroute_email_handler_info_alter()`

Defined in `reroute_email.api.php`:

```php
function hook_reroute_email_handler_info_alter(array &$handlers) {
  // $handlers is keyed by plugin ID; adjust or remove definitions.
}
```

## Force / skip rerouting per message — `X-Rerouted-Force` header

Any module can add the `X-Rerouted-Force` header to a message (in `hook_mail()` or
`hook_mail_alter()`) to override the global settings for that message only:

- `X-Rerouted-Force: TRUE` — always reroute this message.
- `X-Rerouted-Force: FALSE` — never reroute this message.

The handler also writes diagnostic headers on processed mail: `X-Rerouted-Status`
(`REROUTED` / `NOT-REROUTED`), `X-Rerouted-Reason`, `X-Rerouted-Mail-Key`, `X-Rerouted-Website`,
and `X-Rerouted-Original-to` / `-cc` / `-bcc` preserving the original recipients.
