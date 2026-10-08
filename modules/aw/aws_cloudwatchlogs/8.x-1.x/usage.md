<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AWS CloudWatch Logs registers a Drupal logger that writes to CloudWatch, with UI for creating log groups, filtering and generating test entries.

---

Drupal's dblog is a table in the site's own database: it grows, it is lost when the database is restored, and on a fleet of sites it means logging in to each one to read anything. Shipping logs to CloudWatch moves them somewhere durable, searchable across sites, and attached to whatever alerting the infrastructure already has.

The module registers itself as a logger, so nothing in Drupal needs to change — every `\Drupal::logger()` call travels. The admin routes cover settings, generating a test entry, filtering, and creating log groups, each behind its own permission, and `administer settings` is `restrict access: TRUE`.

**Credential handling is correct**: `key` is a hard dependency, so the AWS credentials are a Key entity and can come from an environment variable rather than sitting in exported configuration.

**It carries a latent circular service dependency, and it was surfaced live.** `aws_cloudwatchlogs.log` is tagged `{ name: logger }`, so the container collects it into `logger.factory`; it depends on `aws_cloudwatchlogs.put_log_events`, which takes `@logger.channel.aws_cloudwatchlogs` — a channel obtained **from** `logger.factory`. Core resolves channels lazily, so alone this never materialises. Any module that **decorates** `logger.factory` forces it to, and `flowdrop_runtime` does exactly that:

```
ServiceCircularReferenceException: Circular reference detected for service
"flowdrop_runtime.logger_channel_filter", path: … logger.channel.default ->
flowdrop_runtime.logger_channel_filter -> aws_cloudwatchlogs.log ->
aws_cloudwatchlogs.put_log_events -> logger.channel.aws_cloudwatchlogs
```

Container down, site and Drush both. **The cycle belongs to this module, not to the decorator** — a logger that logs through the logging system it is part of is inherently circular, and it only works because of an implementation detail of core's factory. Injecting the concrete channel lazily, or not logging through the factory at all, is the fix.

Two operational points that apply to any log shipper: **CloudWatch is billed per ingested byte**, so a verbose site is a recurring cost, and **logs leaving the site leave its access controls** — whatever is in a log message is now readable by whoever can read the log group.

---

- Ship Drupal logs to CloudWatch.
- Keep logs after a database restore.
- Search logs across a fleet of sites.
- Attach Drupal logs to existing alerting.
- Store AWS credentials in a Key entity.
- Create a log group from the UI.
- Generate a test log entry.
- Filter log output.
- Separate permissions for each log operation.
- Check for modules decorating logger.factory.
- Diagnose a circular service reference.
- Understand why the cycle is latent.
- Budget CloudWatch ingestion cost.
- Account for logs leaving Drupal's access controls.
- Review what the site logs before shipping it.
- Reduce log verbosity to control cost.
