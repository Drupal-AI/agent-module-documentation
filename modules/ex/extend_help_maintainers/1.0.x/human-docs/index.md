# Extend Help Maintainers — manual setup guide

**Extend Help Maintainers** (`extend_help_maintainers`) enriches Drupal's module
**Help pages** by automatically showing **who maintains each module**. Open a
module's help page and, alongside the usual documentation, you get a Maintainers
block — names, avatars, and links to Drupal.org profiles — so admins and
developers can immediately see who to turn to for support.

It works through a small, pluggable architecture. Maintainer data is gathered by
**fetcher plugins** from more than one source and merged: an **Info YAML** fetcher
reads maintainers declared in a module's own `.info.yml` file (highest priority by
default), a **Drupal.org** fetcher pulls maintainers from the project's Drupal.org
page, and custom fetchers can be added in code. When the same maintainer appears in
more than one source, configurable **priorities** decide which source wins. Results
are cached (24 hours by default) so help pages stay fast.

The integration is automatic and non-invasive — it hooks into help page rendering
rather than modifying any other module's code — so the moment you enable it, any
module that has maintainer information will show a Maintainers block on its help
page. A module can declare its own maintainers under
`extra.extend_help_maintainers.maintainers` in its `.info.yml`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable/disable individual fetcher
   plugins and set their merge priorities.

## Where it lives in the admin menu

Once enabled, the module works immediately with no configuration required. Its
optional settings form sits at **Configuration → System → Extend Help
Maintainers** (`/admin/config/system/extend-help-maintainers`). The maintainer
information itself appears on each module's own **Help** page
(**Administration → Help → *(module)***).

## How to use it

1. Enable the module. Maintainer blocks start appearing on module help pages that
   have maintainer data.
2. To see a module's maintainers, go to **Help** and open that module's help page.
3. Optionally visit the settings form to choose which sources are consulted and how
   they are prioritized — see [Configuration](configuration/index.md).
