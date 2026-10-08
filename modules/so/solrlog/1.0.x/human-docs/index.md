# Solr Log — manual setup guide

**Solr Log** (`solrlog`) logs Drupal's system events into Apache Solr instead of
the database. It offers a dblog-style "Recent log messages" interface, but writes
the log entries into a Solr index (via Search API Solr) rather than into
Drupal's watchdog database table. On busy sites that avoids the write pressure
database logging puts on the site, while still letting you search, aggregate and
analyse log messages at scale in Solr.

> **Please note: this module is obsolete.** Its maintainers mark it as
> unsupported and state that its functionality has been **merged into Search API
> Solr**. For new work, use Search API Solr's built-in logging rather than
> installing this module. This guide is provided for reference and for existing
> installations.

It depends on the **Search API** and **Search API Solr** modules and supports
Drupal 10.2+ and 11. It can technically run alongside core's syslog and/or dblog,
though running both dblog and Solr Log at the same time does not make much sense —
pick one destination for your logs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside its Search API Solr dependencies.

## How to use it

There is no dedicated settings form. Once installed, the module creates a
**"Recent log messages (solr)"** view, accessible at
`/admin/reports/solrlog`, which presents your Solr-stored log entries in the
familiar dblog-style report. Access is gated by the module's own permission, so
grant it to the roles that should read the logs.
