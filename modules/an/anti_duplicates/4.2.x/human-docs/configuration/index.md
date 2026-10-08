# Configuration

Anti-Duplicates is configured from its own admin page, where you define what counts
as a duplicate and what should happen when one is detected.

## Open the settings page

1. Log in as a user with the module's administration permission (granted under
   **People → Permissions**).
2. Go to the Anti-Duplicates admin page (route `anti_duplicates.admin_page`).

## Set the duplicate criteria

Choose which fields or criteria define a "duplicate". The simplest rule is matching
on the **title**, but you can configure other criteria so the check fits the content
types where duplicates actually cause problems (listings, user submissions,
imported content, and so on).

## Choose warn or block

Decide what happens when a submission matches an existing item:

- **Warn** — the author is told the content looks like a duplicate but can still
  save it.
- **Block** — the submission is prevented until the duplication is resolved.

Save the settings. From then on, the rules are enforced at node submission time.

## Scope it sensibly

Apply the detection to the content types where duplicates matter rather than
site‑wide, so authors of other content are not slowed down by checks they do not
need.
