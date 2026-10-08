# Comment tracker — manual setup guide

**Comment tracker** (`comment_tracker`) adds a per-user "new comments" layer to Drupal's
core comment system. For each signed-in user it remembers which individual comments that
user has already seen, and hands your theme the data to highlight the rest: node templates
get counts of new / read / total comments, and comment templates get a simple "is this
comment new?" flag. A small piece of JavaScript marks a comment as read once the visitor
has had it on screen for a few seconds, and clears its "new" indicator on the spot.

Think of it as a "new since last visit" tracker for comments, not a hit counter or
analytics dashboard. It builds on core comments rather than replacing them, so commenting
works exactly as before, now with per-user read tracking attached.

A few practical points to keep in mind:

- **Tracking is opt-in per comment type.** Nothing happens until you tick a checkbox on the
  comment type(s) you want tracked (see [Installation](installation/index.md)).
- **Your theme supplies the markup and styling.** The module ships no CSS and no templates —
  it only exposes Twig variables and documents two CSS class names your theme can output. A
  front-end developer needs to add the indicator markup to `node.html.twig` /
  `comment.html.twig` for anything to appear on the page.
- **Only signed-in users are tracked.** Anonymous visitors record nothing and always see
  zero counts.
- **Caching and privacy.** Read state is stored per user and interacts with page caching
  (the module adds per-user cache contexts/tags); it also records which user read which
  comment, which you should weigh against your site's data-handling policies.

This release is marked *not covered* by Drupal's security advisory policy. It supports
Drupal 10 and 11 and has no other module dependencies declared (it does rely on core's
Comment and Node modules being present).

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, enable it, and turn tracking
   on for a comment type.

## Where it lives in the admin menu

Comment tracker adds **no dedicated settings page and no permissions of its own**. Its only
admin-facing control is an **"Enable Comment Tracker"** checkbox on each comment type's edit
form at **Structure → Comment types → Manage** (`/admin/structure/comment`). Everything else
happens automatically once a comment type is tracked and your theme renders the exposed
variables.
