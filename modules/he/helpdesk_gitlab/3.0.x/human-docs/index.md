# GitLab for Helpdesk Integration — manual setup guide

**GitLab for Helpdesk Integration** (`helpdesk_gitlab`) is a platform plugin for the
[Helpdesk Integration](https://www.drupal.org/project/helpdesk_integration) framework
that connects your Drupal helpdesk to **GitLab**. With it enabled, support tickets
raised on your Drupal site are represented as **issues** (with comments) in your
GitLab instance, keeping your end users on your Drupal site while your team works the
tickets in GitLab.

It is not a standalone module: it depends on Helpdesk Integration and adds "GitLab"
as one of the platforms you can pick when you create an integration there. All of the
user‑facing helpdesk experience — the `/helpdesk` page, the issue content, the
permissions — comes from the framework; this module supplies the GitLab connection.

The security‑sensitive part is the credential. To talk to the GitLab API this module
uses a **GitLab access token**, which is a powerful secret — depending on its scope it
can read and write issues and projects. Store it in an environment variable (and,
where supported, reference it via the Key module), scope it to the least privilege it
needs, and never commit it. All traffic to GitLab is outbound (egress) API calls, and
this module has no access‑control role of its own beyond the framework's permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Helpdesk Integration.
2. [Configuration](configuration/index.md) — create a GitLab integration and store
   its access token securely.

## Where it lives in the admin menu

There is no separate settings page for this module. You configure it as a GitLab
integration inside Helpdesk Integration, at **Configuration → Web services →
Helpdesk** (`/admin/config/services/helpdesk`).
