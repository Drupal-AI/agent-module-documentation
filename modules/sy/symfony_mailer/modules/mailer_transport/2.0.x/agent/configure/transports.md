# Configure transports

## Where
`/admin/config/system/mailer/transport` — list (route
`entity.mailer_transport.collection`, `TransportListBuilder`). Add:
`/admin/config/system/mailer/transport/add/{plugin_id}` (`mailer_transport.add`); edit
`{mailer_transport}` (`mailer_transport.edit`); delete `…/delete`; set default
`…/set-default`. All gated by `administer mailer`.

## The config entity
`@ConfigEntityType(id = "mailer_transport")`, class
`Drupal\mailer_transport\Entity\Transport`. Fields depend on the chosen TransportUI plugin.
The site default is stored in `mailer_transport.settings:default_transport`.

```yaml
# mailer_transport.mailer_transport.smtp.yml
id: smtp
label: 'SMTP'
plugin: smtp
configuration:
  user: 'apikey'
  pass: '...'        # keep secrets out of exported config
  host: 'smtp.example.com'
  port: 587
```

## Choosing a transport per email
The default transport applies to all mail; to send a specific email type through another
transport, add a `transport` (`email_transport`) adjuster in a Mailer Policy (see the
mailer_policy docs). Dispatch is handled by `MultiTransport` /
`UnifiedTransportFactoryInterface`.

## Notes
- Use the base module's verify page (`/admin/config/system/mailer`) to test a transport.
- `sendmail` transport validates its command via
  `SendmailCommandValidationTransportFactory` before saving.
- The available add options come from the TransportUI plugins — see
  [../plugins/transport-ui.md](../plugins/transport-ui.md).
