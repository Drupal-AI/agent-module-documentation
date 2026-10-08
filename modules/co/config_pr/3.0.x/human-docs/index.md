# Config PR — manual setup guide

**Config PR** (`config_pr`, "Config Pull Request") lets site builders open a **pull
request** of configuration changes straight from the Drupal admin UI. After making changes
through forms, an administrator goes to the Configuration Management page, opens the **Pull
Request** tab, selects the configuration they want to keep, confirms the repository, adds a
title and description, and submits — and Config PR creates the pull/merge request on your Git
host over its API. The change can then be reviewed and merged like any other code.

It is aimed at two audiences: site builders who do not use Git on the command line, and
stakeholders who want changes made in the UI to actually end up committed in the codebase.
It also prevents a classic trap — configuration changed in the UI on a live site being
silently reverted on the next deployment when configuration is automatically imported.
Notably, you do **not** need a local Git clone on the live or staging server: the module
pushes to the repository directly through the host's API.

Config PR supports **GitHub** and **GitLab** through provider **submodules** — you enable the
one matching your host. (A **Bitbucket** submodule ships but is a placeholder that is not yet
functional.) It depends on core's **Configuration Manager** and **Field** modules, provides its
own permission for who may issue pull requests, and requires Drupal `^10 || ^11 || ^12`. This is
the **3.0.0** release.

Because it authenticates to your Git host with an **API token** and pushes your
configuration there, there are real considerations — where the token is entered and what your
exported configuration might contain. Those are covered on the
[Configuration](configuration/index.md) page; read it before connecting a live repository.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base module and
   the provider submodule for your Git host.
2. [Configuration](configuration/index.md) — connect your Git host, store the API token
   safely, and use the Pull Request tab.

## Where it lives in the admin menu

Config PR adds a **Pull Request** tab to the Configuration Management area (alongside the
usual import/export/synchronize tabs). That is where you select configuration and issue a
pull request. Access is controlled by the permission the module provides — grant it only to
trusted operators.
