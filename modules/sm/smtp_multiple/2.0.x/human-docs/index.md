# SMTP Authentication Support (multiple) — manual setup guide

**SMTP Authentication Support (multiple)** (`smtp_multiple`) extends the
contributed **SMTP** module so that different outgoing mail can be sent through
different SMTP servers or accounts, chosen **per email key**. Every mail Drupal
sends carries a "key" that identifies what it is (for example the module and mail
id that generated it, like `comment_notify_comment_notify_mail`). Normally the
SMTP module uses one server for all of them; this module replaces SMTP's mail
backend so you can map particular keys to their own SMTP host, port, protocol,
credentials, and From address.

That's useful when different mail streams should go out through different
providers or accounts — for example transactional mail via one relay and
notification or marketing mail via another, or a specific module's mail through a
dedicated mailbox. It depends on the **SMTP** module and has no submodules.

There is **no admin settings form** — configuration is done in code, either in
your site's `settings.php` / `settings.local.php` or through an alter hook (see
"How to configure it" below). Because each configuration contains SMTP server
credentials, treat those as **secrets**: keep them in `settings.local.php` (or an
environment variable referenced from settings) rather than in exported
configuration, and make sure your SMTP connections use TLS/SSL or STARTTLS. The
module has no content‑access role.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus its SMTP dependency).

## How to configure it

Configuration is entirely in code, keyed by the email key.

**Option A — in `settings.php` / `settings.local.php`:** add a
`smtp_multiple_config` array for each key you want to override. For a key called
`email_key`:

```php
$settings['smtp_multiple_config']['email_key']['smtp_host'] = 'smtp.gmail.com';
$settings['smtp_multiple_config']['email_key']['smtp_port'] = '465';
$settings['smtp_multiple_config']['email_key']['smtp_protocol'] = 'ssl';
$settings['smtp_multiple_config']['email_key']['smtp_username'] = 'user@gmail.com';
$settings['smtp_multiple_config']['email_key']['smtp_password'] = 'pass';
$settings['smtp_multiple_config']['email_key']['smtp_from'] = 'user@gmail.com';
$settings['smtp_multiple_config']['email_key']['smtp_fromname'] = 'Me';
```

**Option B — via a hook** in a custom module, which lets you decide the SMTP
settings dynamically per key:

```php
function my_module_smtp_multiple_config_alter(array &$config, $key) {
  if ($key === 'comment_notify_comment_notify_mail') {
    $config['smtp_host'] = 'smtp.gmail.com';
    $config['smtp_port'] = '465';
    $config['smtp_protocol'] = 'ssl';
    $config['smtp_username'] = 'user@gmail.com';
    $config['smtp_password'] = 'pass';
    $config['smtp_from'] = 'user@gmail.com';
    $config['smtp_fromname'] = 'Me';
  }
}
```

Any key you don't override continues to use the base SMTP module's settings.
Keep the credentials above in `settings.local.php` (uncommitted) or pull them
from environment variables — don't hard‑code real passwords into version control.
