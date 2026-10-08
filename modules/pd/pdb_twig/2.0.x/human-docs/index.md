# PDB Twig — manual setup guide

**PDB Twig** (`pdb_twig`) is a Twig implementation for the **Progressively Decoupled
Blocks (PDB)** framework. PDB lets developers build front-end blocks as
self-contained components; PDB Twig adds **Twig** as one of the component options
alongside the JavaScript-framework choices PDB supports. In other words, a block
built with Twig can encapsulate everything it needs and be shipped to a site from a
module or a custom theme — a lighter-weight component option when you do not need a
JS framework.

This is a **developer / decoupling tool**. It has no content of its own, no
end-user-facing settings, and no access-control role — it simply teaches PDB how to
render Twig components. You will get value from it by building or installing PDB
components written in Twig, not by configuring anything in the admin UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside PDB,
   then enable it.

There is **no configuration page** — PDB Twig has no settings form. It enables Twig
components for PDB, which developers then build and place.

## How to use it

Once enabled, PDB Twig makes Twig an available component type within PDB. From
there you (or a developer on your team) build progressively-decoupled blocks as
Twig components in a module or theme; PDB discovers them and makes them placeable
the same way it handles its other component types. Placement and rendering follow
the normal PDB workflow — see the PDB module's own documentation for how components
are discovered and placed.
