# Configuration

All of this module's configuration lives in **notification** entities — there is
no global settings form. Each notification says: for *this workflow* and *these
transitions*, email *these people* *this message*. You create as many as you need.

## Prerequisite: a content‑moderation workflow

Content Moderation Notifications reacts to workflow transitions, so you need a
working **Content Moderation** workflow first — configured at **Configuration →
Workflow → Workflows** and applied to one or more content types. The notification
you create will be scoped to one of those workflows and its transitions.

## Open the notifications list

1. Log in as a user with the **Administer content moderation notifications**
   permission (grant it only to trusted roles — it controls who receives
   moderation emails, including arbitrary external addresses).
2. Go to **Configuration → Workflow → Content Moderation Notifications**, or
   navigate directly to `/admin/config/workflow/notifications`.

This page lists your notifications, with row operations to edit, delete, and
**enable/disable** each one (disabling keeps it without deleting it — only enabled
notifications fire).

## Add a notification

Click **Add notification** and fill in the form.

- **Label** — a human name for this notification (and its machine name).
- **Workflow** — which content‑moderation workflow this notification watches
  (required). This determines which transitions are available below.
- **Transitions** — tick the transitions of that workflow that should trigger the
  email (for example "Submit for review" or "Publish"). A notification only fires
  when the saved entity's detected transition is one of these.

### Recipients

You can combine any of these; every recipient is placed on the **Bcc** header:

- **Notify author** — email the entity's author/owner.
- **Roles** — every *active* user in the selected roles. Each such user is
  individually checked for **view** access to the moderated entity before being
  emailed, so people only get mail about content they're allowed to see.
- **Emails** — ad‑hoc addresses, comma‑ or newline‑separated. This field is also
  rendered as Twig, so you can compute addresses dynamically (see below).
- **User fields** — entity‑reference user fields on the content; the users they
  reference are emailed. Useful for a per‑node "content owner" or "approver"
  field.

### Visible recipient

- **Disable site mail** — normally the site's email address is the visible "To"
  recipient (with everyone else on Bcc). Turn this on to leave *only* the Bcc
  recipients, so no visible "To" address is used.

### The message

- **Subject** — supports Drupal tokens and inline Twig, e.g.
  `{{ entity.bundle|title }} needs review`.
- **Body** — a formatted text field. It is rendered as Twig, then run through the
  chosen **text format**'s filters before sending — so pick a Full HTML format if
  you want rich HTML email.

Save the notification. As long as it is **enabled**, it will now fire whenever a
matching transition occurs on that workflow.

## Tokens and Twig you can use

In the subject and body (and the ad‑hoc emails field), you have:

- **This module's tokens**, which describe the transition:
  - `[content_moderation_notifications:workflow]` — the workflow's label
  - `[content_moderation_notifications:from-state]` — the previous state's label
  - `[content_moderation_notifications:to-state]` — the new state's label
- **Standard entity, site, and user tokens** (via the optional Token module).
- **Inline Twig** with handy variables such as `{{ entity.title }}`,
  `{{ entity.bundle }}`, `{{ entity.owner.email }}`, and `{{ user.email }}`. You
  can even traverse references to build an ad‑hoc recipient, e.g.
  `{{ entity.field_department.entity.field_manager_email.0.value }}`.

## Managing notifications with Drush

Notifications are ordinary config entities, so they export and import with your
site configuration. Inspect one with, for example:

```bash
drush config:get content_moderation_notifications.content_moderation_notification.<id>
```

The module ships no custom Drush commands.
