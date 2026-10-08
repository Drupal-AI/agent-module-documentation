# Configure LDAP authentication

Config object: **`ldap_authentication.settings`** (schema in `config/schema`). Edit at
`/admin/config/people/ldap/authentication` (`ldap_authentication.admin_form`) or with
`drush cset ldap_authentication.settings <key> <value>`. Gated by `administer ldap`.

## Key settings (defaults from `config/install`)

| Key | Default | Meaning |
|---|---|---|
| `authenticationMode` | `mixed` | `mixed` = LDAP + local accounts; exclusive = LDAP only |
| `sids` | `{}` | Enabled LDAP server ids used for authentication (resolved by `AuthenticationServers`) |
| `allowOnlyIfTextInDn` | `[]` | Whitelist: allow login only if the user DN contains this text |
| `excludeIfTextInDn` | `[]` | Blacklist: deny login if the user DN contains this text |
| `excludeIfNoAuthorizations` | `null` | Deny login to users who receive no authorizations |
| `skipAdministrators` | `true` | Admin accounts bypass LDAP (avoids lockout) |
| `emailOption` | `disable` | How the email field behaves for LDAP users |
| `emailUpdate` | `update_notify` | Update the Drupal email from LDAP and notify the user |
| `passwordOption` | `hide` | Password field handling on the UI |
| `emailTemplateHandling` | `none` | Whether to apply an email template |
| `emailTemplate` | `@username@example.com` | Template used when the directory has no mail attribute |
| `emailTemplateUsagePromptRegex` | `.*@example\.com` | Regex deciding when to prompt for a real email |
| `loginUIUsernameTxt` / `loginUIPasswordTxt` | `''` | Custom login-form help text |
| `ldapUserHelpLinkUrl` / `ldapUserHelpLinkText` | `''` | Help link shown to directory users |

## Runtime pieces

- **Routes:** `ldap_authentication.admin_form` (settings); `ldap_authentication.profile_update_form`
  → `/user/ldap-profile-update` (self-service email update); `ldap_authentication.ldap_help_redirect`.
- **Services** (`ldap_authentication.services.yml`): `ldap_authentication.login_validator`
  (`LoginValidatorLoginForm`) validates the standard login; `ldap_authentication.login_validator_sso`
  (`LoginValidatorSso`) handles SSO; `ldap_authentication.servers` (`AuthenticationServers`)
  resolves the enabled server list; a `RouteSubscriber` and `EmailTemplateService` are event
  subscribers; `UserHelpTabAccess` is an access checker for the help tab.
- Successful validation hands off to `ldap_user`'s `ldap.drupal_user_processor` to associate
  or provision the Drupal account.
