# Etools — manual setup guide

**Etools** (`etools`) is a small collection of utilities and plugins for developers
and site builders — a grab‑bag of helpers to use during Drupal development. It
doesn't add a big user‑facing feature of its own; instead it bundles assorted small
tools that other code can call on.

Because it is a developer/utility module, its helpers operate under the control of
the code that calls them. It has no content model and no access‑control role — you
enable it and reach for whichever utilities you need in your own work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. Once
enabled, its utilities and plugins are available to use.

## How to use it

Enable the module and use whichever of its developer utilities or plugins you need
in your own modules, themes or site‑building work. As a utility bundle it stays out
of the way until you call on it — there is nothing to configure and no admin screen
to visit.
