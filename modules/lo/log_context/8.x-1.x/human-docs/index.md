# Log Context — manual setup guide

**Log Context** (`log_context`) is a small **front-end development tool** that logs
the JavaScript **`context`** variable to the browser console every time
**`Drupal.attachBehaviors`** is called. If you write Drupal behaviors, that context
is what tells you *which part of the page* a behavior is being run against — and
seeing it live makes a whole class of Ajax bugs much easier to diagnose.

The classic problem it helps with: when Ajax replaces part of a page and your
script hasn't properly leveraged `context` or `jQuery.once`, behaviors can attach
more than once — so click handlers fire twice, effects "repeat," or you get
destructive interference. Other times (modals are a common culprit) you *think*
something is in context when it really isn't. By logging the context on every
attach, Log Context lets you watch exactly what each behavior attachment is
operating on. It also provides a **test function you can call from the console** to
check whether your site is "Ajax proof."

This is explicitly a **development-only** module — it is not intended for
production sites. It supports Drupal 9.2 and up, 10, and 11. Note that the project
is currently marked **unsupported / no further development**, so treat it as a
handy local debugging aid rather than something to depend on long term.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (on a development environment).

There is **no settings page** for this module — once enabled it simply logs the
context on every `Drupal.attachBehaviors` call. Use it as described under "How to
use it" below.

## Where it lives in the admin menu

Log Context adds no admin page. Its output appears in your **browser's developer
console**, not in the Drupal admin UI.

## How to use it

1. Enable the module on a development environment.
2. Open your browser's developer console.
3. Interact with the site — especially Ajax-heavy interactions and modals. Each
   time `Drupal.attachBehaviors` runs, its `context` is logged to the console, so
   you can see what each behavior attachment is scoped to.
4. Use the module's console **test function** to check whether your behaviors are
   "Ajax proof."
5. Disable the module when you're done — it's not for production.
