# Require Revision — manual setup guide

**Require Revision** (`require_revision`) gives you one central screen for deciding
which content must create a new revision every time it is edited. Out of the box
Drupal lets each content type, block type, or vocabulary decide on its own whether
"Create new revision" is ticked by default — and an editor can often untick it.
This module takes that decision out of the editor's hands and enforces it from a
single settings page, so every edit to the entity types you choose leaves an
audit trail you can roll back to.

The settings page is organised into three collapsible sections — **Block Types**,
**Content Types**, and **Taxonomy Vocabularies**. In each one you tick which
bundles must create a revision on save, and, optionally, which of those must also
require the editor to type a revision log message. A "Select all" helper makes it
quick to enforce revisioning across the board.

Two things worth knowing: the requirement only applies when editing *existing*
content — creating brand-new content is never blocked — and the log-message option
only becomes available once you have marked a bundle as requiring revisions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no separate configuration page beyond the single settings form described
below, so setup is folded into this guide.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Content authoring →
Require Revision** (`/admin/config/content/require-revision`). You need the
**Administer site configuration** permission (an administrator by default) to
reach it.

## How to use it

1. Go to **Configuration → Content authoring → Require Revision**.
2. Expand the section for the entity kind you want to govern — **Block Types**,
   **Content Types**, or **Taxonomy Vocabularies**.
3. Under **Requiring revisions**, tick each bundle whose edits should always
   create a new revision. Use **Select all** to tick every bundle in the section
   at once.
4. Optionally, under **Requiring revision log messages**, tick the bundles where
   editors must also type a log message. This option only appears for bundles you
   have already marked as requiring revisions.
5. Click **Save configuration**.

From then on, editing any existing content of a selected bundle forces a new
revision (and, where you enabled it, a log message). New content is unaffected.

> **Upgrading?** If you update to 1.0.6 or later, re-open this settings form and
> save it once so the fix takes effect.
