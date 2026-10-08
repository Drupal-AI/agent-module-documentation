<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands, Acquia API flow, log parsing & alert email

All logic lives in `src/Drush/Commands/AbusiveTrafficCommands.php`
(`final class AbusiveTrafficCommands extends DrushCommands`). Constructor DI:
`config.factory`, `plugin.manager.mail`, `file_system`. Uses `GuzzleHttp\Client`,
`League\OAuth2\Client\Provider\GenericProvider`, and `phpseclib3\Net\SFTP`.

## Auth bootstrap (private helpers)

- `initAcquiaApiClientAndProvider()` — reads the three Acquia client secrets, builds a Guzzle
  `Client(['http_errors' => FALSE])` and an OAuth2 `GenericProvider` (token URL
  `https://accounts.acquia.com/api/auth/oauth/token`), then fetches an access token with the
  **client_credentials** grant.
- `setupAcquiaIds()` — GET `https://cloud.acquia.com/api/applications/{uuid}/environments`, iterates
  `_embedded.items` and stores `prodId` = the environment whose `name === 'prod'`.

TLS: all Acquia endpoints are HTTPS and the Guzzle client keeps default certificate verification
(no `verify => false`).

## Commands

### `abusive_traffic:generate-log` (alias `atgen`)
`generateAcquiaLogFile()`. POST
`https://cloud.acquia.com/api/environments/{prodId}/logs/apache-access` with `form_params`
`from`/`to` spanning the last hour (`date('Y-m-d\TH:i:s\+00:00')`), Bearer token in the
`Authorization` header. Asks Acquia to build the log; it is downloadable ~5 minutes later. Run as
an hourly cron job.

### `abusive_traffic:get-log` (alias `atget`)
`getAcquiaLogFile()`. Run as a second hourly cron job, offset 5–10 min after `generate-log`.

1. GET the same `.../logs/apache-access` endpoint; body is a gzipped log.
2. Save as `private://default/abusive-traffic-apache-{H}.log.gz` (filename keyed by `date('h')`, so
   it overwrites the same hour); path via `file_system->realpath('private://default/')`.
3. Decompress with `gzopen`/`gzread` (4096-byte buffer) to the `.log` sibling.
4. If `forward_log_files` is on: connect via phpseclib `SFTP($server)`, `login($user, $pass)`
   (throws `\Exception('Could not connect to stfp.')` on failure), and `put()` the file to
   `{sftp_path}{filename}`.
5. **Parse**: `fgets()` each line, take field 0 of `str_getcsv($line, ' ')` as the client IP; skip
   `-` (missing IP); tally `$data[$ip]++`.
6. **Threshold**: `array_filter($data, fn($c) => $c >= $threshold)`.
7. **Ignore list**: strip `*`, split on newlines, and drop any tallied IP where
   `str_starts_with($ip, $ignoredPrefix)`.
8. If any IP remains, `mailManager->mail('abusive_traffic', 'threshold_exceeded', $emaillist, 'en',
   $params)` with `params['ipAddresses']` = the surviving IP→count map.

### `abusive_traffic:list-applications` (alias `atlist`)
`listAcquiaApplications()`. GET `https://cloud.acquia.com/api/applications`, returns a
`RowsOfFields` of `name` + `uuid` so you can save the right UUID into
`abusive_traffic_acquia_application_uuid.key`.

## Alert email (`hook_mail`)

`abusive_traffic_mail()` in `abusive_traffic.module` (key `threshold_exceeded`): HTML email
(`Content-Type: text/html`), `from` = `system.site` mail. Body is an HTML table; each row links the
IP to `https://www.abuseipdb.com/check/{ip}` and the intro links to `/admin/config/people/ban`.
Built with `Markup::create()`. The IP values come from field 0 of the Acquia Apache access log (the
recorded TCP client IP), and recipients are the admin-configured `emaillist`.

## Notes for operators

- Both `generate-log` and `get-log` must be scheduled; without the ~5-min gap the download may be
  empty.
- Requires `private://default/` to exist and be writable.
- The module discovers IPs only; enforce blocks separately (Ban module or `.htaccess`).
