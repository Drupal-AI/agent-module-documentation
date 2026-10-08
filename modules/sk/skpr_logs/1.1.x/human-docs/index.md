# Skpr Logs — manual setup guide

**Skpr Logs** (`skpr_logs`) enables standardised logging for sites hosted on the
[Skpr](https://skpr.io) hosting platform. It routes Drupal's log events into the
platform's centralised logging so that they are captured consistently and are
easy to query.

Concretely, it outputs logs in **JSON** format (which preserves multi-line
messages and makes them queryable), and it adds two fields to each entry: a
`skpr_component` field for filtering in your logging solution, and a `request_id`
field for tracing a single request across log lines. It is a developer/logging
integration — it forwards log events and has no content or access-control role.

The best part is that there is nothing to configure: **all configuration is
automatic**. Once you enable the module you will simply notice JSON logs being
printed to `stderr`, ready for the platform to pick up. As with any logging,
avoid logging sensitive data. The module has no dependencies, runs on Drupal 10.2
and 11, and carries official security-advisory coverage.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to set up beyond enabling the module — it is meant for
Skpr-hosted environments, where the platform consumes the JSON log stream. After
enabling it, you will see JSON-formatted log lines (including the `skpr_component`
and `request_id` fields) written to `stderr`.
