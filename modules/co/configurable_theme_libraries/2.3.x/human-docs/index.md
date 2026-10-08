# Configurable Theme Libraries — manual setup guide

**Configurable Theme Libraries** (`configurable_theme_libraries`) lets a theme
declare asset libraries that a site builder can then switch on, off, or swap from
the theme settings page — instead of every library being hard‑wired to always
load. It turns optional theme features (a second colour scheme, a slider library,
an animation bundle) into toggles you flip in the admin UI, with no code change
needed to change which assets a site loads.

The way it works is simple: in your theme's `.info.yml` you add a
`configurable-libraries` key that names one or more selectable library sets, each
of which can carry its own `libraries`, `libraries-extend`, and
`libraries-override` definitions — exactly the same syntax you already use for
normal theme libraries. When the theme is active, this module scans it for those
definitions and exposes them as options on the theme's settings form. Picking an
option determines which libraries actually load on the front end.

Because it is a theming and developer feature, there is no content or access
behaviour here, and nothing to configure globally — the module has no admin page
of its own. All of its "configuration" lives in two places you already know: the
theme's `.info.yml` file (where a developer defines the choices) and the standard
theme settings page (where a site builder makes the choice). It supports Drupal 8
through 11 and has no dependencies beyond core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated configuration page** for this module. What you configure
is your theme (in code) and then your theme's settings — see "How to use it"
below.

## Where it lives in the admin menu

The module adds no admin page of its own. Once a theme defines configurable
libraries, you choose between them on that theme's settings form at
**Appearance → Settings → *(your theme)***
(`/admin/appearance/settings/YOUR_THEME`).

## How to use it

The workflow has two halves — one for a theme developer, one for a site builder.

**1. Define the choices in your theme's `.info.yml`.** Add a
`configurable-libraries` key. Each entry gets a machine name, a human `name`, an
optional `description`, and the same library keys you would normally use. For
example, offering two global styling variants:

```yaml
configurable-libraries:
  global-styling-green:
    name: 'Global Styling (Green)'
    libraries:
      - my_theme/global-styling-green
    libraries-override:
      - my_theme/global-styling: false
  global-styling-blue:
    name: 'Global Styling (Blue)'
    description: 'This makes the site blue.'
    libraries:
      - my_theme/global-styling-blue
    libraries-override:
      - my_theme/global-styling: false
```

**2. Choose which libraries are active.** Go to **Appearance → Settings**, open
your theme's settings, and pick which of the defined configurable libraries should
load. Save, and the front end updates to load only the assets you selected — no
code change required.
