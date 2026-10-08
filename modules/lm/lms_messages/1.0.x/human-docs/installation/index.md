# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **LMS** module (`lms`) — LMS Messages extends it.
- The **Message** module (`message`) — supplies the message entities.
- The **Message Notify** module (`message_notify`) — delivers the messages.
- The **Token** module (`token`) — for dynamic values in message text.

This is a **1.0.0-alpha5** release, so test it on a non‑production environment
first.

## Install with Composer

From the project root:

```bash
composer require drupal/lms_messages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install LMS,
Message, Message Notify, and Token alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lms_messages -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lms_messages -y
```

Drush will enable the Message, Message Notify, and Token dependencies if they are
not already on.

## A note if you use Group Membership

If the **Group Membership** module is installed, be aware that the automatic
messaging can keep failing until an upstream Group Membership Request issue is
resolved. A patch for this is included with the module — make sure it is applied.

## Verify it worked

With everything enabled, configure a message for an LMS event (via the module's
settings form, protected by the *Administer LMS* permission), trigger that event
with a test learner, and confirm the message is created and delivered. See the
[overview](../index.md#configuring-the-notifications) for how the pieces fit
together.
