<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Varnish File Purge

All settings live in one config object, `varnish_file_purge.configuration`, edited at
**Configuration → Development → Varnish file purge** (`/admin/config/development/varnish_file_purge`,
permission `administer site configuration`). Nothing purges until a **host** is set —
`isConfigured()` returns false and logs a warning otherwise.

## Fields
1. **Domains** (`domains`) — comma-separated list of the site's public hosts (e.g.
   `www.example.com,admin.example.com`). Each becomes the `Host` header of a separate purge request,
   so a file is purged on every front-end and back-office domain. If left empty the module falls
   back to the global `$base_url`. Enter host names only, no scheme.
2. **Debug** (`debug`, checkbox) — when on, logs one `notice` per successfully purged URL/domain to
   the `varnish_file_purge` logger channel. Use for debugging only; failures are logged regardless.
3. **Purge Image styles** (`purge_styles`, checkbox) — when on, for `image/png` and `image/jpeg`
   files the module also purges the URL of every image-style derivative that already exists on disk.
   Leave off if you do not serve image derivatives through Varnish.
4. **Varnish configuration** (details group):
   - **Host name** (`host`, **required**) — the Varnish host/IP the web server connects to. This is
     the actual request target (`base_uri`), NOT the public domain.
   - **Port** (`port`) — Varnish port (0–65535). Appended as `:port` when non-empty.
   - **SCHEME** (`scheme`) — `http://` or `https://` for the connection to Varnish.
   - **Request Method** (`request_method`) — `BAN` or `PURGE` (default `purge`). This is the HTTP
     verb sent. **Your Varnish VCL must be written to handle the verb you pick** — the module only
     emits the request; it does not configure Varnish.

The connection endpoint is assembled as `scheme + host [+ ':' + port]`; the per-domain `Host` header
is what tells Varnish which cache object to invalidate.

## Steps
1. Ensure a reachable Varnish instance and a VCL that honours your chosen `PURGE`/`BAN` verb for
   file URLs.
2. Open the settings form, fill in **Host** (required), Port, Scheme, Request Method.
3. Fill in **Domains** for every front/back-office host that serves the files.
4. Decide on **Purge Image styles** and **Debug**.
5. Save.

## Verify (read-only)
- Inspect saved config: `ddev drush config:get varnish_file_purge.configuration`.
- Replace a file that keeps its URL (or the `file_replace` flow), then check the Varnish access log
  for the `PURGE`/`BAN` request, and — with Debug on — Drupal's log
  (`ddev drush watchdog:show --type=varnish_file_purge`) for `URL purged:` / `URL not purged:` lines.

## Operational notes
- **Update purges are content-gated.** A file save that does not change size, URI, or sha256 content
  sends no request. A brand-new insert and any delete always purge (host permitting).
- **`temporary://` files are skipped** entirely.
- **Purges are synchronous.** They run inside the save/delete request via a Guzzle Pool
  (concurrency 10) that is waited on; there is no queue or retry. Failures only log an error — the
  file operation still succeeds.
- **Config is exportable** like any Drupal config and can be deployed across environments; keep the
  Varnish `host` environment-specific.
