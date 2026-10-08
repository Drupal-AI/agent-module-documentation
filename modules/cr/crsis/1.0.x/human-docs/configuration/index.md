# Configuration

CRSIS has a small settings form where you turn readability analysis on and decide
what counts as an acceptable score. That threshold is what drives the flags and
suggestions you'll see on the dashboard.

## Open the settings form

1. Log in as a user with the **Administer CRSIS** permission (an administrator by
   default).
2. Go to **Configuration → Content authoring → CRSIS Settings**, or navigate directly
   to `/admin/config/content/crsis`.

## Settings

- **Enable readability analysis** — turns the readability scoring on so CRSIS
  analyzes your published nodes and populates the dashboard.
- **Minimum acceptable readability score** — the threshold below which content is
  flagged as needing improvement. Content scoring under this value gets an
  attention-grabbing badge and specific suggestions (such as shortening sentences or
  using simpler words). Set it to match the reading level you're aiming for — a
  higher minimum demands easier-to-read content.

## Save

Click **Save configuration**. Then open **Content → CRSIS Dashboard**
(`/admin/content/crsis-dashboard`) to see the scores, grades, and suggestions.
Remember to grant the **Access CRSIS dashboard** permission to any non-admin roles
that should be able to view the report.
