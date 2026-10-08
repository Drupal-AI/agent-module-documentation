# ldap_query — agent start

Stores reusable LDAP searches as **`ldap_query_entity`** config entities and exposes their
results to code (`ldap.query`) and to Views. Depends on `ldap_servers`, core `views`. Config
UI: **Admin → Config → People → LDAP → Queries** (`/admin/config/people/ldap/query`, route
`entity.ldap_query_entity.collection`); permission `administer ldap`. Defines no permissions of
its own.

- The `ldap_query_entity`, its fields, routes & Views integration → [configure/ldap_query.md](configure/ldap_query.md)
- Run a stored query in code (`ldap.query` / `QueryController`) → [api/ldap_query.md](api/ldap_query.md)
