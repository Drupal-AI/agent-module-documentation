# Configuration

Setting up Message Subscribe has two parts: enabling the **subscription flags**
(so users have something to subscribe with) and reviewing the **admin settings
form** (delivery behavior). Before you can reach the settings form as a normal
admin, you'll also need to sort out a permission.

## First: the permission quirk

The settings form is guarded by the **Administer message subscribe** permission —
but that permission is defined by the **Message Subscribe UI** submodule, not the
base module. So with only the base module enabled, the permission doesn't exist and
**only user 1** can open the settings page.

To let other roles administer it, enable the UI submodule and grant the permission:

```bash
drush en message_subscribe_ui -y
```

Then at **People → Permissions** (`/admin/people/permissions`), give the relevant
roles **Administer message subscribe**.

## Enable the subscription flags

Subscriptions are ordinary **Flag** flaggings. Message Subscribe ships three
ready-made flags, but they're **disabled by default** — enable the ones you need:

1. Go to **Structure → Flags** (`/admin/structure/flags`).
2. Enable and configure the flags you want:
   - **`subscribe_node`** — lets users subscribe to (flag) content.
   - **`subscribe_term`** — lets users subscribe to taxonomy terms.
   - **`subscribe_user`** — lets users "follow" other users.
   - (**`subscribe_og`** also ships when the Organic Groups module is present.)
3. Configure each flag's bundles, link display, and permissions just like any Flag
   flag.

Any flag whose machine name starts with the configured prefix (`subscribe_` by
default — see below) is treated as a subscription flag, so you can add your own
subscription flags for custom entity types using the same naming convention.

## The admin settings form

Go to **Configuration → Messaging → Message subscribe**
(`/admin/config/message/message-subscribe`). The fields:

- **Use queue** *(default off)* — when on, sending a notification enqueues the work
  and Drupal's cron processes it in the background (via the `message_subscribe`
  queue worker) instead of sending inline during the request. Turn this on for
  sites with many subscribers so a single event doesn't block the page.
- **Notify own actions** *(default off)* — when off, the person who triggered the
  event (for example the content's author/editor) is removed from the recipient
  list, so people aren't emailed about their own actions. Turn it on if you do want
  to notify them.
- **Flag prefix** *(default `subscribe`)* — the prefix that marks a flag as a
  subscription flag. A flag counts as a subscription if its machine name starts
  with this prefix plus an underscore (so `subscribe_node`, `subscribe_term`, …).
  Change it (for example to `follow`) if you want to reuse an existing set of flags
  with a different naming scheme.
- **Default notifiers** *(default `email`)* — which Message Notify delivery channels
  are added to **every** recipient. Out of the box only *Email* is available; more
  options appear here if you install additional Message Notify notifiers.
- **Maximum subscribers per batch** *(default `100`)* — when queueing, how many
  subscribers are processed per batch before the job re-queues itself to continue.
  Tune this for large audiences.
- **Debug mode** *(default off)* — verbose logging of who was gathered as a
  subscriber and why, to the `message_subscribe` log channel. Handy for working out
  why a particular user was or wasn't notified — **not for production.**

If you enabled the **Message Subscribe Email** submodule, this form also gains an
**Email flag prefix** field for its per-flag email preferences.

Save the form. Values are stored in the `message_subscribe.settings` configuration
object and can also be read/set from the command line:

```bash
drush config:get message_subscribe.settings
drush config:set message_subscribe.settings use_queue true -y
```

## What happens next

With flags enabled and settings in place, users can subscribe (via the UI submodule
or your own flag links), but notifications only fire when something hands a Message
to the `message_subscribe.subscribers` service. That trigger comes from either the
**Message Subscribe Example** submodule or custom code — the developer API is
documented in the sibling [`agent/`](../agent/start.md) docs.
