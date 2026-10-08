# Afterburner — manual setup guide

**Afterburner** (`afterburner`) is a developer framework for running deferred,
background work in Drupal. It provides the pieces — tasks, commands, and event
subscribers — that let heavy or slow operations be queued and processed *after*
the current request finishes, rather than making a visitor wait for them.

It is a foundation for other code rather than a feature you configure and use
directly. A developer defines Afterburner tasks in a custom module, and Afterburner
takes care of deferring and processing them. It works across Drupal 10 and 11 and
has no content or display of its own.

**A note on privileges.** Tasks run with the privileges of whatever queues or
triggers them — the same consideration as any background processing. Make sure
only trusted code enqueues tasks, and be mindful that background work consumes
server resources.

This guide is written for a **human** installing the module. Because Afterburner
is a developer foundation, the day-to-day detail lives in code; if you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Afterburner has no admin screen. Once enabled, developers use it in code: define
Afterburner tasks (and any accompanying commands or event subscribers) in a custom
module, enqueue them where you would otherwise do heavy work inline, and let
Afterburner process them in the background after the request. There is nothing for
a site builder to configure.
