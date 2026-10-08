# Bureau Works TMGMT Connector — manual setup guide

**Bureau Works TMGMT Connector** (`bureau_works_tmgmt_connector`) plugs the
[Bureau Works](https://www.drupal.org/project/bureau_works_tmgmt_connector)
translation platform into Drupal's Translation Management Tool (TMGMT). Once it
is installed, Bureau Works appears as one of the translation providers you can
pick when you send content out for translation: you create a TMGMT job, choose
the Bureau Works translator, and the module sends the source content to Bureau
Works and brings the finished translations back — all through the normal TMGMT
workflow.

The requests it sends are signed and authenticated with API credentials issued
by Bureau Works. Because it hands your content to an external service, treat it
as data leaving your site: confirm that sending your content there (including
drafts or anything sensitive) is acceptable before you route jobs through it.

The module has no access-control role of its own and adds no permissions beyond
what TMGMT already provides. It targets Drupal 10 and 11.

This guide is written for a **human** setting the connector up through the admin
UI. If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside TMGMT.
2. [Configuration](configuration/index.md) — add Bureau Works as a TMGMT
   translator and supply its API credentials safely.

## Where it lives in the admin menu

The connector itself has no standalone settings page. You configure it as a
TMGMT **translator (provider)** under **Translation → Providers**
(`/admin/tmgmt/translators`), where you add a provider that uses the Bureau Works
plugin and enter its credentials. Day-to-day translation work happens on the
usual TMGMT job screens under **Translation** (`/admin/tmgmt`).
