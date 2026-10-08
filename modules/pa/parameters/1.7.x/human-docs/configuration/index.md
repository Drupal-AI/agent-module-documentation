# Configuration

Parameters is configured entirely by **creating parameters** — there is no global
"settings" form to tune. The administrative screens come from the **Parameters
UI** submodule, so make sure it is enabled (see
[Installation](../installation/index.md)) before you start.

## Open the Parameters interface

1. Log in as a user with permission to administer the site's configuration.
2. With **Parameters UI** enabled, go to the Parameters administration screen,
   where you can list, add, and edit parameters. Parameters can be created for the
   whole site (global) or scoped to a specific content type.

## Two decisions to settle for every value

Before you create a parameter, settle the same two questions that decide *any*
"where does this value live?" problem in Drupal. Getting them right up front saves
a lot of grief later.

### 1. Configuration or content?

This decides the deployment story, and the two submodules exist precisely because
it is a real choice:

- **Configuration** (the base module / Parameters UI) **exports** to your config
  files, is **reviewable in a diff**, and is **overwritten by a config import**.
  That is exactly what you want for a value your team owns in code — but it means
  an editor's change made directly in production is **lost** the next time config
  is imported.
- **Content** (the **Parameters Content** submodule) **survives deployment** and
  is **invisible in code review**. That is what you want for a value a client or
  editor should be able to change in production and keep.

Make this choice **deliberately, per value** — not once for the whole site.

### 2. Remember there is no schema

Part of what makes Parameters convenient is that it stores "arbitrary
properties". The trade‑off is real and worth stating plainly: because nothing
validates the shape of a value, a **typo creates a brand‑new property** instead of
raising an error, nothing checks that a value is the type you expect, and a config
import cannot verify what it is importing. The flexibility is genuine — and so is
the safety net you are giving up. Name properties carefully and double‑check them.

## Create a parameter

On the Parameters admin screen, add a parameter, give it a machine‑readable name,
choose its type/properties, and enter the value(s). Save it. From then on the
value is available through **Tokens**, **Twig**, **ECA**, and the module's API.

> **Auto‑locking:** once a collection of parameters is in active use, Parameters
> locks it so it cannot be deleted through the UI. If you genuinely need to remove
> a locked collection, unlock it first, then delete it.
