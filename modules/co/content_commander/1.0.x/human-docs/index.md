# Content Commander — manual setup guide

**Content Commander** (`content_commander`) is a **developer tool for declarative,
dependency‑aware content generation**. You describe each piece of content as a case
of a PHP **enum**, and Content Commander creates the matching Drupal entities,
resolving the dependencies between them automatically. It runs from the **Dex
console** (its dependency `dex_console`), which is where all the work happens — there
is no web UI.

The idea is to make seed, demo, and test content **repeatable and identical across
environments**. Each enum case implements `ContentInterface`, supplies a stable UUID
(or lets the module allocate and record one), names the entity class to build, and
provides a `createContent()` body that fills in the fields. Dependencies between
content items are declared with a `#[DependsOn(...)]` attribute; Content Commander
topologically sorts them so a referenced entity is always created first, and it
aborts if it finds a circular dependency. Because UUIDs are stable, the same logical
content resolves to the same entity everywhere — ideal for fixtures you want to
export as config and share between sites.

This is strictly a **developer / CLI tool**: it registers no routes, no permissions,
and no web‑facing endpoints, so it has no anonymous or HTTP attack surface — it runs
only through the Dex console, which itself requires shell access. Be aware that the
`-d`/`--delete` flag is **destructive**: it deletes any existing entity with the same
UUID before recreating it, so **avoid it on production**, where it could wipe real
edits. This project is covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   Dex console) and enable the module.

There is **no configuration page** — Content Commander is authored in code and run
from the Dex console. See "How to use it" below.

## How to use it

1. **Write your fixtures in code.** In any custom module, create a `src/ContentCommander/`
   directory and add an **enum** whose cases implement
   `Drupal\content_commander\ContentInterface` (the `ContentTrait` is available to
   help). Each case gives a UUID (or returns `null` to have one allocated and stored
   in the `content_commander.content_mapping` config), the entity class, and a
   `createContent()` method that sets the fields.
2. **Declare dependencies.** Attach `#[DependsOn(self::Other)]` to a case so the
   referenced entity is created first; add `optional: true` when its usage is
   conditional. Inside `createContent()`, retrieve a dependency via the
   `ContentContext`.
3. **Generate content** from the Dex console — for example `dex
   content-commander:create-all` to create everything discovered, or a per‑enum
   command. Existing content is skipped on a normal run (idempotent).
4. **Reset when needed** by adding `-d`/`--delete`, which deletes any matching
   same‑UUID entity before recreating it — handy in development, but **not for
   production**.
5. **Read content back** in code by injecting `ContentRepositoryInterface` and
   calling `getEntity($enumCase)`.

For the full authoring reference (enum shape, UUID handling, dependency rules), see
the [`agent/api/enums.md`](../agent/api/enums.md) developer notes.
