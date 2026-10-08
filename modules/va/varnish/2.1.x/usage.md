<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Varnish integrates Drupal with the Varnish HTTP accelerator by talking to its socket-based control terminal to issue cache invalidations (bans) and query server status.
---
Varnish sits in front of Drupal and caches anonymous page views; the challenge is invalidating those cached entries when content changes. This module connects to one or more Varnish **control terminals** (default `127.0.0.1:6082`) using the PHP `sockets` extension. `_varnish_terminal_run()` opens a TCP socket, and when Varnish requests authentication (status code 107) it answers the challenge with a SHA-256 hash of the challenge + shared secret (`varnish_control_key`) — the standard Varnish CLI auth handshake. Helper functions `varnish_purge()`, `varnish_purge_paths()` and `varnish_purge_all_pages()` build `ban` commands (normal or ban-lurker style), chunking them to stay under `params.cli_buffer` (`varnish_cmdlength_limit`, default 7500 bytes). It also registers a `cache.backend.varnish` backend and a `varnish` cache bin.

Configuration is at `/admin/config/development/varnish` (`VarnishAdminForm`), gated by the core `administer site configuration` permission: Varnish version, control terminal address(es), the optional control key, socket timeout, cache-clear mode (none / default / selective — selective needs the Expire module), and ban type. Security posture: the only route is that admin settings form, permission-gated; there are **no anonymous or mutating HTTP endpoints** and no request-driven purge routes, so bans cannot be triggered by external requests. The `varnish_control_key` is saved in `varnish.settings` and entered via a normal textfield. The control connection itself is a plaintext socket (Varnish CLI), intended for a trusted/local network.
---
- Invalidate Varnish cache when nodes are updated (default cache-clear mode)
- Purge all cached pages for the current site (`varnish_purge_all_pages()`)
- Ban cached entries matching a host + URL pattern (`varnish_purge()`)
- Purge a list of specific paths, auto-chunked under the CLI buffer (`varnish_purge_paths()`)
- Configure one or more Varnish control terminals (space-separated)
- Set the Varnish control secret key for authenticated CLI access
- Choose the Varnish version to target
- Select cache-clear behavior: none, Drupal default, or selective (with Expire)
- Use ban-lurker style bans (requires x-url/x-host response headers in VCL)
- Increase the socket timeout when Varnish runs on a remote host
- Adjust the CLI command length limit to match `params.cli_buffer`
- Check whether each configured Varnish server is up, down, or auth-failed (`varnish_get_status()`)
- Render a status report of all Varnish terminals in the admin UI
- Use the `cache.backend.varnish` backend for a dedicated `varnish` cache bin
- Restrict configuration to `administer site configuration` holders
- Let pages persist to their full max-age by choosing the "none" clear mode
- Write custom cache-clearing logic on top of the provided purge helpers
- Diagnose connection/auth problems via the `varnish` logger channel
- Run against multiple Varnish servers by listing several terminals
