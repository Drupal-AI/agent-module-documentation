# Configuration

All of Comment Notify's global settings live on one form.

## Open the settings form

1. Log in as a user with the **Administer comment notify** permission.
2. Go to **Configuration → People → Comment Notify**, or navigate directly to
   `/admin/config/people/comment_notify`.

Everything here is stored in a single configuration object,
`comment_notify.settings`.

## Which comment fields are enabled

The notification checkbox only appears on comment forms for the bundles you've
enabled. Each enabled item is a comment field identified as
`entity--bundle--field` (for example `node--article--comment`). A fresh install
enables just `node--article--comment` — comments on articles.

To offer notifications on another content type, add its comment field to the list
(e.g. also enable basic pages by adding `node--page--comment`). Because the
setting works per entity type, this also covers comment fields on non‑node
entities such as taxonomy terms. Removing a bundle from the list turns
notifications off for it entirely.

## Subscription modes offered on the form

Commenters can be offered two ways to follow a discussion:

- **All comments** — email me about every new comment on this content.
- **Replies to my comment** — email me only when someone replies to the comment I
  left.

Both are offered by default. You can hide one of them if you'd rather present a
single choice, but at least one mode must remain enabled.

## Default preferences

These control what's pre‑selected, so most people get a sensible default without
touching anything:

- **Default subscription for commenters** — the option pre‑selected on the comment
  form. The choices are *No notifications*, *All comments*, and *Replies to my
  comment*; the shipped default is effectively "none" (nothing pre‑ticked).
- **Subscribe entity authors by default** — when on, the author of a piece of
  content is automatically subscribed to follow‑up emails about comments on their
  own content. Off by default.

Logged‑in users can override these defaults on their own **account** page, where
Comment Notify adds default‑subscription checkboxes. (Those per‑user preferences
are stored against the user account, not in this settings object.)

## Email templates

Comment Notify sends token‑based emails, and you can edit the **subject** and
**body** of each. There are two audiences, and templates are provided per entity
type (such as *node* and *taxonomy term*), so you can word them independently:

- **Watcher** templates — the email sent to a subscribed commenter.
- **Entity author** templates — the email sent to the author of the commented
  content.

Because the module depends on Token, you can use placeholders in both the subject
and body, for example `[node:title]`, `[comment:author]`, `[comment:body]`,
`[comment:url]`, `[site:name]`, and the unsubscribe token
`[comment-subscribed:unsubscribe-url]`. The token browser on the form lists what's
available. Every notification email should include the unsubscribe link so
recipients can opt out with one click.

## Save

Click **Save configuration** to apply your changes. New subscriptions and emails
follow the updated settings from then on.
