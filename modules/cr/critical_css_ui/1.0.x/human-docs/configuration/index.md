# Configuration

Configuring Critical CSS UI means creating critical-CSS fragments and telling the
module which page contexts each one applies to. The module inlines the best-matching
fragment for the page being rendered, so you can start broad (a whole content type)
and add more specific rules (individual nodes) where they matter.

## Open the admin page

1. Log in as a user granted the module's critical-CSS permission (keep this limited
   to trusted users — see the caution below).
2. Go to **Configuration → Development → Performance → Critical CSS**, or navigate
   directly to `/admin/config/development/performance/critical-css`.

From here you manage all critical CSS entities: the listing page lets you review,
edit, and remove existing fragments.

## Create a critical CSS entity

Add a new critical CSS entity and paste in the above-the-fold styles you want inlined.
Each entity is attached to a **context** that determines when it is used:

- **A specific node** (for example `node:ID`) — inlined only on that one page.
- **A content type / bundle** (for example `node:bundle`) — inlined on every page of
  that type, as a fallback when there is no more specific rule.

When a page is rendered, the module matches from most specific to least specific:
the exact page first, then the content type, then any fallback. Only the CSS for the
matched context is inlined; other CSS is loaded asynchronously so it does not block
the first paint.

## Per-node and per-bundle editing

Besides the central admin page, the module adds two convenient entry points:

- A **Critical CSS** tab on individual node edit pages, for per-node rules.
- Bundle-level critical CSS under **Structure → Content types**, for rules that apply
  to a whole content type.

## After you make changes

If your critical CSS changes are not visible on the front end, clear caches with
`drush cr` and reload the page.

## Security caution

Because these fragments are **inlined directly into your pages**, anyone who can edit
them can inject arbitrary CSS into what visitors see — which can be abused for
defacement or UI-redress attacks. Grant the module's edit permission only to trusted
users, and treat the CSS fields as trusted markup rather than ordinary user input.
