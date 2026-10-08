# Site Studio Gin — manual setup guide

**Site Studio Gin** (`sitestudio_gin`) is a small compatibility shim that makes
**Acquia Site Studio** (the Cohesion page builder) look and behave correctly when
the **Gin** admin theme is active. If you build pages with Site Studio and you
use Gin as your administration theme, the two do not visually agree out of the
box — this module reconciles them so editors get a clean, consistent experience.

It does two things and nothing else. First, it loads a set of CSS overrides: a
small global stylesheet on every page, plus a Gin‑specific stylesheet only when
Gin (or a subtheme of Gin) is the active admin theme. On the Site Studio
component front‑end edit screen it also removes Gin's secondary toolbar so it does
not intrude on the Site Studio editing iframe. Second, it re‑styles Site Studio's
Component Content add/edit forms to use Gin's familiar node‑form layout —
converting the vertical‑tab groups (advanced settings, authoring metadata,
revision information) into Gin's container/accordion style.

There is **nothing to configure** — no settings form, no permissions, no blocks.
Once the module is enabled with Gin active, it simply works. It depends on the
Site Studio (`cohesion`) module and requires the Gin theme to be installed;
installation is deliberately blocked if Gin is not present.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, make sure Gin
   and Site Studio are present, and enable the module.

## How to use it

There are no options to set. After you install and enable the module (with the
Gin theme installed and set as your admin theme, and Site Studio in use), its
overrides apply automatically:

- Site Studio's admin UI renders correctly under Gin.
- Site Studio Component Content add and edit forms adopt Gin's node‑form layout.
- Gin's secondary toolbar is hidden inside the Site Studio component edit iframe.

If you use a **subtheme of Gin** rather than Gin itself, the module detects that
automatically (it walks the active theme's base‑theme chain) and still applies
the Gin‑specific styling. If some other admin theme is active, the Gin‑specific
overrides simply stay dormant so nothing breaks.
