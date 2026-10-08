# Drush command

Defined in `src/Commands/CMSContentSyncPrivateEnvironmentCommands.php` (registered via
`drush.services.yml`; the service is injected with the parent's `@cms_content_sync.cli`).

| Command | Alias | Argument | Action |
|---|---|---|---|
| `cms_content_sync_private_environment:poll` | `cspep` | `limit` = `watch` \| `all` \| a number | Poll the Sync Core and process pending requests via `RequestHandlerController::processRequests()`. Errors out if polling is not enabled for the site. |

## `limit` argument

- `watch` — keep polling forever, sleeping `--pollInterval` seconds between empty polls.
- `all` — process everything currently queued, then stop.
- a number (e.g. `10`) — process at most that many requests.

## Options

| Option | Default | Meaning |
|---|---|---|
| `--pollInterval` | 15 | Seconds between polls in `watch` mode (clamped to a minimum of 5). |
| `--host` | (empty) | Override the host Drupal uses to call itself, when the request URL's host isn't resolvable locally. |

```bash
# Continuously watch for and process incoming sync requests
drush cspep watch --pollInterval=15

# Drain everything queued right now
drush cspep all

# Process up to 10 pending requests
drush cspep 10

# Rewrite the self-request host (e.g. inside a container)
drush cspep all --host="web"
```

Polling must be enabled first (see [../api/request-handler.md](../api/request-handler.md)); the
command reports an error and exits if `RequestHandlerController::isEnabled()` is false.
