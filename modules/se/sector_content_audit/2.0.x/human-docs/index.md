# Sector Content Audit — manual setup guide

**Sector Content Audit** (`sector_content_audit`) is an editorial toolkit for
tracking where each piece of content sits in an auditing or content-development
workflow. Rather than making you build the fields and taxonomies yourself, it
ships everything ready to go: two status vocabularies, a group of audit fields
(status, an audit/review date, and note fields), and a filterable Views listing
with bulk operations, so a team can review content systematically.

The problem it solves is giving editors a structured, shared way to record the
state of content — which pages have been audited, which are due for review, what
notes reviewers left — instead of ad-hoc spreadsheets or comments. Out of the box
it provides a **Content audit** vocabulary (a status you assign during an audit)
and a **Content development** vocabulary (a status you assign while creating
content), both pre-seeded with sample terms via Default Content. It also provides
field storages for an audit status, a development status, an audit date, review
notes, and document notes, plus a **Sector Content Audit** View — powered by Views
Bulk Operations — that acts as an audit dashboard with exposed filters.

The module needs a little configuration: after enabling it, you turn the audit
fields on **per content type** from that type's edit page. Once enabled for a
type, node add/edit/translate forms show the audit fields grouped into an "Audit
and review" section in the advanced sidebar. It is part of the **Sector**
ecosystem and is designed to work best alongside the **Sector Starter Kit** (which
provides, for example, the restricted text format and taxonomy-term redirects the
README references). It depends on Default Content, core Datetime, Node, Taxonomy,
User and Views, and Views Bulk Operations, and supports Drupal 10.1, 11, and 12.
It creates no custom routes or permissions of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — enable the audit fields per content
   type and use the audit dashboard.

## How to use it

Enable audit tracking on the content types you care about (from each type's edit
page), then editors fill in the audit status, development status, review date, and
notes right on the node form. Reviewers work from the **Sector Content Audit**
View — filtering by status or audit date and running bulk actions on the content
that needs attention.
