# Configuration

Config object `cas.settings` (schema `config/schema/cas.schema.yml`), form at
`/admin/config/people/cas` (route `cas.settings`). Read with
`drush config:get cas.settings`. Grouped mappings:

## `server` — CAS server connection
`version` (`1.0`/`2.0`/`3.0`), `protocol` (`http`/`https`), `hostname`, `port`,
`path`, `verify` (SSL verification: 0/1/2, see `SslCertificateVerification`), `cert`
(PEM cert path).

## `gateway` — transparent SSO check
`enabled`, `recheck_time` (minutes, -1..1440), `paths` (request_path condition),
`method` (`server_side`/`client_side`).

## `forced_login` — require CAS on paths
`enabled`, `paths` (request_path condition).

## `user_accounts` — provisioning
`prevent_normal_login`, `auto_register`,
`auto_register_follow_registration_policy`, `email_assignment_strategy` (0/1),
`email_hostname`, `email_attribute`, `auto_assigned_roles` (list),
`restrict_password_management`, `restrict_email_management`,
`admin_bypass_password_email_restrictions`.

## Other groups
`login_link_enabled` / `login_link_label` / `login_success_message`;
`error_handling`; `logout` (single logout); `proxy` (proxy auth); `advanced`.

Example:
```
drush config:set cas.settings server.hostname sso.example.edu -y
drush config:set cas.settings user_accounts.auto_register true -y
```
The bulk "add CAS users" form lives at route `cas.bulk_add_cas_users`.
