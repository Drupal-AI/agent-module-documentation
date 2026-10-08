# Permissions & route access checks

## Permission

| Permission | Restricted | Gates |
|---|---|---|
| `administer mailchimp transactional` | yes (`restrict access: true`) | The settings form (`mailchimp_transactional.admin`) and the test-email form (`mailchimp_transactional.test`). |

Grant it with `drush role:perm:add <role> 'administer mailchimp transactional'`.

## Route access checks (services with `access_check` tags)

Two custom access checks live in `src/Access/` and apply only to the **test email** route
(`mailchimp_transactional.test`), in addition to the permission:

- `_mailchimp_transactional_configuration_access_check: 'TRUE'` →
  `ConfigurationAccessCheck::access()` — allowed only if `mailchimp_transactional.settings:api_key`
  is non-empty. So the test tab is unreachable until an API key is configured.
- `_mailchimp_transactional_mailer_access_check: 'TRUE'` → `MailerAccessCheck::access()` — allowed
  only if `mailsystem.settings:defaults.sender` is `mailchimp_transactional_mail` or
  `mailchimp_transactional_test_mail`. So the test tab requires Mail System to point the default
  sender at this mailer.

The submodules reuse `_mailchimp_transactional_configuration_access_check` on their admin routes
(activity list, template maps) and add their own permissions
(`administer mailchimp transactional activity`, `view mailchimp transactional activity`,
`administer mailchimp transactional templates`, and reports' `view mailchimp transactional
reports`).
