# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The Message stack: [Message](https://www.drupal.org/project/message),
  [Message Subscribe](https://www.drupal.org/project/message_subscribe) and
  [Message Notify](https://www.drupal.org/project/message_notify). These are how the
  messaging process is started and how notifiers are selected.
- **Recommended:** a cron runner such as
  [Ultimate Cron](https://www.drupal.org/project/ultimate_cron) if you plan to use the
  throttling queue.
- A **GC Notify account** with an API endpoint URL, a template, a template ID and an
  API key.

## Install with Composer

From the project root:

```bash
composer require drupal/message_gcnotify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/message_gcnotify -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the messaging stack together with this module:

```bash
drush en message message_subscribe message_notify message_gcnotify -y
```

Add `ultimate_cron` to that list if you intend to use the queue.

## Set up the messaging side

Because this module rides on the Message stack, some one-time setup happens there
first (Message Subscribe ships an example module that shows the hooks involved):

1. Configure your message **template(s)** and add a reference field for the node whose
   changes trigger notifications.
2. Add a field for the email **body** on your template, and use **Manage display** to
   map partial 0 to the subject and partial 1 to the body.
3. Create a message with **tokens** in the subject and body.
4. In **Message Subscribe**, select the **GC Notify** notifier.
5. In GC Notify, create a template whose subject is `((subject))` and whose body is
   `((body))`, so Drupal can do the token replacement and multilingual handling and
   hand GC Notify the finished text.

## Verify it worked

Once the module is enabled and configured (see
[Configuration](../configuration/index.md)), trigger a subscribed change and confirm
the recipient receives the GC Notify email. If you enabled the queue, make sure cron
is running so queued items are processed.
