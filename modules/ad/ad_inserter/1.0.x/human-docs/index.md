# Ad Inserter – Ad Manager — manual setup guide

**Ad Inserter – Ad Manager** (`ad_inserter`) lets administrators define
advertising units and insert them into pages, with placement managed from the
admin UI. The ad units can be banner slots, ad-network snippets, or your own
house ads, and the module gives you a field-based way to attach ad markup to
content so it renders in the positions you configure. It's a straightforward way
to keep ad configuration inside Drupal rather than scattered across templates.

It requires core's **Field** module and runs on Drupal 9, 10, and 11.

One thing to be clear about: ad code is usually third-party JavaScript, pasted in
by an administrator. That makes the **Administer ad inserter**
(`administer ad inserter`) permission a genuinely trusted, powerful capability —
anyone who can edit an ad snippet can inject arbitrary script into your public
pages. Restrict that permission to full administrators, and review any
externally-supplied ad tags before you save them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

1. Enable the module and grant **Administer ad inserter** *only* to trusted full
   administrators (**People → Permissions**).
2. Define your **ad units** in the admin UI — paste the banner/network snippet or
   your house-ad markup for each unit.
3. Configure **placement** so each unit renders in the position you want; the
   module provides a field-based mechanism to attach ad markup to content.
4. **Review** any third-party ad tag before saving it, since it becomes live
   script on public pages.

This is a release candidate (1.0.0-rc8), so test your ad placements before going
to production.
