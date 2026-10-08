<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Varnish

Route: `/admin/config/development/varnish` (`VarnishAdminForm`, permission `administer site configuration`). Config object: `varnish.settings`.

| Key | Meaning | Default |
| --- | --- | --- |
| `varnish_control_terminal` | Space-separated `host:port` CLI terminals | `127.0.0.1:6082` |
| `varnish_control_key` | Shared secret for CLI auth (SHA-256 challenge) | `''` |
| `varnish_socket_timeout` | Socket timeout, milliseconds | `100` |
| `varnish_version` | Target Varnish major version | `3` |
| `varnish_cache_clear` | 0=none, 1=Drupal default, 2=selective (needs Expire) | `1` |
| `varnish_bantype` | 0=normal ban, 1=ban-lurker | `0` |
| `varnish_cmdlength_limit` | Max CLI command bytes (match `params.cli_buffer`) | `7500` |
| `varnish_flush_cron` | Flush on cron | `0` |

Drush: `drush cget varnish.settings`; set the key with `drush cset varnish.settings varnish_control_key <secret> -y`.

## How invalidation works
- `varnish_purge($host, $pattern, $operator='~')` sends a `ban` to every terminal. Normal: `ban req.http.host ~ <host> && req.url <op> "<pattern>"`; ban-lurker uses `obj.http.x-host`/`obj.http.x-url` (add `beresp.http.x-url`/`x-host` in your VCL `vcl_backend_response`). `$operator` is validated against a whitelist (`==`,`!==`,`~`,`!~`,`<`,`!<`,`>`,`!>`), defaulting to `~`.
- `varnish_purge_paths($host, $paths)` compiles an anchored regex of paths and chunks it under `varnish_cmdlength_limit`.
- `varnish_purge_all_pages()` bans the whole site (host + base path).

## Status
`varnish_get_status()` returns per-terminal `VARNISH_SERVER_STATUS_UP` / `_DOWN` / `_AUTHENTICATION_FAILURE`; the admin form renders these with check/error icons.

## Cache backend
`cache.backend.varnish` provides a `varnish` cache bin (`VarnishBackendFactory`). Requires the PHP `sockets` extension; if unavailable, the separate Varnish Purge module offers an HTTP-client approach.

## Hardening
- Keep the control terminal on localhost or a trusted network — the CLI channel is plaintext.
