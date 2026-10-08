# AWS CloudWatch Logs — manual setup guide

**AWS CloudWatch Logs** (`aws_cloudwatchlogs`) ships Drupal's log messages to
Amazon CloudWatch instead of leaving them only in the site's own database. By
default Drupal's dblog is a table in your database: it grows over time, it is lost
when the database is restored, and on a fleet of sites you have to log in to each
one separately to read anything. Sending logs to CloudWatch moves them somewhere
**durable**, **searchable across sites**, and connected to whatever alerting your
infrastructure already runs.

It works by registering itself as a Drupal **logger**, so you do not have to
change any code — every message Drupal logs travels to CloudWatch automatically.
The admin screens let you edit settings, create log groups, filter output, and
generate a test log entry, each behind its own permission.

Credentials are handled correctly: the module requires the **Key** module, so your
AWS credentials live in a Key entity and can come from an environment variable
rather than sitting in exported configuration.

Two operational realities apply to any log shipper. **CloudWatch is billed per
ingested byte**, so a chatty site becomes a recurring cost — worth trimming log
verbosity. And once logs leave the site they **leave the site's access controls**:
whatever is in a log message becomes readable by anyone who can read the log group,
so review what you log before shipping it.

> **A note for developers.** This module's logger service has a latent circular
> service dependency (it logs through the logging system it is part of). On a
> normal site it stays dormant, but any module that *decorates* `logger.factory`
> can surface it and take down the service container — the sibling
> [`agent/`](../agent/start.md) docs describe this in detail. If you run into a
> `ServiceCircularReferenceException` mentioning `aws_cloudwatchlogs`, that is what
> you are seeing.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and set up the required Key module.
2. [Configuration](configuration/index.md) — the settings form, log groups, and
   AWS credentials.

## Where it lives in the admin menu

The module's screens live under **Reports** at
`/admin/reports/aws-cloudwatchlogs/settings`. Access to the settings and to each
operation (generating a test entry, filtering, creating a log group) is governed
by separate permissions, with *administer settings* being a restricted permission.
