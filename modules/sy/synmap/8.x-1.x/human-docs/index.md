# SynMap — manual setup guide

**SynMap** (`synmap`) displays a small, compact map block on your site using either
Yandex Maps or OpenStreetMap (OSM). It is the simple way to show a single location —
an office, a shop, a point of interest — as a little map, without pulling in a heavy
mapping framework. It belongs to the Synapse/Synatix family of modules.

Unlike most modules in that family, SynMap is covered by the security advisory
policy and has a proper settings form, so it is straightforward to set up: enable
it, choose your map provider, set the location, and place the block. It has no other
module dependencies and ships no submodules.

One thing to keep in mind: the map is rendered client-side by a mapping provider. If
you use Yandex, the visitor's browser loads a third-party script and data from
Yandex — so be aware of that data flow, and if the provider needs an API key, store
that key as a secret rather than committing it, and restrict it to your domain where
the provider allows. SynMap is a content-display feature and plays no
access-control role.

This guide is written for a **human** setting the module up through the admin UI. If
you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose the map provider and set the
   location on the settings form.

## Where it lives in the admin menu

Once enabled, SynMap's settings form lives at the `synmap.settings` route. Configure
the map provider and location there, then place the map block through the normal
Block layout screen (**Structure → Block layout**,
`/admin/structure/block`) in whichever region you want the map to appear.
