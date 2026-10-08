# Smart Date Starter Kit — manual setup guide

**Smart Date Starter Kit** (`smart_date_starter_kit`) is a configuration kit that
gives you a working head start with the [Smart
Date](https://www.drupal.org/project/smart_date) module. Enable it and it creates
an **Event** content type together with a related **Events view** that has two
displays — upcoming and past events — connected by tabs. It's aimed squarely at
people who want to see Smart Date in action or bootstrap an events section without
hand-building the content type and view themselves.

Because it's purely configuration, once it has set everything up it doesn't provide
any ongoing functionality — you can safely **uninstall it right away** and keep the
Event content type and view it created. The kit has been tested against both recent
branches of Smart Date.

One design choice worth knowing: the **When** field on the Event content type
(which uses Smart Date for its date/time input and display) allows **unlimited
values**. That was deliberate, so the field can support recurring dates if you want
them. If you'd rather each event have only a single date, change that setting at
`/admin/structure/types/manage/event/fields/node.event.field_when/storage`
*before* you add any Event content.

If you also want to display your dates on a calendar, look at the companion **Smart
Date Calendar Kit**.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

After enabling, you'll have an **Event** content type — add events at
`/node/add/event` — and an **Events view** with upcoming and past tabs to list
them. From there you can adapt the content type, fields and view to your needs, or
uninstall the kit and keep what it built.

### Recurring events

Recurring events (available in Smart Date since its 8.x-2.0 release) aren't enabled
by default, but the configuration is built to support them. To turn them on, enable
the **Smart Date Recur** module, then go to
`/admin/structure/types/manage/event/fields/node.event.field_when` and enable
recurring values for the "When" field.
