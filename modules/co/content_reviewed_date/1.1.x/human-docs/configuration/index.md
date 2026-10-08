# Configuration

## Open the settings form

1. Log in as a user with the **Administer Content Reviewed Date settings**
   permission.
2. Go to **Configuration → Content → Content Reviewed Date**, or navigate directly
   to `/admin/config/content/reviewed-date`.

## Which content types to track

Select the content types that should participate in review tracking. Only the
types you tick here get the **Last Reviewed** and **Reviewed By** fields, the
automatic "reviewed on save" behaviour, and inclusion in the stale-content report.

## Global staleness threshold

Set a global **staleness threshold in days** — the number of days after a review
before a piece of content is considered overdue. A published node that hasn't been
reviewed within this many days (or has never been reviewed) shows up on the Stale
Content report.

## Per-content-type overrides

Optionally set **per-content-type threshold overrides** so different content types
can have different review intervals — for example, policy pages might need review
every 90 days while blog posts are fine at 365. Any type without an override uses
the global threshold above.

## Save

Click **Save configuration** to store your settings.

## Permissions

Set these under **People → Permissions** (`/admin/people/permissions`):

- **Mark content as reviewed** — lets editor roles use the **Mark as Reviewed**
  tab on tracked nodes to record a review date without editing the content. Grant
  this to your editorial roles.
- **Administer Content Reviewed Date settings** — lets administrators reach and
  change this settings form. Grant this to administrator roles only.

## Using the report and the tab

- **Stale Content report** — **Content → Stale Content**
  (`/admin/content/stale-review`) lists published nodes past their threshold or
  never reviewed.
- **Mark as Reviewed tab** — appears on each tracked node; one click records a
  fresh review date and reviewer without changing the content. Content is also
  marked reviewed automatically whenever an authenticated editor saves a tracked
  node.
