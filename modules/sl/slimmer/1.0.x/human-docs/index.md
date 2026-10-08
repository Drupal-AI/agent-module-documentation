# Slimmer — manual setup guide

**Slimmer** (`slimmer`) is a small developer helper for logging in one central
place. It gives custom modules an easy, consistent way to write log messages —
a thin convenience wrapper over Drupal's own logging — so your code doesn't have
to repeat the same boilerplate every time it wants to record something. Its
stated aim is to log watchdog-style messages, including sending them to an
external destination.

The problem it solves is a developer-ergonomics one: rather than wiring up the
logger service by hand in every module, you depend on Slimmer and call its
logging helper. It is purely a developer/API utility — it has no user-facing
screens, adds no content, and has no access-control role.

One sensible piece of logging hygiene applies here as with any logging: **avoid
writing secrets or personal data into log entries**, since logs are often
retained and read by many people. There is nothing to configure — enable it and
use the helper from your code.

It works on Drupal 9, 10, and 11. Note it is **not covered by Drupal's security
advisory policy**.

This guide is written for a **human** installing the module. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Slimmer is a helper you call from custom code. Once it is enabled, have your
module depend on it and use its central logging helper wherever you would
otherwise assemble a logger call by hand — keeping your logging consistent
across the codebase. There is no admin form and nothing to configure.
