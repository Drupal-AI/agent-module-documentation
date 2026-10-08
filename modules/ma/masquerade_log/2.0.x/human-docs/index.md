# Masquerade Log — manual setup guide

**Masquerade Log** (`masquerade_log`) is a small, zero‑configuration companion to
the **Masquerade** module that fixes a subtle but important gap in your audit
trail. Normally, when an administrator uses Masquerade to impersonate another
user, any log entries created during that session are attributed to the
*impersonated* account — so you lose track of who was really at the keyboard. This
module makes the log record the **original** (real) user as well.

With it enabled, every log message written while someone is masquerading gains a
suffix like `[masquerading joe, uid 1234]`, and structured loggers (such as core's
Database Logging / watchdog) also receive two extra context values,
`@original_uid` and `@original_username`. That means you can attribute a suspicious
or privileged action to the operator who performed it, trace a support agent's
steps taken while impersonating a customer, and satisfy compliance requirements
that say logs must show who really did what. When nobody is masquerading, the
module does nothing at all — normal log lines are untouched.

It works across every logging channel at once (database log, syslog, and others),
so you don't need to configure anything per‑channel or write custom logging code.
It depends on the **Masquerade** module and does its job purely by transparently
wrapping the site's loggers.

There is genuinely **nothing to configure** — no settings page, no permissions, no
options. Installing it (alongside Masquerade) is the entire setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Masquerade.

## Where it lives in the admin menu

Nowhere — the module has no settings page, permissions, or admin links of its own.
Once enabled, it silently augments Drupal's logging. You'll see the effect on the
existing log screens: **Reports → Recent log messages** (`/admin/reports/dblog`),
where entries created during a masquerade session carry the `[masquerading …]`
note.

## How to use it

1. Make sure the **Masquerade** module is set up and that administrators use it to
   impersonate users as normal.
2. With Masquerade Log enabled, simply review your logs at **Reports → Recent log
   messages**. Any action taken while masquerading now shows the real user's
   username and uid appended to the message, and (for database logging) stores the
   original user in the entry's context.

That's it. There are no options to tune — the module either records the original
user during a masquerade session, or stays completely out of the way when no one
is masquerading.
