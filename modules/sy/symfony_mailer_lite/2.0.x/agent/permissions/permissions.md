# Permissions

From `symfony_mailer_lite.permissions.yml`:

- **`administer symfony_mailer_lite configuration`** (`restrict access: true`) — gates all
  transport add/edit/delete/set-default pages, the message settings form, and the test-email
  form. Transport edit/delete/set-default routes also enforce `_entity_access` on the transport
  config entity (`TransportAccessControlHandler`).

Only trusted admins should hold this permission (it exposes SMTP credentials and sending
config).
