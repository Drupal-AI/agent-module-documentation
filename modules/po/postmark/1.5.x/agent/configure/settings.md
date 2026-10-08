# Configure Postmark

## 1. Select the mail plugin (Mail System)

Postmark only sends mail once Mail System routes messages to it. Go to
`/admin/config/system/mailsystem` and set the **Formatter** and/or **Sender** to
`Postmark mailer` (`postmark_mail`) — site-wide or for a specific module key. `hook_install()`
also registers `postmark` in `system.mail:interface`.

## 2. Postmark settings form

Route `postmark.settings` → `/admin/config/mail/postmark` (permission `administer postmark`,
`restrict access: TRUE`). Config object `postmark.settings`:

| Key | Type | Purpose |
|---|---|---|
| `postmark_api_key` | string (required) | Postmark **Server** API token used by `PostmarkClient`. |
| `postmark_sender_signature` | string (required) | Verified Postmark Sender Signature email; used as the From on every send. |
| `postmark_debug_mode` | bool | Enable debug logging + debug-email redirect. |
| `postmark_debug_email` | string | When debug mode is on, ALL mail is delivered to this address instead of the real recipient. |
| `postmark_debug_no_send` | bool | "No-send" test mode: reports success without calling the API (no Postmark credit used). |
| `format_filter` | string (text format id) | Optional; body is run through `check_markup()` with this format in `PostmarkMail::format()`. |

The form also has a **Test email** field (`test_address`, not stored) that sends a one-off test
message from the Sender Signature to that address on submit.

### Drush / config

```bash
drush config:set postmark.settings postmark_api_key   'server-token-here' -y
drush config:set postmark.settings postmark_sender_signature 'noreply@example.com' -y
```

Prefer keeping the token out of exported config by overriding it in `settings.php`:
`$config['postmark.settings']['postmark_api_key'] = getenv('POSTMARK_API_KEY');`

## Runtime requirements

`hook_requirements()` (Status report) reports:
- ERROR if `\Postmark\PostmarkClient` (the `wildbit/postmark-php` library) is missing.
- WARNING if the library is present but API token or Sender Signature is empty.
- OK when both are configured.
