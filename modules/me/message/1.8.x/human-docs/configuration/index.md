# Configuration

Configuring Message means two things: creating **message templates** (the reusable
text) and setting up **auto-purging** (how old messages get cleaned up). Creating
the actual message entities is usually done by code or by companion modules, not
from this UI.

## The two entity types

| Entity | Kind | What it is |
|--------|------|------------|
| **Message template** (`message_template`) | Config entity | A reusable piece of templated text plus settings. Exported as `message.template.<id>`. It is also the *bundle* of the message content entity. |
| **Message** (`message`) | Content entity | One logged instance of a template. Its bundle is the template it was created from. |

## Create and edit message templates

1. Log in as a user with the **Administer message templates** permission.
2. Go to **Structure → Messages** (`/admin/structure/message`) to see the list of
   templates.
3. Click **Add message template** (`/admin/structure/message/template/add`) and
   fill in:
   - **Label** — a human-friendly name.
   - **Machine name** (the *template* id) — this doubles as the message bundle id
     (for example `node_created`).
   - **Description** — optional notes about when this template is used.
   - **Message text** — one or more text partials (see below).
   - Token and purge **settings** (see below).
4. Save. Edit later at `/admin/structure/message/manage/<template>`, and delete
   from the adjacent delete link.

### Message text and partials

The **Message text** field has *unlimited* cardinality — each entry is a separate
**partial**, a formatted-text value with its own text format. This lets you keep
markup partials separate from content and manage them independently:

- On the template's **Manage display** tab, each partial shows as its own row, so
  you can reorder or hide partials per view mode.
- With Views, you can render an individual partial (by delta) as a field.

Inside the text you can use two kinds of replacement:

- **Dynamic tokens** — standard Drupal tokens like `[message:author:name]` or
  `[node:title]`. These are re-evaluated every time the message is rendered, so
  they always reflect current data. For them to be replaced, the template's *token
  replace* setting must be enabled.
- **Single-use arguments and callbacks** — values that are frozen when the message
  is created (passed in as arguments by the code that creates the message), or
  computed by a callback at render time. These are set programmatically rather than
  on this form — see the [agent API doc](../../agent/api/message.md).

### Token settings

Each template has a **token options** setting:

- **Token replace** — must be on for `[...]` tokens in the text to be replaced when
  a message is rendered.
- **Clear** — when on, unmatched tokens are blanked out; when off, they are left in
  place.

### Custom fields

Because a message template is a bundle, you can add your own fields to it through
**Manage fields** on the template — for example to store extra structured data
alongside each logged message, which then becomes available to tokens and display.

## Global settings and auto-purging

Message can automatically delete old messages on cron so the table does not grow
without bound.

1. Go to **Configuration → Messages** (`/admin/config/message`) — the settings
   hub — then open the **global settings form**
   (`/admin/config/message/message`).
2. Configure:
   - **Purge enable** — the master switch, evaluated on cron. With it off, no
     automatic deletion happens.
   - **Purge methods** — which purge plugins run. Two ship with the module:
     - **Days** — delete messages older than a given number of days.
     - **Quota** — keep at most a given number of messages, deleting the oldest
       beyond that limit.
   - **Delete on entity delete** — when a message references an entity of a chosen
     type (by default comment, node, taxonomy term, and user) and that entity is
     deleted, the message is deleted too. This keeps activity records from
     dangling.

### Per-template purge overrides

A single high-volume template can override the global purge configuration with its
own settings — turn on the template's *purge override* and define its own purge
methods, so, for example, one busy template is capped tightly while the rest follow
the global policy. Purging runs from cron via the module's purge orchestrator.

### Custom purge methods

Developers can add new auto-purge strategies by implementing the `message_purge`
plugin type (for example "delete messages created on weekends"). See the
[agent plugin doc](../../agent/plugins/purge.md) for the plugin shape.

## Command-line recipes

Templates and global settings are plain config, so core config commands work:

```bash
drush config:get message.template.node_created   # read a template
drush config:get message.settings                # read global settings
drush config:set message.settings purge_enable true -y
```

To list existing templates:

```bash
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("message_template")->loadMultiple() as $t) { print $t->id()."\n"; }'
```

When creating a template in code, prefer the entity API over hand-writing the
`text`/`settings` YAML — it validates the partial structure for you. See the
[agent API doc](../../agent/api/message.md).
