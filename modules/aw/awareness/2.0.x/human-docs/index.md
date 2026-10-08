# Awareness — manual setup guide

**Awareness** (`awareness`) is a developer library, not a feature you switch on and
use. It provides a set of reusable PHP **traits and interfaces** — an API — that
other modules build on when they need context‑aware or file‑aware components. It
depends on core's File module.

On its own it does nothing visible: there is no admin UI, no content type, no
block, and no access‑control role. It simply supplies code scaffolding. You would
install it because another module lists it as a dependency, or because you are
writing a module of your own that wants to reuse the traits and interfaces it
offers.

If you are not a developer and nothing on your site requires it, there is no
reason to enable Awareness by itself.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Awareness has nothing to configure. Use it as a dependency:

- If a module you want to install requires Awareness, install it (Composer will
  usually pull it in automatically) and enable it.
- If you are writing a module, depend on Awareness and use its traits and
  interfaces in your own classes to add file/context‑aware behavior without
  reinventing the scaffolding.
