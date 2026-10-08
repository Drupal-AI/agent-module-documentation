<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `Ipless` service, state key, and compilation event

## Service `ipless.base` (`Drupal\ipless\Ipless`, implements `IplessInterface`)

Reads its flags from `system.performance` (`ipless.*`). Useful public methods:

| Method | Purpose |
|---|---|
| `isEnabled(): bool` | `system.performance` → `ipless.enabled`. |
| `isModeDevEnabled(): bool` | `ipless.modedev`. |
| `isWatchModeEnable(): bool` | `modedev && ipless.watch_mode`. |
| `mustRebuildAll(): bool` | reads state `ipless.force_rebuild`. |
| `generate(array $libraries, $time = NULL): array` | compile the given `"ext/lib"` ids (no-op if `Less_Parser` class missing). |
| `generateAllLibraries(): void` | compile every installed module/theme library; then clears the rebuild flag. |
| `processOnResponse(HtmlResponse $response): void` | compile the libraries attached to a response. |
| `askForRebuild(bool $need = TRUE): void` | set/clear state `ipless.force_rebuild`. |
| `flushFiles(): void` | delete `public://ipless/` recursively. |

Example:

```php
/** @var \Drupal\ipless\Ipless $ipless */
$ipless = \Drupal::service('ipless.base');
if ($ipless->isEnabled()) {
  $ipless->generateAllLibraries();
}
```

## State

- `ipless.force_rebuild` (boolean) — when TRUE, the response subscriber regenerates **all** libraries
  on the next HTML response. Set on `hook_cache_flush()`; cleared by `generateAllLibraries()`.

## Where compilation is triggered

`HtmlResponseIplessSubscriber` subscribes to `kernel.response` (priority 4). On each HTML response,
if `isEnabled()`: rebuild-all when flagged, else (dev mode) compile the page's libraries; watch mode
adds refresh behaviour.

## Event

- Constant `IplessEvents::LESS_FILE_COMPILED = 'ipless.file_compilation'`.
- `IplessCompilationEvent` exposes `getLess()` → the underlying `Less_Parser`. Subscribe to react to
  each compilation (e.g. add import paths, inspect the parser).
