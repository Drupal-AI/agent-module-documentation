# Notify Widget — manual setup guide

**Notify Widget** (`notify_widget`) is an in‑site notification system: it both
**sends** messages to users and provides a **widget** to display them. The widget
adds a notifications icon to the page with an iOS‑style red badge showing the
number of unread items, and each notification has a click‑through link that
automatically marks it read when clicked. Supplying both halves — the sending and
the display — is what makes it usable without building a front end yourself.

In‑site notifications sit between email, which people ignore, and nothing, which
tells them nothing. A message that appears the next time the user visits suits
things that matter but are not urgent: your submission was reviewed, your account
changed, something you follow was updated. Notify Widget gives you a place to
put those.

The sending side is a **service** (`notify_widget.api`) with a `send()` method
that your custom code calls to create a notification for one user or many. For
example, a notification can warn a user that their password expires in five days
and link straight to the password page. So while the widget works as soon as you
enable it and place the block, the *notifications themselves* come from code (or
other modules) calling that service — the module does not generate them on its
own.

Before you roll it out, it is worth deciding three things, because they shape
whether an in‑site notification system helps or annoys. **Volume**: notify on
everything and users stop looking, which is worse than not notifying at all.
**Read state**: a notification that cannot be dismissed becomes permanent
clutter. And **retention**: notifications accumulate per user unless something
expires them — a storage question, and, because notifications often quote
content, a data‑retention one. Relatedly, be thoughtful about what a notification
*contains*: "your application was updated" is safe to store and show, but one
quoting a restricted document has copied that content somewhere with different
access rules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   place the block.
2. [Configuration](configuration/index.md) — the settings form (maximum
   notifications, whether to use the bundled CSS).

## Where it lives in the admin menu

The settings form is at **Configuration → System → Notify Widget Settings**. The
user‑facing display is a block you add through **Structure → Block layout**.

## How to use it

To display notifications, add the **Notify Widget** block to a region and set it
to show only for authenticated users. To create notifications, call the service
from custom code — sending to a single user or a list of user IDs:

```php
// Send to one user (uid 1):
\Drupal::service('notify_widget.api')->send(
  '',                                   // source (suggest your module name)
  'warning',                            // type
  'Password Expiry!',                   // title
  'Your password is about to expire in 5 days.', // message
  1,                                    // recipient uid (or an array of uids)
  '/user/password'                      // click-through link
);
```

The first argument is a "source" (currently unused, but the maintainer suggests
passing the name of the module that sets the notification, for possible future
filtering). Passing an array such as `[1, 2, 3]` sends the same notification to
several users.
