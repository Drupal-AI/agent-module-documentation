# Monolog Elasticsearch Date Processor — manual setup guide

**Monolog Elasticsearch Date Processor** (`monolog_elasticsearch_date_processor`)
adds a small [Monolog](https://www.drupal.org/project/monolog) *processor* that
appends an Elasticsearch-friendly date field to every log record. If you ship your
Drupal logs to Elasticsearch through Monolog, this saves you from writing dissect
or grok parsing rules: the timestamp arrives in a format Elasticsearch can ingest
directly, so your logs index correctly with no parsing magic.

Concretely, the processor adds an `extra.elasticsearch_date` field to each log
record. A pipeline (for example Filebeat) can then map that field straight to the
log's timestamp when forwarding to Elasticsearch.

This is a developer/logging tool with **no admin UI and no settings form** — it is
enabled entirely by adding the processor to your Monolog configuration in a
`*.services.yml` file. It depends on the Monolog module and works on Drupal 8.7.7
through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — you enable the processor in a
services YAML file, described below.

## How to use it

Monolog is configured through service parameters in a `services.yml` file (for
example `sites/default/*.services.yml`). Add `elasticsearch_date` to the
`monolog.processors` list. For example, if your parameters look like this:

```yaml
parameters:
  monolog.channel_handlers:
    default: ['file']
  monolog.processors: ['message_placeholder', 'current_user', 'request_uri', 'ip', 'referer']
```

change the processors line to include `elasticsearch_date`:

```yaml
  monolog.processors: ['message_placeholder', 'current_user', 'request_uri', 'ip', 'referer', 'elasticsearch_date']
```

Rebuild the container (clear caches) after editing the services file. Your log
records will then carry an `extra.elasticsearch_date` field. When forwarding with
Filebeat, you can use that field as the timestamp, for example:

```yaml
processors:
  - timestamp:
      ignore_missing: true
      ignore_failure: true
      field: extra.elasticsearch_date
      timezone: "Europe/Oslo"
      layouts:
        - '2006-01-02T15:04:05Z'
        - '2020-06-02T13:20:50.516Z'
```
