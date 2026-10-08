# Sending a mail + the config object

## Send (3 steps)
```php
$manager = \Drupal::service('plugin.manager.mailer_mail');
$mail = $manager->createInstance('welcome_email');   // plugin id from @MailerMail
$config = $mail->getConfig();                         // the config object (defaults filled)
$config->setTo('user@example.com');
$config->setSubject('Welcome');
$config->setMessage('Thanks for joining.');           // becomes {{ config.message }} in the template
$ok = $mail->send();                                  // bool
```
Inject `plugin.manager.mailer_mail` in real code rather than `\Drupal::service`.

## What `send()` does (`MailerMailPluginBase`)
1. Renders the plugin's template (via `getMessage()`, using `renderInIsolation()` on D10.3+,
   else `renderPlain()`), under the config's langcode.
2. Builds params (`message`, `title`=subject, `from`, optional `attachments`).
3. Calls core mail: `mail_manager->mail('mailer', $key, $to, $langcode, $params, $reply, TRUE)`
   where `$key = 'mailer_mail_' . <plugin id>` (`getMailKey()`).
4. If `mailer_storage` is enabled, saves the sent mail as a `mailer_storage` entity.
5. Logs success/failure to the `mailer` logger channel; returns `TRUE`/`FALSE`.

`hook_mail()` (`mailer_mail`) maps params for any key containing `mailer_mail`: sets
`from`, `subject` (from `title`), appends `message` to body, forces
`Content-Type: text/html; charset=UTF-8; format=flowed; delsp=yes`, and passes `attachments`
as `params['files']`.

Other useful base methods: `getMessage()` (render body to string without sending),
`getParams()`, `getMailKey()`, `getConfig()`, `getDefaultConfig()`.

## Config object — `MailerMailConfigBase` (implements `MailerMailConfigInterface`)
Holds the data handed to the Twig template as `config`. Constructed with defaults from
`system.site`: `subject` = "You received a new email from <site name>", `to` and `from` =
site email. Set values before calling `send()`.

Getters: `getSubject()`, `getMessage()`, `getTo()`, `getFrom()`, `getReplyEmail()`
(falls back to `from`), `getTitle()` (falls back to `subject`), `getLangcode()`
(recipient user's preferred langcode, else site default), `getAttachments()`,
`getSiteLogo()`, `getFrontPageUrl()`, `getToUserLangcode()`.

Setters: `setSubject()`, `setMessage(string)`, `setTo()`, `setFrom()`, `setReplyEmail()`,
`setTitle()`, `setLangcode()` (auto if null), `setAttachments()`, `setSiteLogo()`,
`setFrontPageUrl()`.

Custom config class: extend `MailerMailConfigBase`, add fields + getters/setters, add extra
services by overriding `__construct()`/`create()` (call parent), and reference the class in
the plugin's `@MailerMail` `config` key. Its getters are readable in the template as
`config.<camelCaseName>`.

## Admin page
`mailer.configuration` (`/admin/config/system/mailer-module`, permission `access content`)
renders a read-only bullet list of defined plugin IDs. No settings are stored.
