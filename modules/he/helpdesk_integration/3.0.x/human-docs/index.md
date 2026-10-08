# Helpdesk Integration — manual setup guide

**Helpdesk Integration** (`helpdesk_integration`) is a **framework** for connecting
your Drupal site to an external helpdesk/ticketing system such as GitLab, Zammad, or
Zendesk. On its own it does not talk to any particular platform — instead it provides
the foundation that platform‑specific modules (like
[GitLab for Helpdesk Integration](https://www.drupal.org/project/helpdesk_gitlab) and
[Zammad for Helpdesk Integration](https://www.drupal.org/project/helpdesk_zammad))
plug into.

The idea is to give everyone the best experience. Your end users stay inside your
Drupal site — a portal, intranet, or web app where they already have an account — and
use a single page to submit new issues, comment on them, upload attachments, and
follow progress until they are resolved. Meanwhile your support agents work in a
dedicated helpdesk tool with all its specialized features. The two are kept in sync
behind the scenes.

A few things worth knowing about how it works:

- It adds a **`/helpdesk`** route where each permitted user sees and manages their
  own issues. You can give it a path alias and add it to a menu.
- The helpdesk system remains the **owner of the data** (issues, comments,
  attachments, statuses). Relevant issue data is synced into Drupal in the
  background, on demand, for a good local experience — not everything is copied.
- To store that synced data, the module provides a content type with comments and
  attachments, including a dedicated comment bundle.
- Drupal **synchronizes user accounts** into the helpdesk system so issues are tied
  to the right person — but only for users who have permission to use the helpdesk
  feature.

Because the concrete integrations talk to an external API, credential handling
matters: each platform module needs **API credentials** for its service. Treat those
as secrets (store them via environment variables / the Key module), keep the traffic
over HTTPS, and remember that ticket data can contain user PII. Access to helpdesk
features is governed by this module's permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the framework with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set up integrations, permissions, and
   the `/helpdesk` page.

## Where it lives in the admin menu

You create and manage integrations at **Configuration → Web services → Helpdesk**
(`/admin/config/services/helpdesk`). End users interact with their issues at the
**`/helpdesk`** page.
