# Plugin type: MailerMail (define a coded email)

One `MailerMail` plugin = one reusable email. Managed by `plugin.manager.mailer_mail`
(extends `DefaultPluginManager`). Discovery: annotation `@MailerMail`, classes under
`src/Plugin/MailerMail/`, interface `MailerMailPluginInterface`, base
`MailerMailPluginBase`. Alter hook: `hook_mailer_mail_info(&$definitions)`. Cache key
`mailer_mail_plugins`.

## Annotation (`Drupal\mailer\Annotation\MailerMail`)
- `id` (string) — plugin id (also drives the mail key, below).
- `label` (Translation).
- `templates` (string[]) — one or more Twig paths **without** the `.html.twig` extension,
  relative to the Drupal root as `module_name/path/to/template`
  (e.g. `mailer/templates/mailermail--base`). `getTemplate()` returns `templates[0]` by
  default; override to choose dynamically. Each listed template is auto-registered as a
  theme hook by `mailer_theme()` with key `<plugin_id>_<template_basename>` and a single
  `config` variable.
- `config` (string) — fully-qualified config class; must implement
  `MailerMailConfigInterface` (extend `MailerMailConfigBase`). See api/sending.md.

## Minimal plugin
```php
namespace Drupal\my_module\Plugin\MailerMail\Welcome;

use Drupal\mailer\Plugin\MailerMailPluginBase;

/**
 * @MailerMail(
 *   id = "welcome_email",
 *   label = @Translation("Welcome email"),
 *   templates = { "my_module/templates/welcome" },
 *   config = "\Drupal\mailer\Plugin\MailerMailConfigBase"
 * )
 */
class Welcome extends MailerMailPluginBase {}
```
Add `my_module/templates/welcome.html.twig` (extend/copy `mailer/templates/mailermail--base`;
the template reads `config.title`, `config.message`, `config.siteLogo`, `config.frontPageUrl`).

## Customizing
- Extra template data → subclass `MailerMailConfigBase`, add getters/setters, point the
  annotation's `config` at it (see api/sending.md and the `mailer_example` ExtendedExample).
- Dynamic template → override `getTemplate()` (e.g. return `templates[0]` for anonymous,
  `templates[1]` for authenticated).
- Extra services in the plugin → override `__construct()`/`create()` (call parent).

## Overridable `MailerMailPluginInterface` methods
`getMessage()` (render body), `getMailKey()`, `getConfig()`, `getTemplate()`, `send()`.
