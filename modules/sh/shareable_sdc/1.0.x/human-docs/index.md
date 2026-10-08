# Shareable Single Directory Components — manual setup guide

**Shareable Single Directory Components** (`shareable_sdc`) extends Drupal's core
Single Directory Components (SDC) feature so that components can live in a global
`/components` directory rather than being tucked inside a single theme or module.
The result is that one component can be shared and reused across your whole site —
by different themes and modules — from one central location.

Out of the box, core SDC ties each component to the theme or module that ships it.
This module lifts that restriction by discovering components placed in a top-level
`/components` directory, which is handy if you are building a design system or want
a shared component library that is not owned by any one theme.

This is a developer and theming tool. It has no content of its own and no
access-control role — it simply changes where Drupal looks for SDC components.
There is nothing to configure through the admin UI: once enabled, you work with it
by placing component directories in `/components`. It requires **Drupal 11** and has
no other dependencies or submodules.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

After enabling the module, create a top-level `/components` directory in your
project and place your Single Directory Components there (each component in its own
subdirectory, in the usual SDC layout). Drupal will discover them globally, so any
theme or module can render them. There is no settings form — the directory *is* the
configuration.
