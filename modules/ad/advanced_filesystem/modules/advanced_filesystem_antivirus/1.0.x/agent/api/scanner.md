<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ClamAvScanner service, connection modes & upload enforcement

## Connection modes (`connection_mode` config)
`Service\ClamAvScanner::scanPath($path)` dispatches on the mode:
- `tcp` / `unix` → `scanViaInstream($path, $mode)`: opens a `stream_socket_client` to `tcp://host:port` or `unix://socket_path`, sends `zINSTREAM\0`, streams the file in 8 KB chunks each length-prefixed with `pack('N', len)`, terminates with a zero-length chunk, and parses the daemon reply (`parseDaemonResponse()` → `OK`=clean, `... FOUND`=infected + signature, size-limit/empty=error). The daemon never touches the path itself.
- `clamdscan` / `clamscan` → `scanViaCli($path, $binary)`: builds `[$which, '--no-summary', '--fdpass'|'--stdout', $path]` and runs it. Exit 0=clean, 1=infected (`parseCliSignature()`), 2/other=error.

CLI execution — `runProcess(array $args)`: `$command = implode(' ', array_map('escapeshellarg', $args))`
then `proc_open($command, ...)`. Every argument (binary path, flags, and the scanned file path) is
individually shell-escaped; `locateBinary()` similarly runs `/bin/sh -c 'command -v ' . escapeshellarg($binary)`.
`processFunctionsAvailable()` refuses CLI modes when `proc_open` is disabled.

## Scan entry points
- `scanFile(FileInterface)` → resolves `realpath($file->getFileUri())`, readability-checks, then `scanPath()`. Returns `{result, signature, message}` where result ∈ `clean|infected|error|skipped`.
- `appliesToFile()` — false when the file exceeds `max_scan_size_mb` (also enforced pre-stream in `scanViaInstream()`).
- `isEnabled()`, `isResidentMode()` (false only for `clamscan`), `getOnInfectionAction()`, `getConnectionMode()`.
- `quarantine($path)` — `prepareDirectory(quarantine_directory)` then `file_system->move()` to `basename.<time>.quarantine`.
- `getDatabaseStatus()` — daemon VERSION string (tcp/unix) or newest signature file mtime in known dirs (CLI).
- `logResult(?fid, filename, uri, outcome)` — inserts an `adfs_antivirus_log` row (bound DB API).

## Upload enforcement — `EventSubscriber\AntivirusFileValidator`
Subscribes core `FileValidationEvent` at priority **-50** (runs after size/extension validators).
`onFileValidate()`:
1. Return if scanning disabled; skip files that are not new and already permanent; skip when `!appliesToFile()`.
2. `scanFile()` + `logResult()`.
3. `clean`/`skipped` → return.
4. `error` → `handleError()`: logs a warning; if `fail_closed` config is true it adds a `ConstraintViolation` (upload rejected), otherwise no violation is added. Default `fail_closed: false`.
5. `infected` → audit-log the detection, dispatch `antivirus.infected` to `advanced_filesystem_webhooks.dispatcher` if present, then per `on_infection`: `block` → quarantine + `ConstraintViolation` (reject); `warn` → messenger warning; `log` → detection already recorded.

## Drush (`Commands\AntivirusCommands`)
- `adfs:av:ping` — `ClamAvScanner::ping()`; success/failure exit code.
- `adfs:av:scan [--fid=N] [--limit=N]` — iterate `file_managed` fids, scan each, tally clean/infected/error/skipped and print threats; non-zero exit if any threat.
