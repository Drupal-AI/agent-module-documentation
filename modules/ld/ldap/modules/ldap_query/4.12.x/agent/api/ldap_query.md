# Programmatic API — run a stored LDAP query

## `ldap.query` service (`QueryController`)

`Drupal\ldap_query\Controller\QueryController` (defined in `ldap_query.services.yml`, built on
`ldap.bridge`). Load a stored query by its entity id, execute, and read results:

```php
/** @var \Drupal\ldap_query\Controller\QueryController $query */
$query = \Drupal::service('ldap.query');

$query->load('all_staff');                 // load the ldap_query_entity by id
$query->execute();                         // run it against its configured server
// or override the stored filter at runtime:
$query->execute('(&(objectClass=person)(department=Sales))');

$entries = $query->getRawResults();        // \Symfony\Component\Ldap\Entry[]
$fields  = $query->availableFields();      // attribute names present across the results
$filter  = $query->getFilter();            // the query's stored filter
```

`execute()` binds via `ldap.bridge->setServerById($query->getServerId())`, then runs the search
across every processed base DN using the query's attributes, size limit, time limit, scope and
dereference options, and merges the results. Pass a `$filter` argument to override the stored
filter (this is how the Views backend injects exposed filters). LDAP exceptions are caught and
logged (results fall back to empty).

This service is the building block used by `ldap_user`'s cron `GroupUserUpdateProcessor` and by
the Views `LdapQuery` backend.
