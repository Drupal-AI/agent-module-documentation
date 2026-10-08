# Configuration

Reviews is configured on its settings form and moderated from a separate content
listing. This page walks through both.

## Open the settings form

1. Log in as a user with permission to administer the site.
2. Go to **Structure → Reviews → Settings**
   (`/admin/structure/reviews/settings`).

This form is where you manage the reviews system and the review entities
themselves.

## Turn the system on and choose behavior

The core choices on the settings form are:

- **Whether the reviews system is on or off** — the master switch. With it off, no
  reviews are collected or displayed.
- **Whether a user may leave more than one review** for a single piece of content,
  or is limited to one review per item.
- **Which content types accept reviews** — enable reviews only on the content types
  where they make sense (for example "Gig" and "Artist", not "Basic page").
- **Whether reviews are published immediately or held for moderation** — hold them
  for moderation if you want a human to approve each review before it appears
  publicly. This is the main defence against spam and abusive submissions.

Save the form to apply your choices.

## Set who can submit and moderate

Reviews provides its own permissions. Go to **People → Permissions**
(`/admin/people/permissions`) and grant:

- the ability to **submit reviews** to the roles that should be able to leave them
  (typically authenticated users), and
- the ability to **moderate/manage reviews** only to trusted editors or
  administrators.

Because review text is user-submitted content, be deliberate here — public reviews
attract spam and abuse, so pair generous "submit" access with real moderation.

## Moderate the reviews users leave

Reviews submitted by users are managed at **Content → Reviews**
(`/admin/content/reviews`). From there you can approve reviews that were held for
moderation and delete any review at any time.

## A note on data and safety

Reviews are user-submitted and may contain personal data. Drupal escapes the text
on display, so avoid rendering it as raw markup, keep moderation on for
public-facing content, and consider flood control if you see abusive volume. The
module itself provides no access control beyond the permissions above.
