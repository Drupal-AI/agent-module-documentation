# Configuration

Extended Logger starts logging as soon as it is enabled — writing to a `drupal.log`
file by default. The settings form is where you change **where** logs go and **what
each entry contains**.

## Open the settings form

1. Log in as a user with the **`administer extended_logger configuration`**
   permission (an administrator by default).
2. Go to **Configuration → Development → Extended Logger**, or navigate directly to
   `/admin/config/development/extended-logger`.

## Output target

The main choice is the **destination** for your log records. Extended Logger can
write to:

- **A file** — the default (`drupal.log`). Good for a legacy pipeline or when
  another tool tails the file.
- **syslog** — hand entries to the system logger.
- **stdout / stderr** — the container use case: the platform (Kubernetes, a PaaS,
  Docker) collects the stream, so you need no database and no file rotation.

Choose the target that matches how your environment collects logs. For a
containerised site, stdout is usually the right answer; for a log-aggregation
stack, syslog or stdout feeding the collector.

## Fields included in each entry

Rather than logging a fixed set of fields, Extended Logger lets you choose **which
fields** appear in each JSON record — so you can include only what your project
needs. Fields are selected by **JSONPath expression**, which is how you pull a
specific piece of context (for example a request id, route name, or deployment
version) into the output. Trim the list to keep log volume down, or expand it to
give your aggregator more to index and filter on.

Because other modules can contribute metadata to entries (through the module's
event system), custom context such as a trace id or tenant can also be surfaced
here.

## Save

Click **Save configuration**. New log entries use the updated target and field
selection immediately.

## After you change the target

- If you point logs at a **remote** destination (syslog or an aggregator), enable
  the **Fallback** submodule (`extended_logger_fallback`) so logging doesn't fail
  silently when that destination is briefly unreachable.
- Remember that entries carry user input, IPs, usernames, and request paths —
  shipping them off-site is a personal-data flow that needs a retention policy.
