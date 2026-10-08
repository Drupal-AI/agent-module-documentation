# Hooks (`mailer_transport.api.php`)

## hook_mailer_transport_info_alter(array &$definitions)
Alter the discovered `TransportUI` plugin definitions — add, remove, or change which
transport types can be created. Registered via the manager's
`alterInfo('mailer_transport_info')`.

```php
function my_module_mailer_transport_info_alter(array &$definitions): void {
  // e.g. remove the null transport in production
  unset($definitions['null']);
}
```

To add a new transport type, write a `#[TransportUI]` plugin rather than altering here — see
[../plugins/transport-ui.md](../plugins/transport-ui.md).
