# Configure mail backends

UI: `/admin/config/system/mailsystem` (route `mailsystem.settings`, form
`Drupal\mailsystem\Form\AdminForm`). Config object: `mailsystem.settings`.

Each choice is a pair of core mail plugins (any class implementing `MailInterface`, keyed by
plugin id, e.g. `php_mail`, `swiftmailer`, `mime_mail`):

- **formatter** — builds the message body/headers (`format()`).
- **sender** — actually sends it (`mail()`).

Config schema (`mailsystem.settings`):
```yaml
theme: default            # 'default' | 'current' | 'domain' | a theme machine name
defaults:
  sender: php_mail
  formatter: php_mail
modules:                  # optional per-module / per-key overrides
  <module>:
    <key>:                # '_default' applies to all keys of the module
      sender: swiftmailer
      formatter: mime_mail
```

- **Default**: formatter + sender used when no override matches.
- **Per module / per key**: on the form, add a module, optionally a specific mail key, and set
  its formatter/sender. `_default` covers every key of that module.
- **Theme**: which theme renders HTML mail — `default` (site default theme), `current` (active
  theme at send time), or a specific theme. Resolved by `mailsystem_get_mail_theme()`.
- Settings are exportable config; deploy them like any other config.
- Contrib backends (SMTP, Swift/Symfony Mailer, Mime Mail, Mailgun…) register the plugins you
  select here — install them first, then choose them on this form.
