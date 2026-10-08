# Big pipe override — manual setup guide

**Big pipe override** (`big_pipe_override`) turns off Drupal core's BigPipe — the
streaming/placeholder rendering that sends a page shell first and then streams
dynamic parts in afterwards. This module exists for the cases where that streaming
behavior causes problems: a front-end setup, a reverse proxy, or a decoupled/caching
layer that does not cope well with streamed responses.

It is a performance and rendering tool with a single job. Once enabled, BigPipe is
disabled and dynamic content renders inline (all at once) rather than being streamed
in. That is a genuine trade-off: inline rendering can change perceived performance,
so enable this only when BigPipe is actively getting in your way, and weigh the
effect on how quickly pages appear to load.

The module has no content or access-control role and nothing to configure — enabling
it *is* the setting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings page. The module's entire effect is to disable BigPipe as soon
as it is enabled; you turn the behavior on and off by enabling or uninstalling the
module.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. From that point BigPipe is disabled site-wide and dynamic content renders inline.
3. If you decide you want BigPipe back, simply uninstall this module — core BigPipe
   resumes its normal streaming behavior.
