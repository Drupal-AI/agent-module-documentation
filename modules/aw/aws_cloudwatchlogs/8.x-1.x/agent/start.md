<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AWS CloudWatch Logs (aws_cloudwatchlogs) — agent index

Registers a Drupal **logger** writing to AWS CloudWatch, with log group / filter / test-entry UI.
Configure at `/admin/reports/aws-cloudwatchlogs/settings`. Version **8.x-1.2**.
Core `^9.1 || ^10 || ^11`. Depends on **`key`**.
Permissions: `aws_cloudwatchlogs administer settings` (**restrict**), plus `access generate_log`,
`access filter_log`, `access create_log_group`.

**Credential handling is correct** — `key` is a hard dependency, so AWS credentials are a Key
entity, not config.

**Documented from source — it carries a latent circular service reference. Verified:**
`aws_cloudwatchlogs.log` is tagged `{ name: logger }` (collected **into** `logger.factory`) while
depending on `put_log_events`, which takes `@logger.channel.aws_cloudwatchlogs` — a channel obtained
**from** `logger.factory`. Core resolves channels lazily so it stays latent; anything that
**decorates** `logger.factory` surfaces it. `flowdrop_runtime` does:

```
ServiceCircularReferenceException: Circular reference detected for service
"flowdrop_runtime.logger_channel_filter" … -> aws_cloudwatchlogs.log ->
aws_cloudwatchlogs.put_log_events -> logger.channel.aws_cloudwatchlogs
```

**The cycle belongs to this module, not the decorator** — a logger that logs through the system it
is part of is inherently circular and only works by an implementation detail of core's factory.

Two operational points for any log shipper: CloudWatch is **billed per ingested byte**, and logs
**leave Drupal's access controls** once shipped.