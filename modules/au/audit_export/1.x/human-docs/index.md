# Audit Export — manual setup guide

**Audit Export** (`audit_export`) provides auditing and reporting tools that
**export site information** — content, configuration, users, modules — for review.
Inventorying a site by hand for a review, a handover, or a compliance check is
tedious; this module gathers that information and exports it (including as CSV) so
you can work with it outside the site. It is built around a small set of
submodules: **Audit Export Core** (`audit_export_core`, the engine the others
depend on), **Audit Export Tool** (`audit_export_tool`) and **Audit Export Post**
(`audit_export_post`), with an extensible plugin architecture for adding more
report types.

The security consideration is straightforward but important: **an audit export is
a concentrated dump of site information**, some of it sensitive — user data, and
configuration that can include access rules. The export capability is
admin-gated, and the resulting files should be handled as sensitive: restrict who
can run and read them, and do not leave exports sitting in public or shared
locations.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   base module plus the submodules you need.

## How to use it

1. Enable **Audit Export Core** (required by the others) along with **Audit Export
   Tool** and/or **Audit Export Post** depending on what you want to export.
2. As an administrator, run the audit/export from its admin tool to gather the
   site inventory and produce the report (CSV and on-screen).
3. Download the export, then store it somewhere access-controlled — treat it as
   sensitive because it concentrates user and configuration data.

Restrict the ability to run and read exports to trusted administrators, and delete
old exports you no longer need.
