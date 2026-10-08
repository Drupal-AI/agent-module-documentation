# Navigation + — manual setup guide

**Navigation +** (`navigation_plus`) is a shared editing-interface foundation for a
whole suite of page-building tools. Rather than each module inventing its own
toolbar, edit mode, sidebar, and keyboard shortcuts, Navigation + supplies those
once — a tool plugin type, mode plugins, sidebars, and hotkeys — all built on top
of Drupal core's **Navigation** module. It also ships an optional **Edit Mode**
that presents a Photoshop-like toolbar for editing a page inline.

The clearest way to understand it is as the substrate beneath **Layout Builder +**
and the wider "+ Suite" page builder. Several editing tools all need the same
plumbing: a way to enter and leave edit mode, somewhere to place tool buttons, a
sidebar that opens with tool-specific controls, an entity being edited, hotkeys,
and a consistent look. Navigation + provides that plumbing as plugin types
(`ToolPluginManager`/`ToolInterface`, `ModePluginManager`/`ModeInterface`,
`SidebarInterface`) so the tools share one coherent interface. In practice you
rarely install it on its own — it usually arrives as a dependency of `lb_plus`.

Adopting Navigation + is a stack decision rather than a casual module install. It
is **Drupal 11 only** and depends on core's `navigation` module plus the contrib
modules `twig_events` and `tempstore_plus`. One submodule,
**`navigation_plus_entity_workflow`**, is **deprecated** — its functionality has
moved into the main module and it is slated for removal, so do not enable it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer and enable it.

There is no field-by-field configuration page worth walking through here: the
module exposes a small settings form (see below) and most of its behavior is
driven by the tools and modes that other "+ Suite" modules register.

## Where it lives in the admin menu

Once enabled, Navigation + replaces the standard Navigation experience for editors
who have the right permissions. Its own settings form sits at **Configuration →
Content authoring → Plus Suite** (`/admin/config/content/plus-suite`).

Three permissions keep the concerns properly separated:

- **`use toolbar plus edit mode`** — for editors who use Edit Mode.
- **`configure toolbar plus modes`** — for the people who decide which modes exist
  on which entity types and bundles.
- **`administer Navigation + configuration`** — for the settings page above.

The per-user routes (such as saving your own hotkeys) act on the current user's
own settings, so one editor cannot change another's shortcuts.
