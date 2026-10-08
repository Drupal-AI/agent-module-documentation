# Slick Extras — manual setup guide

**Slick Extras** (`slick_extras`) is an add‑on for the **Slick** carousel module.
It ships a handful of extra, less‑common CSS skins, plus two learning sub‑modules
that show you how to build advanced Slick displays. It does not work on its own —
it depends on Slick (version 3.x or newer), which Composer installs for you.

The base module's one real contribution is a set of six extra **skins** that sit
alongside the skins Slick provides. Once the module is enabled and the cache is
cleared, these appear in the **Skin** dropdown of any Slick optionset or field
formatter, exactly like Slick's own skins:

| Skin (in the dropdown) | What it does |
|---|---|
| **X 3d back** | 3D view with the focal slide at the back; best with 3 slides shown and the caption below. |
| **X Boxed** | Adds side margins so the arrows are revealed. |
| **X Box carousel** | Margin‑based alternative to Slick's centre mode. |
| **X Box split** | Margins plus a split caption/image layout. |
| **X Rounded** | Rounds the slide images; good for 3–5 visible slides. |
| **X VTabs** | Vertical‑tab‑style thumbnail navigation. |

The project also bundles two sub‑modules aimed at learning rather than production:
**Slick Example** (`slick_example`) supplies ready‑made sample optionsets (all
prefixed `X`), image styles, and a demo View you can clone; **Slick Development**
(`slick_devel`) adds a settings form and debug JavaScript loader for people
developing the Slick library itself.

The maintainers are explicit that this whole project is sample/scaffolding code:
the intent is that you clone the skin or example you like, make it your own, and
uninstall Slick Extras in production. It is safe to leave enabled if you forget,
but you do not need it running once you have copied what you want.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Slick), enable it, and pick the sub‑modules you want.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. **Clear the cache** — `drush cr` — so the new skins register.
3. Edit or create a Slick optionset at **Configuration → Media → Slick**, or open
   the format settings of a field using a Slick formatter under **Manage display**.
4. Open the **Skin** dropdown; the six `X …` skins above are now listed. Pick one
   and save. `main`‑group skins are offered for the primary carousel; the `X VTabs`
   thumbnail skin is offered for the navigation/thumbnail slider.

If you want to build your own skin, copy the pattern of the `SlickExtrasSkin`
plugin (documented in the [`agent/`](../agent/start.md) docs) rather than editing
this module in place.
