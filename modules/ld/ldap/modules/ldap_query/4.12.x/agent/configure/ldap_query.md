# Configure LDAP queries

## The `ldap_query_entity` config entity

`Drupal\ldap_query\Entity\QueryEntity` — `@ConfigEntityType(id = "ldap_query_entity")`, config
prefix `ldap_query_entity`, `admin_permission = "administer ldap"`. Routes:

| Route | Path | Purpose |
|---|---|---|
| `entity.ldap_query_entity.collection` | `/admin/config/people/ldap/query` | List (**the `configure` route**) |
| `entity.ldap_query_entity.add_form` | `/query/add` | Add |
| `entity.ldap_query_entity.edit_form` | `/query/{ldap_query_entity}/edit` | Edit |
| `entity.ldap_query_entity.delete_form` | `/query/{ldap_query_entity}/delete` | Delete |
| `entity.ldap_query_entity.test` | `/query/{ldap_query_entity}/test` | Run & show raw results |

(Add/edit/delete routes come from `QueryEntityHtmlRouteProvider`; the test route is in
`ldap_query.routing.yml`.)

## Fields (config_export)

| Field | Meaning |
|---|---|
| `server_id` | Which `ldap_server` to run against |
| `base_dn` | Base DN(s) to search under |
| `filter` | LDAP filter, e.g. `(objectClass=person)` |
| `attributes` | Attributes to return |
| `scope` | Search scope (subtree / one level / base) |
| `size_limit` | Max entries returned |
| `time_limit` | Max seconds |
| `dereference` | Alias dereference behaviour |
| `status` | Enabled/disabled |

Schema: `config/schema/ldap_query_entity.schema.yml`. Queries are config, so they export with
`drush config:export`.

## Views integration

The module registers a custom Views query backend (`Plugin/views/query/LdapQuery`) plus field,
filter, sort and argument handlers (`Plugin/views/{field,filter,sort,argument}/LdapAttribute`
and `LdapVariableAttribute`, plus `LdapVariableImageAttribute`). Create a View on the LDAP
query base table to list directory entries, filter/sort by attribute, and render photo
attributes as images. Integration is wired in `ldap_query.views.inc`.
