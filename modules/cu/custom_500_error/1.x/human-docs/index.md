# Custom 500 Error — manual setup guide

**Custom 500 Error** (`custom_500_error`) lets a site administrator customize the
**500 Internal Server Error** page. Out of the box, Drupal core returns a bare,
non‑customizable message — *"The website encountered an unexpected error. Please
try again later."* — with no branding and no way to change the wording or markup.
This module makes both the message and the page markup customizable.

Beyond looks, a good 500 page is a small **security‑hygiene** win. The one rule for
any error page is that it must not leak sensitive information: it should show a
friendly, generic apology, never a stack trace, database detail, or internal path
to an untrusted user. So when you write your custom message, keep it generic and
confirm the custom page doesn't accidentally include debug output.

The module is lightweight, has no dependencies, and works on Drupal 8.8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The module's whole purpose is customizing the 500 page's message and markup. Set
those where the module surfaces them in the admin UI (its settings), as described
in "How to use it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open the module's settings and replace the default 500 message with your own
   friendly, generic wording, and adjust the page markup if you want it branded.
3. **Keep it safe:** write a generic apology only. Do not include any diagnostic
   detail, and confirm the custom page does not surface stack traces, database
   information, or internal paths to visitors.
4. Test it — trigger (or simulate) a server error in a non‑production environment
   and confirm your custom page renders as intended before relying on it in
   production.
