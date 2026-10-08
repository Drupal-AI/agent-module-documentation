# Console commands (`bin/sm` — a standalone Symfony console app, NOT Drush)

SM registers Symfony console commands in the Drupal container (like a Symfony app, via
`MessengerPass`) and exposes them through the composer `bin`: **`vendor/bin/sm`** (source `bin/sm`).
These are **not** Drush commands — run them from the site root. Use `--help` on any command, and
`-vvv` for verbose output.

## `messenger:consume BUSNAMES` — the worker
`Drupal\sm\Command\SmConsumeMessagesCommand` (extends Symfony `ConsumeMessagesCommand`; service id
`console.command.messenger_consume_messages`). Processes messages from one or more
receivers/transports, in priority order.

```sh
# Consume the default async transport:
./vendor/bin/sm messenger:consume asynchronous

# Prioritised: high first, then low:
./vendor/bin/sm messenger:consume highpriority lowpriority
```

- The command runs **indefinitely** — pair it with Supervisor, or use `--time-limit` under
  server-side cron if long-lived processes aren't available. Consider `--limit` and `--memory-limit`.
- If you enabled legacy-queue interception (see [dispatch.md](dispatch.md)), queue items are processed
  **only** by this command — not by Drupal cron / web cron / `drush queue:*`.

## `messenger:stats`
`Symfony\Component\Messenger\Command\StatsCommand` (id `console.command.messenger_stats`). Shows the
message count per receiver/transport (Drupal SQL transport is count-aware).

## Failed-message commands
Registered only when a failure transport is configured (default `failed`). All use the native PHP
serializer to decode stored envelopes.

```sh
./vendor/bin/sm messenger:failed:show          # list failed messages
./vendor/bin/sm messenger:failed:show ID       # details of one (use --max=N to page the list)
./vendor/bin/sm messenger:failed:retry ID      # re-dispatch a failed message
./vendor/bin/sm messenger:failed:remove ID     # delete without handling
```

Service IDs / classes:
- `console.command.messenger_failed_messages_show` → `FailedMessagesShowCommand`
- `console.command.messenger_failed_messages_retry` → `FailedMessagesRetryCommand`
- `console.command.messenger_failed_messages_remove` → `FailedMessagesRemoveCommand`

The failure transport's default receiver name is injected by `SmCompilerPass` from
`sm.failure_transport`. A `MESSAGEID` here is the Drupal SQL row id (see
[transports.md](transports.md)).
