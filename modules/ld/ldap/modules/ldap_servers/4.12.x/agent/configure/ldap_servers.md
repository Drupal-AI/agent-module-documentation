# Configure LDAP servers

## The `ldap_server` config entity

`Drupal\ldap_servers\Entity\Server` — `@ConfigEntityType(id = "ldap_server")`, config prefix
`server` (config names `ldap_servers.server.<id>`), `admin_permission = "administer ldap"`.
Managed via routes under `/admin/config/people/ldap/server`:

| Route | Path | Purpose |
|---|---|---|
| `entity.ldap_server.collection` | `/server` | List servers (**the `configure` route**) |
| `entity.ldap_server.add_form` | `/server/add` | Add |
| `entity.ldap_server.edit_form` | `/server/{ldap_server}` | Edit |
| `entity.ldap_server.delete_form` | `/server/{ldap_server}/delete` | Delete |
| `entity.ldap_server.test_form` | `/server/{ldap_server}/test` | Test bind + sample lookup |
| `entity.ldap_server.enable_disable_form` | `/server/{ldap_server}/enable_disable` | Toggle status |
| `ldap.settings` | `/admin/config/people/ldap` | LDAP menu root |
| `ldap_servers.debug_settings` | `/admin/config/people/ldap/debug` | Debug settings form |
| `ldap_servers.debug_report` | `/admin/config/people/ldap/debug/report` | Debug report |

## Key entity fields (config_export)

Connection: `type`, `address`, `port`, `encryption` (`none`/`ssl`/`tls`), `timeout`,
`bind_method`, `binddn`, `bindpw`, `basedn` (sequence of base DNs), `user_dn_expression`
(required when binding with the user's own credentials), `status`, `weight`.

User identity: `user_attr` (login attribute), `account_name_attr`, `mail_attr`,
`mail_template`, `picture_attr`, `unique_persistent_attr` (PUID) +
`unique_persistent_attr_binary`.

Groups: `grp_unused`, `grp_object_cat`, `grp_nested`, `grp_user_memb_attr_exists`,
`grp_user_memb_attr`, `grp_memb_attr`, `grp_memb_attr_match_user_attr`,
`grp_derive_from_dn`, `grp_derive_from_dn_attr`. Testing helpers: `testing_drupal_username`,
`testing_drupal_user_dn`, `grp_test_grp_dn`, `grp_test_grp_dn_writeable`.

Schema: `config/schema/server.schema.yml`. Because it is a config entity, servers export with
`drush config:export`. List/create via drush: `drush config:get ldap_servers.server.<id>`.

## Module settings — `ldap_servers.settings`

| Key | Default | Meaning |
|---|---|---|
| `watchdog_detail` | `false` | Enable verbose LDAP logging (via `ldap.detail_log`) |

Toggle it on the debug settings form (`/admin/config/people/ldap/debug`) or
`drush cset ldap_servers.settings watchdog_detail 1`.
