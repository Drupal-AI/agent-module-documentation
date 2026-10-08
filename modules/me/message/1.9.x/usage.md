Message is a general logging utility that records site activity as reusable *Message* content entities, each built from a *Message template* config entity whose text can carry tokens, single-use arguments, and multi-part "partials".

---

Message provides the stack that "activity stream" and notification features are built on. You define a **message template** (a config entity, machine name stored under `message.template.*`) that holds one or more text *partials* — each a formatted-text value with a text format — and per-template settings for token replacement and purging. At runtime you create a **message** content entity of that template bundle; the message stores optional per-instance *arguments* and renders its text by replacing those arguments and any Drupal **tokens** (e.g. `[message:author:name]`, `[node:title]`) when displayed. Because messages are real entities they are fieldable, translatable, Views-integrable, and can reference other entities so their tokens resolve against them. The template text has unlimited cardinality, so markup partials can be separated from content and reordered or hidden per view mode on the "Manage display" screen. Message supports "dynamic" tokens (re-evaluated every render), "single-use" tokens (`@{...}` replaced once at creation), and custom callback arguments. An auto-purge system (the `message_purge` plugin type, with `days` and `quota` plugins) deletes old messages on cron, configurable globally at `/admin/config/message/message` or overridden per template. It is the foundation for modules like Message Notify, Message Subscribe, and activity feeds.

---

- Build an activity stream that logs "user X did Y" events on the site.
- Record a message whenever a node is published, updated, or deleted.
- Log user registrations, logins, or profile changes for an audit trail.
- Create notification records that Message Notify later emails or pushes.
- Store per-user activity feeds rendered through Views.
- Define a reusable message template with token placeholders for dynamic text.
- Separate HTML markup from message content using multiple text partials.
- Show only a selected partial of a message in a teaser view mode.
- Reorder or hide message partials per view mode on "Manage display".
- Insert live values with dynamic tokens like `[message:author:name]` or `[node:title]`.
- Freeze a value at creation time with single-use tokens such as `@{message:author:name}`.
- Pass custom arguments (`@placeholder => value`) when creating a message.
- Use callback-based arguments to compute replacement text at render time.
- Reference a related entity from a message so its fields become available as tokens.
- Add custom fields to a message template bundle via Field UI.
- Purge messages older than N days automatically on cron.
- Cap stored messages by quota, deleting the oldest beyond the limit.
- Override global purge settings for a single high-volume template.
- Auto-delete messages that reference a node/user/comment/term when that entity is deleted.
- Expose message text as a Views field with per-partial delta selection.
- Translate message templates and render messages in a given language.
- Programmatically create messages from custom code or an event subscriber.
- Migrate legacy activity/log data into message entities via the provided migrate plugins.
- Seed default templates in an install profile with `hook_default_message_template()`.
- Grant editors read-only access to the message overview with the "overview messages" permission.
