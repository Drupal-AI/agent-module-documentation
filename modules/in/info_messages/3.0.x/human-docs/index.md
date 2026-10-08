# Info Messages — manual setup guide

**Info Messages** (`info_messages`) adds a new **message type** to Drupal. Out of
the box, Drupal's messenger service knows three kinds of status message — *status*
(green), *warning* (yellow), and *error* (red) — each with its own styling. Info
Messages introduces a fourth: **info**, with its own distinct styling (blue by
default, and fully themeable).

This is a small, developer-oriented utility rather than a click-through feature.
Once the module is enabled, any code on the site can show an info-styled message
using Drupal's standard messenger service — for example a gentle,
non-alarming notice that is clearly neither a warning nor an error. It is handy
whenever you want to communicate information to the user in a visually
distinct way that the three built-in types do not cover.

There is no settings page and nothing to configure; the value of the module is
simply that the `info` message type exists and is styled once it is enabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.
Enabling it is all that is required; how you produce info messages is covered in
"How to use it" below.

## Where it lives in the admin menu

Info Messages adds no admin page. It works purely by registering the new `info`
message type, which then appears wherever Drupal renders status messages.

## How to use it

With the module enabled, add an info-styled message from any custom code using
Drupal's messenger service. Either pass `info` as the message type:

```php
\Drupal::messenger()->addMessage(t('Info text message.'), 'info');
```

or use the dedicated helper:

```php
\Drupal::messenger()->addInfo('Info text message.');
```

The message renders with the module's blue "info" styling. Because it is a normal
Drupal message type, the active theme can restyle it like any other status
message.
