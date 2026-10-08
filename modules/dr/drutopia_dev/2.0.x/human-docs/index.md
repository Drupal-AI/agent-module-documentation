# Drutopia Dev — manual setup guide

**Drutopia Dev** (`drutopia_dev`) is a convenience *meta-module* for people
developing or extending a [Drutopia](https://www.drupal.org/project/drutopia)
site. It has no code of its own beyond a `features.yml` marker — its whole job is
to declare dependencies that, in a single enable, assemble the toolkit a Drutopia
contributor or feature-builder expects.

Enabling it pulls in **Devel** (for debugging and inspecting entities/tokens) and
**Entity Clone** (for duplicating content while building) alongside the broad
Drutopia feature set — article, blog, campaign, comment, core, event, group, home
page, landing page, page, people, related content, resource, search, SEO, site,
social, storyline and user. The result is a consistent development environment
with the tools Drutopia development assumes are present, without enabling each
piece piecemeal.

It introduces no routes, permissions or services of its own; its effective
security surface is entirely that of the modules it depends on. Because it brings
in powerful tools like **Devel** and **Entity Clone**, it is meant for **dev and
staging environments only** — disable and uninstall it before deploying to
production. It builds on **Drutopia Core**; see the
[Drutopia Core](../../drutopia_core/2.0.x/human-docs/index.md) guide for the
shared base.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   toolkit on a development environment.

There is **no dedicated configuration page** for this module — it is a
dependency-only meta-module with nothing to configure. Each tool it brings in
(Devel, Entity Clone, and the Drutopia features) is configured through its own
admin pages.

## Where it lives in the admin menu

Drutopia Dev adds no settings page of its own. What it enables is used through the
individual tools — for example **Devel** settings under **Configuration →
Development → Devel settings**, and **Entity Clone** actions on entity edit
screens. The Drutopia content features it pulls in appear under **Structure**,
**Content** and the other usual places.

## How to use it

On a development or staging site, enable Drutopia Dev to bring in the full
developer toolkit in one step. Use Devel to inspect entities and tokens and to
debug, and Entity Clone to duplicate example content quickly while building.
Before releasing to production, uninstall this one module to strip the dev tools
back out. If needed, the distribution also provides a `drutopia_dev_findit`
submodule.
