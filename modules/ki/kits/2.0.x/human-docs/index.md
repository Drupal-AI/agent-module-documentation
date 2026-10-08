# Kits — manual setup guide

**Kits** (`kits`) is a **developer library**, not a site‑building feature. It
provides object‑oriented "kits" — reusable, composable builder components for
constructing arrays that are compatible with Drupal's **Render API**. Instead of
hand‑writing deeply nested render arrays, a developer writes fluent, chainable
code and lets Kits produce the array structure.

It is the foundation for the **Form Factory** family of modules (its own tagline
is *"Make custom Drupal forms… faster"*) and it builds on the **Query** library.
Kits has no content, no admin pages, no permissions of consequence, and no
configuration — enabling it simply makes its classes available for other modules
and custom code to use.

Because it's a dependency library, you normally install Kits because another
module requires it, or because you are writing code that uses it directly. There
is nothing to configure and nothing visible in the UI after you enable it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (along with its
   Query dependency) and enable the module.

There is **no configuration page** for this module — it exposes a code library,
not a settings form.

## How to use it

Kits is used from PHP. In your own module or theme, use the builder classes Kits
provides to assemble Render API arrays fluently rather than writing nested arrays
by hand, then return the result wherever Drupal expects a render array. If you are
here because another module (for example one from the Form Factory family) lists
Kits as a dependency, you don't need to write any code — installing and enabling
it is enough.
