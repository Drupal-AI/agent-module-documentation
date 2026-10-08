# Message recipient — manual setup guide

**Message recipient** (`message_recipient`) answers a question the
[Message](https://www.drupal.org/project/message) stack leaves open: *who should
receive this message?* It lets you attach **recipient collectors** to a message
template, so a notification flow can resolve its audience — the set of users who
should get a given Message — rather than you wiring up recipients by hand every time.

The module is built around collectors. A message template can have one or more
recipient collectors, each of which knows how to produce a list of recipients. It
also exposes a **service** so developers can collect recipients programmatically, and
it is the foundation that companion modules build on — for example, *Message recipient
group* collects recipients from a Group's membership.

Two things to know up front. First, this is an **early alpha release** and the
maintainers explicitly warn it is not yet ready for production use. Second, to manage
recipient collectors through the admin UI you must enable the bundled
**`message_recipient_ui`** submodule; without it, the functionality is available
mainly via the service and configuration. It depends on the
[Message](https://www.drupal.org/project/message) module and supports Drupal 10 and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and turn
   on the UI submodule if you want to manage collectors through the admin interface.

There is **no central settings page** for the base module. Recipient collectors are
managed per message template once you enable the `message_recipient_ui` submodule, as
described below.

## How to use it

1. Install and enable `message_recipient`, and enable the **`message_recipient_ui`**
   submodule so you can manage collectors in the UI.
2. Create a **message template** (via the Message module) if you do not already have
   one.
3. On that template, add one or more **recipient collectors** — each defines a way to
   gather the users who should receive messages of this template.
4. When your notification flow sends a message, the collectors resolve the audience.
   Developers can also call the module's recipient-collection **service** directly;
   see the module's `README` for examples.

To collect recipients from a Group's membership, add the companion
[Message recipient group](https://www.drupal.org/project/message_recipient_group)
module.
