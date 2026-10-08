# LocalGov Microsites Demo Content — manual setup guide

**LocalGov Microsites Demo Content** (`localgov_microsites_demo`) installs a
ready-made set of example content to **demonstrate and develop** the LocalGov
Microsites distribution. Enabling it populates a site with three fully-formed example
microsites — the fictional "Scarfolk" microsites (People's Park, Independent Living,
and Digital Blog) — along with their editor and controller users, pages, news
articles, events, directory channels and venues, taxonomy terms, and image/media
files, with the group relationships between them all wired up.

All of this content is defined through the **Default Content** module: the module's
`.info.yml` lists the UUIDs of every group, user, node, term and file to import, and
enabling the module imports them. On install it also creates or updates per-microsite
domain records, defaulting to DDEV hostnames (`localgov-micro-1.ddev.site`,
`localgov-micro-2.ddev.site`, `localgov-micro-3.ddev.site`) — if your local
environment uses different hostnames, update each domain record after install.

Because it creates demo users (with group roles) and publicly visible content, this is
a **development and demonstration aid — not for production**. It is ideal for kicking
the tyres on the microsites platform, building against realistic content, or
bootstrapping a training or evaluation environment.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pull in its dependencies.

There is **no configuration page** for this module — enabling it imports the demo
content, and that is the whole job. Its behaviour is described under "How to use it"
below.

## Where it lives in the admin menu

The module adds no admin settings page of its own (`configure` is `null`). After
enabling it, you will find the imported content across the usual places — the demo
**microsite groups** (Group UI), the demo **users** (People), and the example
**nodes, directories and taxonomy** (Content and Structure). The per-microsite domains
it creates are visible under the Domain configuration.

## How to use it

1. On a **development or demo** LocalGov Microsites site, install and enable the module
   (see [Installation](installation/index.md)).
2. Enabling imports the three Scarfolk microsites, their six controller/editor users,
   and all their example content.
3. If your local hostnames differ from the DDEV defaults, update each demo microsite's
   domain record after install.
4. Explore the microsites or build against them. To reset a demo environment, you can
   reinstall the module. Note that uninstalling removes the module but not
   already-imported content — that is standard Default Content behaviour.
