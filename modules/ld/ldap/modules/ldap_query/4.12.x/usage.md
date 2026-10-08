LDAP Query stores reusable LDAP directory searches as `ldap_query_entity` config entities and exposes their results both to code (`ldap.query`) and to the Drupal Views UI, so other LDAP modules and site builders can run named directory searches.

---

Each stored query is an `ldap_query_entity` (config prefix `ldap_query_entity`) that pins a
server (`server_id`), a base DN (`base_dn`), an LDAP `filter`, the `attributes` to return, and
search parameters — `scope` (subtree/one-level/base), `size_limit`, `time_limit`, and
`dereference`. Queries are managed at **Admin → Config → People → LDAP → Queries**
(`/admin/config/people/ldap/query`, route `entity.ldap_query_entity.collection`) with add/edit/
delete plus a **Test** form (`entity.ldap_query_entity.test`) that runs the query and shows raw
results, all gated by `administer ldap`. Programmatically, the `ldap.query` service
(`QueryController`) loads a query by id, optionally overrides its filter, executes it against
the configured server via `ldap.bridge`, and returns Symfony `Entry[]` (`getRawResults()`) plus
the discovered field list (`availableFields()`). The module also ships a full set of Views
plugins — a custom `LdapQuery` query backend and matching field, filter, sort and argument
handlers (including "variable attribute" and image variants) — so an LDAP query can be surfaced
as a Drupal View. It is depended on by `ldap_user` (for the cron bulk-update query) and is the
building block for LDAP "feeds"/provision use cases. Requires `ldap_servers` and `views`.

---

- Save a reusable LDAP search (server + base DN + filter + attributes) as config.
- Run a directory search from code with the `ldap.query` service.
- Override a stored query's filter at runtime for dynamic searches.
- Return only the specific attributes you need from each entry.
- Limit results by size and time to protect the directory server.
- Choose search scope: subtree, one level, or base object.
- Control alias dereferencing for the search.
- Preview a query's raw results from the admin Test form.
- Surface LDAP entries in a Drupal View using the LDAP query backend.
- Add LDAP attributes as View fields, filters, sorts, and contextual arguments.
- Display an LDAP thumbnail/photo attribute as an image in a View.
- Build a directory of staff or groups from LDAP data on a Drupal page.
- Feed a stored query into `ldap_user` to bulk-update users on cron.
- Drive LDAP provisioning/feed workflows from named queries.
- Look up all members under a particular organizational unit.
- Enumerate LDAP groups for authorization mapping.
- Export directory queries between environments as Drupal config.
- Test different LDAP filters quickly without writing code.
- Query multiple base DNs for a single logical search.
- Share one query definition across several LDAP modules.
- Return variable/multi-valued attributes safely in Views.
- Discover which attributes a result set actually contains (`availableFields()`).
