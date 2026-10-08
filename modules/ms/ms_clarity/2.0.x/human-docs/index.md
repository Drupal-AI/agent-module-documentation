# Microsoft Clarity — manual setup guide

**Microsoft Clarity** (`ms_clarity`) adds the Microsoft Clarity analytics tag to
your site so you get Clarity's heatmaps, session recordings, and click/scroll
tracking. The module injects Clarity's small JavaScript snippet into the page
`<head>` (so capture starts as early as possible) and loads it from
`clarity.ms` using your Clarity **project ID**. Once the ID is in place, Clarity
starts collecting data on the pages you allow — no theme edits required.

Because you rarely want to track every request, the module includes two
visibility layers modeled on Drupal's classic Google Analytics module: a
**page** filter (track all pages except a list, or only a list, with `*`
wildcards and `<front>`) and a **role** filter (track only certain roles, or
every role except certain ones). Combine them to, say, track anonymous visitors
everywhere except `/admin/*`, while never recording your editors. If no project
ID is set, or the filters exclude the current request, nothing is injected.

The single thing you must supply is the project ID, which you get by registering
your site in the Microsoft Clarity dashboard. Everything is stored in exportable
Drupal configuration, so your tracking rules travel with a config export.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — entering the project ID and setting
   the page and role visibility rules.

## Where it lives in the admin menu

The settings form sits at **Configuration → Web services → Microsoft Clarity**
(`/admin/config/services/microsoft_clarity`) and needs the **Administer
microsoft clarity** permission.
