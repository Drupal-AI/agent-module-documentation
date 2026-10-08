# Configure LDAP authorization (group → role mapping)

## How it fits together

This submodule provides one plugin — `@AuthorizationProvider(id = "ldap_provider")`,
`Drupal\ldap_authorization\Plugin\authorization\Provider\LDAPAuthorizationProvider` (extends
the Authorization module's `ProviderPluginBase`). There is **no `ldap_authorization` admin
page**; you configure it through the **Authorization** module's profiles, where you pair the
`ldap_provider` **provider** with a **consumer** (typically the Drupal-roles consumer) and add
mappings.

Plugin capabilities: `syncOnLogonSupported = TRUE` (re-evaluate on each login),
`revocationSupported = TRUE` (remove roles when the group is lost), and it declares handlers
`['ldap', 'ldap_authentication']`. It uses `ldap_servers`' `LdapGroupManager` to read (optionally
nested) group memberships and `ldap_user`'s `DrupalUserProcessor` for the account.

## Provider settings — `authorization.provider.plugin.ldap_provider`

| Key | Meaning |
|---|---|
| `status.server` | Machine name of the `ldap_server` to read groups from |
| `status.only_ldap_authenticated` | Apply the role configuration only to users authenticated via LDAP |
| `filter_and_mappings.use_first_attr_as_groupid` | Convert a full DN to the value of its first attribute before matching |

## Per-row mappings — `authorization.provider_mappings.plugin.ldap_provider`

| Key | Meaning |
|---|---|
| `query` | The LDAP group DN/value to match (e.g. `cn=admins,ou=groups,dc=example,dc=org`) |
| `is_regex` | Treat `query` as a regular expression to match many groups |

Each mapping row ties an LDAP group (or regex) on the provider side to a consumer authorization
(e.g. a Drupal role) on the other side of the Authorization profile. All of this is config, so
it exports with `drush config:export`. To enable: `drush en ldap_authorization -y` (pulls in
`authorization`), then build an Authorization profile.
