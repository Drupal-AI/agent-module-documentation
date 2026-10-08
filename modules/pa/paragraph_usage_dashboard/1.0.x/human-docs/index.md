# Paragraph Usage Dashboard — manual setup guide

**Paragraph Usage Dashboard** (`paragraph_usage_dashboard`) gives you a clean,
visual overview of **where every paragraph type is used** across your site —
something Drupal does not provide natively. Instead of guessing which components are
still in play, you get a single dashboard that shows, for each paragraph type, which
content types use it, the specific content it appears on (with real path aliases
rather than numeric IDs), the paragraph type's configured icon, and quick links to
jump straight to the entities involved.

It is built for content audits and governance. The dashboard highlights **unused
paragraph types** so you can retire dead components, and it offers rich filtering:
search by paragraph name or by path alias, filter to show only unused types,
multi‑select several types at once, and find paragraphs used on pages matching a URL
pattern. Your filter selections persist across refreshes. Clicking into a paragraph
type opens a **drill‑down detail view** showing the individual entities that use it —
their titles, content type and bundle, the field the paragraph sits in, the path
alias, and a view link for each.

The typical uses are content audits and cleanup, migration planning, content
strategy and governance, quality assurance, editor training, and maintenance — in
short, understanding a paragraph type's footprint before you change or remove it.

The module is **informational**: it reads content to build the dashboard and shows
usage the viewer is entitled to see, with no access‑control role. It makes no
database schema changes, uses optimised entity queries, and provides its own
permission to gate access. It depends on the **Paragraphs** and **Path Alias**
modules, requires Drupal 11 and PHP 8.1+, and is covered by Drupal's security
advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant its permission.

There is **no settings form** for this module — it is a report you view and filter,
not a feature you configure. (The dashboard's own filters are described below.)

## Where it lives in the admin menu

Paragraph Usage Dashboard adds a report at **Reports → Paragraph Usage**
(`/admin/reports/paragraph-usage`). It does not add a settings page.

## How to use it

1. Install and enable the module, and grant the **Access paragraph usage
   dashboard** permission to the roles that should see it (see
   [Installation](installation/index.md)).
2. Go to **Reports → Paragraph Usage** (`/admin/reports/paragraph-usage`).
3. Use the filters to focus the view — search by paragraph name or path alias, show
   only unused types, select specific types, or find paragraphs used on pages
   matching a URL pattern. Your selections stay put when the page refreshes.
4. Click a paragraph type to drill into its detail view and see exactly which
   entities use it, in which field, and where — then follow the view links to reach
   that content. Use the "unused" filter to spot paragraph types you can safely
   retire.
