# Advertising Entity — manual setup guide

**Advertising Entity** (`ad_entity`) is a framework for managing advertising
across a site in one consolidated place. Serving ads means juggling different
providers, formats, placements, and targeting — and this module treats that as a
management problem rather than a copy-paste one. Ads are **entities**, ad
**providers are pluggable** (chosen via submodules), and **placement** is
configured rather than hard-coded.

The provider submodules cover the common ad platforms: **DFP / Google Ad
Manager** (`ad_entity_dfp`), **AdTech** in two versions (`ad_entity_adtech` and
`ad_entity_adtech_v2`), a **generic** provider (`ad_entity_generic`) for anything
else, and a **fallback** (`ad_entity_fallback`) for when a slot has nothing to
show. It depends on the contributed **Entity API** module (`entity`) and runs on
Drupal 9, 10, and 11.

Because it loads third-party ad scripts, privacy and consent are part of using
it. Ad tags track users and the provider scripts come from third-party origins,
so ad serving should respect cookie/tracking consent — gate the scripts behind a
consent-management module where that is required. Serving ads also has
performance and content-safety implications, since the ad networks control what
actually renders. Configure providers deliberately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Entity API
   dependency, enable it, and pick the provider submodules you need.

## How to use it

Advertising Entity is a site-building framework, so the work is in defining and
placing ads:

1. Enable the base module plus the **provider submodule** for your ad platform —
   `ad_entity_dfp` for Google Ad Manager, `ad_entity_adtech`/`_adtech_v2` for
   AdTech, or `ad_entity_generic` for anything else. Add `ad_entity_fallback` if
   you want a fallback for empty slots.
2. Create your **ad entities** for each unit you want to serve, choosing the
   provider and format.
3. Configure **placement** so each ad appears where you intend.
4. **Gate the ad scripts behind consent** where required, and restrict ad
   administration to trusted users.
