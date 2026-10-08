# Group Media Library — manual setup guide

**Group Media Library** (`group_media_library`) makes Drupal's core **Media
Library** work with the [Group](https://www.drupal.org/project/group) module, so
media can be associated with, and browsed per, a group. The goal is group-scoped
media management: each group works with its own media rather than everyone
sharing one flat library.

The base module is really the plumbing for that idea. It provides a
group-aware media library "state" (a bag of parameters that tells the library
which group it is operating in) and a group finder that works out which group the
media library was opened from. On its own the base module does not change what you
see much — the useful behavior comes from its submodules, which you enable
depending on what you need:

- **Group Media** support (`group_media_library_groupmedia`) — makes the group
  media library work with the Group Media (`groupmedia`) module. It needs the
  Widget submodule (below) enabled, or the group media library state added to your
  widget yourself.
- **Media Tracker** (`group_media_library_media_tracker`) — instantly attaches
  media created through the media library to the corresponding group (found via
  the group finder). Requires Group Media.
- **Widget** (`group_media_library_widget`) — makes the media library *field
  widget* aware of the group it was opened from, by adding the group media library
  state to core's media library widget.

Media access should follow the group's own membership and permission model: this
module bridges media into groups, but it has no access-control role of its own, so
you should verify that group-scoped media ends up visible only to the appropriate
group members through your Group and media access configuration. A companion
module, **Group Media Library Extra**, adds further features on top of this one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose the submodules you need.

There is **no central settings form**. You set media up per group type and via the
media library widget, described under "How to use it" below.

## Where it lives in the admin menu

Group Media Library adds no settings page of its own. It works through the core
**Media Library** (used when adding media to fields) and per group configuration.
The extra, per-group-type media source settings are provided by the companion
**Group Media Library Extra** module.

## How to use it

1. Enable the base module plus the submodules that match your needs (see
   [Installation](installation/index.md)). Most sites want the **Widget**
   submodule so the media library knows which group it was opened from; add the
   **Group Media** and **Media Tracker** submodules if you use the Group Media
   (`groupmedia`) module and want new media attached to the group automatically.
2. Use the media library as usual when adding media to fields — with the Widget
   submodule enabled, it now carries the group context.
3. Confirm that group-scoped media is only reachable by the right group members
   through your Group / media access configuration.
