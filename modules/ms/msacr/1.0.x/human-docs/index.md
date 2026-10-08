# Module Security Advisory Coverage Report — manual setup guide

**Module Security Advisory Coverage Report** (`msacr`) creates a simple report
showing which of the contrib modules installed on your site **are** covered by
Drupal's security-advisory policy and which **are not**. Modules without security-
advisory coverage (for example those without a stable release, or that have opted
out) won't receive official Drupal security advisories, so a vulnerability in one
may never be formally announced or patched — a real risk-management concern for
anyone maintaining a site. This module surfaces those gaps in one place so you can
decide what to do about them.

It's a security/operations reporting tool: it adds no content and has no
integrations or credentials to configure. You enable it, open its report, and
read the results. It supports **Drupal 10 and 11**.

> **Security-advisory note:** somewhat ironically, this module is itself **not
> covered** by Drupal's security advisory policy at present. Weigh that when
> deciding whether to keep it installed on production versus using it as an
> occasional audit tool.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings. Once
enabled it simply provides a report, described below.

## Where it lives in the admin menu

MSACR adds a **report** under Drupal's **Reports** section
(**Administration → Reports**). Open it to see the coverage table.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Administration → Reports** and open the security-advisory coverage
   report.
3. Review the list of installed contrib modules and their coverage status. For
   any module flagged as **not covered**, decide whether to replace it with a
   covered alternative, upgrade to a stable release, or accept and document the
   risk.

Viewing the report requires the permission the module provides for it, so grant
that to the roles who should audit coverage (typically administrators).
