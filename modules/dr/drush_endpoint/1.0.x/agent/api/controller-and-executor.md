<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Controller and executor (request → Drush → JSON)

## Controller

`Drupal\drush_endpoint\Controller\DrushController` (`src/Controller/DrushController.php`) extends
`ControllerBase`. It is constructed with the `drush_endpoint.executor` service (`create()` fetches it from
the container and type-checks it, throwing `\RuntimeException` if it is not a `DrushExecutor`).

`executeCommand(string $command): JsonResponse` receives the `{command}` route parameter, calls
`$this->drushExecutor->execute($command)`, and returns the resulting array as a `JsonResponse`. It does no
work of its own — access has already been decided by the access checker, so by the time this runs the
command is one of the allowlisted names.

## Executor

`Drupal\drush_endpoint\Service\DrushExecutor` (`src/Service/DrushExecutor.php`), service id
`drush_endpoint.executor`, is constructed with `@logger.factory` and holds the `drush_endpoint` logger
channel.

`execute(string $command): array`:

1. `$commandParts = explode(' ', $command);`
2. `$process = new Process(['drush', ...$commandParts]);` — Symfony Process in **array (argv) form**, so
   the arguments are passed to `drush` directly without an intermediate shell (`/bin/sh -c`). No shell
   metacharacters are interpreted. (Because the access checker only admits exact allowlist names, in
   practice `$commandParts` is a single element.)
3. `$process->mustRun();` inside a `try`.
4. On success returns `['success' => true, 'output' => $process->getOutput(), 'command' => $command]` and
   logs an info message.
5. On `ProcessFailedException` returns `['success' => false, 'output' => $process->getErrorOutput(),
   'command' => $command]` and logs an error message with the exception text.

The returned array is what the controller serialises to JSON. There is no PHP eval, no dynamic argument
assembly from the request body, and no string concatenation into a shell command.

## Requirements

`drush` must be resolvable on `PATH` for the invoking web-server user (the module requires `drush/drush`
`^12 || ^13` via Composer). If `drush` is not found or a command fails, the JSON response carries
`success: false` and the error output.
