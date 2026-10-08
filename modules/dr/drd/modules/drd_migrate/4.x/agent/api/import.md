<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Importing a DRD 7 inventory

## Install & run

```bash
drush en drd_migrate -y
drush drd:migratefromd7 /path/to/inventory.json   # alias: drd-migrate-from-d7
```

Requires the `drd` base module. There is no UI — the whole feature is one Drush command backed by
the `drd_migrate.import` service.

## JSON inventory format

`Import::execute()` (`src/Import.php`) decodes the file with `Json::decode()` and expects a map
keyed by core id, each value a list of domains:

```json
{
  "<coreId>": [
    { "url": "example.com", "ssl": true, "token": "<one-time-token>" },
    { "url": "example.com/subsite", "ssl": false, "token": "<one-time-token>" }
  ]
}
```

Per domain it reads `ssl` (chooses `https://`/`http://`), `url` (host + optional path) and `token`
(the one-time token the remote DRD Agent will accept once).

## Import algorithm (`Import::execute()`)

1. Bail with an error print if the file is missing or unreadable.
2. Load user 1 and `setAccount()` it as the current user (entity creation runs as uid 1).
3. For each core id: `drd_core` storage `create(['name' => 'Migrate <id>'])`.
4. For each domain: build the URL, `Domain::instanceFromUrl($core, $url, [])`; if new,
   `initValues($url)` seeds `shared_secret` auth + `OpenSsl` crypt with generated secrets; else adopt
   the existing domain's core.
5. `Domain::pushOTT($token)` — POST the one-time token to the site's `drd-agent` endpoint to
   re-authorise this dashboard. On success: if the core is new, find/create the host
   (`Host::findOrCreateByHost(parse_url($url, PHP_URL_HOST))`), `initCore()` (pull remote root +
   Drupal version), then set `installed = 1`, link the domain to the core and save.

Progress is printed with `print()` (`Import::output()`); `@todo` notes flag that proper Drush
output/error helpers are not yet wired in.

## Operational notes

- Run on the CLI only and as a trusted operator: the importer elevates to uid 1 and re-establishes
  live, credentialed connections to every listed remote site.
- The one-time tokens in the inventory file are single-use handshake secrets — keep the file out of
  shared locations and delete it after import.
- `pushOTT()`/`initCore()` use the base module's encrypted RPC transport (see the base module's
  `api/remote-actions.md` and `api/crypto-and-auth.md`).
