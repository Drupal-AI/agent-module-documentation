<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Opening a connection: the `drupacle.connection_service`

## The service

`drupacle.services.yml` registers one service:

```yaml
services:
  drupacle.connection_service:
    class: Drupal\drupacle\Controller\DrupacleController
    arguments: ['@entity_type.manager']
```

Despite the `Controller` class name and namespace, **it is a plain service, not an HTTP endpoint** —
`drupacle.routing.yml` is empty, so no route points at `DrupacleController`. You call it from your
own PHP/module code.

## `drupalConnectionCallback(DrupacleConnectionInterface $connection)`

`src/Controller/DrupacleController.php`. Given a loaded `drupacle_connection` entity it:

1. reads `id`, `username`, `password` and `getHostWithPortAndService()`;
2. calls `oci_connect($username, $password, $hostWithPortAndService)`;
3. on success returns `[$id => $oracleDbResource]`; on failure returns `[$id => $errorMessage]`
   (from `oci_error()['message']`).

The return is an array keyed by the connection **id**. (Note the list-builder snippet loads the
entity by **label** and then indexes the result by label — in practice keep label == id, or index by
the entity's `id()`, to avoid a key mismatch.)

## Usage pattern (as generated on the list page)

The collection page's "Short Code" column (`DrupacleConnectionListBuilder::buildRow()`) generates a
copy-paste snippet like:

```php
use Drupal\drupacle\Controller\DrupacleController;

$entity_storage = \Drupal::entityTypeManager()->getStorage('drupacle_connection');
$entity = $entity_storage->load('MY_CONNECTION');
$connObj = \Drupal::service('drupacle.connection_service')->drupalConnectionCallback($entity);
$sql = oci_parse($connObj['MY_CONNECTION'], 'YOUR QUERY');
// oci_execute($sql); oci_fetch_assoc($sql); ...
```

Drupacle only opens the connection and returns the OCI8 resource — you write and run statements with
the standard PHP `oci_parse()` / `oci_execute()` / `oci_fetch_*()` / `oci_bind_by_name()` functions
yourself.

## List page live connection test

`DrupacleConnectionListBuilder::testOracleConnection()` runs on every render of
`/admin/drupacle/connections`: for each connection it checks `extension_loaded('oci8')`, then calls
`oci_connect()` with a full `(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=…)(PORT=…))(CONNECT_DATA=
(SERVICE_NAME=…)(SID=ORCL)))` descriptor and shows `success` or `failed ~ <oci error>` in the
"Connection Status" column. This means viewing the list attempts a live connection per configured
entry. The host/port/service used are the admin-entered values from the entity (not request input).
