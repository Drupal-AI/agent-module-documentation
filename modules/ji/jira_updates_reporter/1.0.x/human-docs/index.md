# Jira Drupal Updates Reporter — manual setup guide

**Jira Drupal Updates Reporter** (`jira_updates_reporter`) bridges Drupal's own
update monitoring to Jira. It reads the core **Update Status** data and, for every
project — core or contrib — whose installed version differs from the recommended
one, it opens a **Jira issue** so pending updates land in the same workflow your
team already uses to track work.

It distinguishes two kinds of update: **security** updates get tickets prefixed
`SECURITY` (with one Jira issue type), and ordinary **release** updates get tickets
prefixed `RELEASE` (with another). A "security only" toggle lets you suppress the
non‑security tickets entirely. Before creating any ticket it searches Jira for an
existing issue with a matching summary, so you don't get duplicate tickets on every
run.

You can trigger a run manually from the settings form, or let it run automatically
on **cron**. Connecting to Jira needs your Jira base URL, a username, an API token,
the target project key, and the two issue‑type names.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it needs core's Update Status).
2. [Configuration](configuration/index.md) — connect to Jira, choose issue types,
   and decide whether to run on cron.

## Where it lives in the admin menu

The settings form is at `/jira-updates-reporter/config` (route
`jira_updates_reporter.settings`). Reaching it requires the **administrator** role
plus the **access Jira Drupal Updates Reporter configurations** permission.
