# JIRA Issue Collector — manual setup guide

**JIRA Issue Collector** (`jira_issue_collector`) adds Atlassian's **JIRA Issue
Collector** feedback widget to your site's pages. Visitors see a feedback or
"report a bug" button (the "trigger"); clicking it opens a form — one you design in
JIRA — that turns their feedback straight into a JIRA issue, **without requiring
them to have a JIRA login**.

It's a fast way to gather user feedback and bug reports during testing, on staging
sites, or on internal tools. You build the collector in your JIRA project, copy
the embed snippet Atlassian gives you, and paste it into this module's settings.
The module then renders that snippet on the pages you choose.

Because the widget loads **Atlassian's third‑party JavaScript** into your pages,
there are two things worth thinking about up front: it's an external script (a
privacy and supply‑chain consideration), and you usually want it shown only to the
right audience — staff and testers, say, rather than every anonymous visitor. The
module provides its own permissions and display settings so you can scope it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — paste your collector embed code and
   choose where and to whom the widget appears.

## Where it lives in the admin menu

The settings form is at **Configuration → System → JIRA Issue Collector**
(`/admin/config/system/jira_issue_collector`). The module also provides its own
permissions, which you manage at **People → Permissions**.
