# SM Entity Scheduler — manual setup guide

**SM Entity Scheduler** (`sm_entity_scheduler`) automatically hides
(unpublishes), reveals, or deletes content entities once a **date field on them
has passed** — driven by configuration and run on the Symfony Messenger
Scheduler engine (the `sm` and `sm_scheduler` modules).

What makes it different from form-driven schedulers is that it triggers off an
existing date field already on the entity — for example one populated by an
import — rather than a publish/unpublish date an editor types in. It
re-evaluates that field on every run and works with **any content entity type**,
including Commerce product variations. Because it runs on Symfony Messenger
rather than `hook_cron`, a recurring scan fans expired entities out as batched
messages to a consumer, so it scales to large catalogues without cron timeouts.

You configure it with "schedule" config entities. Each schedule names the target
entity type and bundles, the date field to watch, its semantics, an
**enforcement strategy**, a cron expression, and a batch size. The enforcement
strategies are pluggable: **status** (unpublish via the core published flag),
**visibility_field** (a dedicated boolean plus an entity-access veto), and
**delete** — and you can add your own.

It depends on core **Datetime**, plus **Symfony Messenger** (`sm`) and **Message
Scheduler** (`sm_scheduler`), and requires **Drupal 11.3+** (it uses plugin
constructor autowiring). It is covered by Drupal's security advisory policy. It
provides its own permissions to control who may manage schedules.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

After installing and enabling the module:

1. Make sure the target entity bundle has a **date field** to watch — add one, or
   reuse an existing field (for instance one filled by an import).
2. Create a **schedule** config entity that points at that date field and choose
   an **enforcement strategy** (status / unpublish, visibility field, or delete),
   together with the target bundles, cron expression, and batch size.
3. Run a **Symfony Messenger consumer** (for example `bin/sm messenger:consume`)
   so the recurring scan and the batched messages are actually processed.

From then on the scan re-evaluates the date field on every run and enforces your
chosen action on entities whose date has passed.
