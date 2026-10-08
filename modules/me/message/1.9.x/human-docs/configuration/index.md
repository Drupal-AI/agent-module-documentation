# Configuration

There are two sides to configuring Message: the **global settings** (mostly about
purging old messages), and the **message templates** you create to define each kind
of event.

## Global settings

Go to **Configuration → Message → Message settings**
(`/admin/config/message/message`, route `message.settings`). These control what
happens to stored messages over time, and are also editable with `drush config:set`
on the `message.settings` object:

- **Enable purging** (`purge_enable`) — the master switch for automatic deletion,
  evaluated on cron. With it on, you configure one or more **purge methods** (for
  example cap messages by **age in days**, or by a **quota** / maximum count).
  Purging runs from cron.
- **Delete on entity delete** (`delete_on_entity_delete`) — automatically delete
  messages that reference an entity when that entity is deleted. By default this
  covers comments, nodes, taxonomy terms, and users.

A message template can also **override** the global purge configuration with its own
purge settings, so specific event types can be kept longer or shorter than the
site-wide default.

## Message templates

Templates are where you define each kind of event. Manage them at **Structure →
Messages** (`/admin/structure/message`), which requires the **Administer message
templates** permission.

### Create a template

Click **Add message template** (`/admin/structure/message/template/add`) and set:

- **Label** and **machine name** — the human name and id (the template id becomes
  the bundle for message content).
- **Description** — an administrative description of when this message is logged.
- **Text** — one or more **partials**. Each partial is a formatted-text value, and
  a template can have any number of them. Partials are token-aware — you can embed
  tokens like `[message:author:name]` or `[node:title]` that are replaced when the
  message is rendered. On the template's **Manage display** page each partial shows
  as its own row, so you can reorder or hide partials per view mode, or render an
  individual partial via Views.

To make tokens actually resolve at render time, the template's **token options**
must have "token replace" enabled; a separate "clear" option decides whether
unmatched tokens are blanked out.

### Add fields and configure display

Because a template is a bundle of the message content entity, you can add custom
fields to it with **Field UI** from the template edit form, and arrange both the
fields and the text partials on **Manage display**. Referencing a text format in a
partial creates a configuration dependency on that filter format.

### Export

Message *templates* are configuration (config name `message.template.<id>`), so
they export and deploy between environments with `drush config:export` / `import`.
The stored **messages** themselves are content and are not exported.

## Save

Save the settings form and each template as you create it. Prefer creating
templates and messages through the admin UI or the module's API (which validates the
partial/settings structure) over hand-editing YAML.
