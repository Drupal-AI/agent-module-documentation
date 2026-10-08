<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email Manager — templates & keys

## Permission
Every route requires `administer email templates` (`restrict access: true`). Grant only to trusted admins — templates are HTML rendered into outbound mail.

## Keys
`/admin/config/system/email-manager/keys` lists `module:key` pairs. Keys are auto-discovered by `EmailManagerKeyCollector`; add ones discovery misses with:
```php
function hook_email_manager_keys_alter(array &$email_keys) {
  $email_keys['mymodule:welcome'] = 'Welcome (mymodule)';
}
```

## Templates
`/admin/config/system/email-manager` → add/edit. Each `EmailTemplate` config entity binds to a key and stores a subject + CKEditor HTML body. Tokens (core + `email_manager:module` / `email_manager:key`) are replaced at send time.

## Delivery
`EmailManagerMail` (Mail plugin) intercepts a message, looks up the template for its `module`/`key`, applies token replacement, and formats the body as HTML. Configure it as the mail plugin for the target key(s) via the mail system settings.
