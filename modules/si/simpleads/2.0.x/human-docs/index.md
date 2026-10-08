# SimpleAds — manual setup guide

**SimpleAds** (`simpleads`) is an advertisement-management module. It lets you create
ad blocks, organise ads into campaigns, serve them across your site, and see how they
perform through impression and click statistics.

Ads, ad groups and campaigns are modelled as Drupal entities, so they behave like any
other content you manage. You can build advertisement blocks that rotate ads
automatically, or use SimpleAds reference fields (and Views integration) to hand-pick
particular ads and drop them into other entities. A **responsive** ad type lets you
supply three images — one each for mobile, tablet and desktop — and a bundled
CKEditor 5 plugin lets editors inject ad blocks straight into their content.
Campaigns can be configured to run until they hit a target number of impressions or
clicks, or reach an end date, whichever comes first. Performance figures can be viewed
as charts or tables and exported.

The module defines a full set of permissions covering each ad entity type — add,
edit, delete, and view published/unpublished — plus dedicated permissions for
counting clicks and impressions, so you can decide precisely which roles administer
advertising and which can only view it. It depends on core's **REST** and **Views**
modules and on the contributed **JS Cookie** (`js_cookie`) module, which Composer
pulls in for you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, pull in
   its dependencies, and enable it.

## How to use it

SimpleAds is driven through its entity-management screens and blocks rather than a
single settings form:

1. Create your ads (including responsive ads with per-device images), and group them
   into ad groups and campaigns.
2. Place a SimpleAds block in a region to serve ads there, with optional automatic
   rotation, or reference specific ads through a SimpleAds field on another entity.
3. Set campaign limits (impressions, clicks and/or dates) so a campaign stops on its
   own when it reaches the target.
4. Review impressions and clicks in the built-in statistics as charts or tables, and
   export them.

Grant the per-entity permissions to the appropriate roles so that only trusted users
manage ads while others can view or report on them.
