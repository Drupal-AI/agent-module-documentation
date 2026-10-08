# Configure SMTP

![SMTP settings form](../../../../../../../screenshots/smtp/1.4.x/settings.png)

Settings form at `/admin/config/system/smtp` (route `smtp.config`, permission
`administer smtp module`). Config object `smtp.settings`:

```yaml
smtp_on: false                # master on/off (turns the SMTP mail system on)
smtp_host: ''                 # SMTP server hostname
smtp_hostbackup: ''           # optional failover host
smtp_port: '25'
smtp_protocol: 'standard'     # standard | ssl | tls
smtp_autotls: true
smtp_timeout: 30
smtp_username: ''
smtp_password: ''             # stored in config; use a secure workflow
smtp_from: ''                 # default From address
smtp_fromname: ''             # default From name
smtp_client_hostname: ''      # client hostname for the handshake
smtp_client_helo: ''          # custom HELO/EHLO string
smtp_allowhtml: false
smtp_test_address: ''         # used by the "send test email" button
smtp_reroute_address: ''      # if set, ALL mail is redirected here (staging)
smtp_debugging: false
smtp_debug_level: 1
prev_mail_system: 'php_mail'  # restored when SMTP is turned off
smtp_keepalive: false
```

- Turning `smtp_on` on swaps Drupal's `mailsystem`/plugin.manager.mail default to
  `SMTPMailSystem` and saves the previous one in `prev_mail_system`.
- Connectivity is validated by `Drupal\smtp\ConnectionTester\ConnectionTester`; the form's test
  button sends to `smtp_test_address`.
- Set via drush, e.g. `drush config:set smtp.settings smtp_on true`.
- See [extend/mail-plugin.md](../extend/mail-plugin.md) for how it hooks into mail delivery.
