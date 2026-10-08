# LocalGov Open Referral — manual setup guide

**LocalGov Open Referral** (`localgov_openreferral`) helps a **LocalGov Drupal**
council site publish its services directory as an **Open Referral UK** API. Open
Referral UK is an agreed data standard for sharing information about community
services in a machine‑readable form, so other systems — advice tools, partner
directories, aggregators — can consume a council's list of services and
organisations reliably.

The module provides the endpoints and the administration needed to map your
content to the Open Referral standard and expose it over an API. To produce Open
Referral output you will, at a minimum, map some of your content to the standard's
**Organisations** and **Services** types. If you use **LocalGov Directories**, its
submodules can configure that mapping for you automatically; you can also map other
directory entry types yourself.

Because this module *publishes data over an API*, treat what it exposes with care.
A services directory is normally public, but before you go live confirm that the
endpoints publish only the directory data you intend to share and that no internal
or editorial‑only fields leak through the API. Review the exposed output whenever
you change the mapping or upgrade.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module together with its Search API, REST and geo dependencies.

This module has **no single settings form**; you configure it by mapping your
content types to Open Referral Organisations and Services (most easily via LocalGov
Directories) and by managing the standard REST/Views and Search API configuration
it installs.

## Where it lives in the admin menu

LocalGov Open Referral does not add one dedicated configuration page. Its work
happens across the standard tools it builds on — **Search API**
(`/admin/config/search/search-api`), **Views**, and the REST/serialization layer —
plus the content‑to‑standard mapping. On a site running **LocalGov Directories**,
that mapping is set up for you by the directories submodules.

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. Map content to the standard: enable the relevant **LocalGov Directories**
   submodules to configure **Organisations** and **Services** automatically, or map
   your own directory entry types.
3. Index your directory content through Search API so it is available to the
   endpoints.
4. **Before publishing:** review the API output and confirm only intended, public
   directory fields are exposed — and restrict administration of the mapping and
   endpoints to trusted roles.

This is a distribution‑specific feature: it expects a LocalGov Drupal site with a
services directory to publish.
