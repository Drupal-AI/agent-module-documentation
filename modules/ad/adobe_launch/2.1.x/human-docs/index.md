# Adobe Launch Snippet Manager — manual setup guide

**Adobe Launch Snippet Manager** (`adobe_launch`) injects an **Adobe Launch**
(Adobe Experience Platform tag-management) `<script>` into the `<head>` of your
rendered pages — without you editing any theme templates. You paste your Launch
container's script URLs into a settings form, choose the active environment, and
the module adds the right tag to every page that passes its path rules.

It is built for multi-environment work: you can store separate script URLs for
**dev**, **staging**, and **production** and switch between them with a single
dropdown. You can load the script asynchronously (recommended), optionally
initialize the Adobe data layer (`window.digitalData` / `window.DTM_DATA`) before
the snippet runs, and control exactly which pages get the tag with a list of path
patterns.

By default the snippet is **excluded** from admin pages and node-edit pages, so
your analytics tags don't fire while editors are working in the back end. You can
switch the path rules to "include only" mode instead, to scope the tag to a
specific section such as `/products/*`.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form field by field: the
   environment URLs, async/data-layer options, and the path include/exclude rules.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Adobe Launch**
(`/admin/config/services/adobe_launch/configure`). It requires the core
**Administer site configuration** permission.

> **Heads-up for developers:** the module's `info.yml` lists a stale `configure`
> route that no longer resolves. Use the real path above
> (`/admin/config/services/adobe_launch/configure`, route `adobe_launch.config`).
