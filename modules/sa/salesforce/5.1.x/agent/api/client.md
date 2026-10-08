# REST client & query API

## The client — `salesforce.client`

`Drupal\salesforce\Rest\RestClient`. Talks to the Salesforce REST API using the resolved
auth provider. Selected methods:

```php
$sf = \Drupal::service('salesforce.client');

$sf->isInit();                                   // is an auth provider connected?
$sf->objects(['updateable' => TRUE]);            // list sObject types
$sf->objectDescribe('Contact');                  // field/record-type metadata
$sf->objectCreate('Contact', $params);           // -> SFID
$sf->objectRead('Contact', $id);                 // -> SObject
$sf->objectUpdate('Contact', $id, $params);
$sf->objectUpsert('Contact', $extIdField, $value, $params);
$sf->objectDelete('Contact', $id);
$sf->query($selectQuery);                         // SOQL -> SelectQueryResult
$sf->queryAll($selectQuery);
$sf->getRecordTypes('Contact');
$sf->getApiUsage();                               // API limit info
$sf->apiCall($path, $params, 'GET', TRUE);        // low-level call
```

All of these require a working Salesforce authorization; without one they throw. Use
`isInit()` to guard.

## SOQL — `SelectQuery`

`Drupal\salesforce\SelectQuery` builds a SOQL string:
```php
use Drupal\salesforce\SelectQuery;

$q = new SelectQuery('Contact');
$q->fields = ['Id', 'Name', 'Email'];
$q->addCondition('Email', "'test@example.com'", '=');
$q->limit = 10;
$result = \Drupal::service('salesforce.client')->query($q);   // SelectQueryResult
foreach ($result->records() as $sfid => $sobject) { /* ... */ }
```
`SelectQueryRaw` runs a raw SOQL string. `SelectQueryResult` paginates via
`RestClient::queryMore()`.

## Value objects

- `SObject` — a Salesforce record (type + fields), constructed from API responses.
- `SFID` — a validated 15/18-char Salesforce Id.
- `SelectQueryResult` — records + pagination cursor.

## Events (subscribe to react)

The suite dispatches auth events, a REST response event, and an error event (plus pull/push
events from those submodules). See `src/Event/` — e.g. `SalesforceEvents` constants. Use them
to log, alter requests, or handle failures.

## Auth resolution

The client asks `plugin.manager.salesforce.auth_providers` for the provider named by the
default `salesforce_auth` (see `salesforce.settings` → `salesforce_auth_provider`) or a
specific one. See `plugins/auth-providers.md`.
