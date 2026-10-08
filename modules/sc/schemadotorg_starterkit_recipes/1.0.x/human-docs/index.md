# Schema.org Blueprints Starter Kit: Recipes — manual setup guide

**Schema.org Blueprints Starter Kit: Recipes** (`schemadotorg_starterkit_recipes`)
scaffolds a ready-made **Recipe** content type for a food or recipe site. Enable
it once and it creates a content type mapped to Schema.org **Recipe** — with
fields for ingredients, steps and times — plus a **Recipes** listing view and
some default content to get you started. Instead of modelling a recipe from
scratch, you get a working, structured-data-ready recipe section immediately.

It builds on the Schema.org Blueprints suite (via `schemadotorg_starterkit`) and
pulls in core's **Views**, **Config Rewrite** (`config_rewrite`) and **Default
Content** (`default_content`). As a starter kit it installs configuration the
moment you enable it, so run it on a fresh or evaluation site. There is no
settings form to fill in — the work happens at install time.

Please note that this project is **deprecated and no longer maintained**. The
maintainers recommend using **Drupal Recipes** instead of Starter Kits for new
builds (see the Schema.org Recipes example). Existing installs keep working, but a
Recipe-based approach is the current recommendation. The module also carries **no
official security-advisory coverage**.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the starter kit on a fresh site.

## How to use it

After you enable it on a fresh or evaluation site, look under **Structure →
Content types** for the new **Recipe** type, mapped to Schema.org Recipe with
fields for ingredients, cooking steps and times. The bundled **Recipes** view
lists them, and the default content gives you a few example recipes to see the
model in action. There is no configuration page of its own — review the generated
type, view and content and adapt them to your site.
