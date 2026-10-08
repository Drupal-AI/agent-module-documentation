# Metatag: Google Scholar — manual setup guide

**Metatag: Google Scholar** (`metatag_google_scholar`) helps scholarly content — journal
articles, dissertations, technical reports — get indexed by
[Google Scholar](https://scholar.google.com). It does this by adding the Highwire Press
`citation_*` meta tags that Google Scholar reads, rendered as
`<meta name="citation_title" content="…">` and friends in your pages' `<head>`.

The module is a thin extension of the [Metatag](https://www.drupal.org/project/metatag)
module. It defines one new Metatag group — **Google Scholar** — and 14 citation tags
(`citation_title`, `citation_author`, `citation_publication_date`, `citation_journal_title`,
`citation_issn`, `citation_isbn`, `citation_volume`, `citation_issue`, `citation_firstpage`,
`citation_lastpage`, `citation_dissertation_institution`,
`citation_technical_report_institution`, `citation_technical_report_number`, and
`citation_pdf_url`). It has **no settings form of its own** and no permissions — you fill in
the tags through Metatag's normal screens, where a new *Google Scholar* section appears.

Because it plugs straight into Metatag, every Metatag feature applies: values accept **tokens**
(so you can map each tag to an entity field such as author, publication date, or PDF URL), you
can set defaults per content type, and you can override values per entity with a Metatag field.

This guide is written for a **human** clicking through the admin UI. If you want the exact tag
ids and plugin details for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## Where it lives in the admin menu

This module has no page of its own. You configure its tags through **Metatag** at
**Configuration → Search and metadata → Metatag** (`/admin/config/search/metatag`), where a
**Google Scholar** group now appears in the tag forms. You can also add or override the tags
on a per‑entity basis via a Metatag field on the content type.

## How to use it

1. Go to **Configuration → Search and metadata → Metatag**
   (`/admin/config/search/metatag`).
2. Edit the metatag defaults for the content type that holds your scholarly articles (for
   example add or edit a *Content: Article* default), or add a Metatag field to that content
   type for per‑node control.
3. Open the **Google Scholar** section and fill in the citation tags. Use static text or
   **tokens** so the values come from fields, for example:
   - **Citation title** → `[node:title]`
   - **Citation author** → a token for your author field (this tag allows multiple values;
     Google Scholar requires at least one author)
   - **Citation publication date** → a date token such as `[node:field_pub_date:custom:Y/m/d]`
   - **Citation pdf url** → a token pointing at the full‑text PDF
4. Save. View a matching article and check the page source — the `citation_*` meta tags now
   appear in the `<head>`.

You can combine Google Scholar tags with other Metatag groups (Open Graph, Dublin Core) on the
same content.
