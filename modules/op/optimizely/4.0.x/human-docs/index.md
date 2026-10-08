# Optimizely — manual setup guide

**Optimizely** (`optimizely`) loads Optimizely's A/B-testing JavaScript onto
selected paths of your Drupal site, managed as reusable **"project"** entries so
each experiment's snippet only loads where it's actually needed. Instead of pasting
`<script>` tags into your theme's head, you manage everything from Drupal: store
your Optimizely account ID once, then create one project per experiment and tell
each one which paths it should run on.

On every page, the module checks the current path against your enabled projects and,
when one matches, injects that project's Optimizely snippet
(`//cdn.optimizely.com/js/<code>.js`) into the page head. A built-in **Default**
project targets the whole site (`*`); you can add narrower, path-targeted projects
so experiments don't run — and don't add weight — on pages that aren't part of the
test. Path matching works against both system paths and URL aliases, and supports
`*` wildcards.

Using this module requires an **Optimizely account**: you supply your account ID
and, per project, the numeric project/experiment code that Optimizely gives you
for the hosted snippet — the module doesn't create experiments, it just loads the
JavaScript Optimizely hosts. It depends on core's **Path Alias** module, adds an
*Administer optimizely* permission, and ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set your account ID and create
   path-targeted projects.

## Where it lives in the admin menu

The project list and settings are at **Configuration → System → Optimizely**
(`/admin/config/system/optimizely`), with the account-ID form at
`/admin/config/system/optimizely/settings`.
