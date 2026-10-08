<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lupus Decoupled Site Info exposes basic site settings — name, slogan, front page and similar — so the front end does not hard-code them.

---

Every decoupled front end needs a handful of facts about the site it is rendering: the name for the title tag, the slogan, which path is the front page, the default language. Hard-coding them means two sources of truth and a deployment to change the site name, which is exactly the kind of small friction that accumulates.

This submodule exposes them over the API so the front end reads them at runtime. A site owner changing the site name in Drupal changes it on the front end.

It is a small piece with a disproportionate effect on whether a decoupled site feels like one system or two. The thing to plan is caching: site information changes rarely and is needed on every render, so it should be fetched once and cached in the front end with a sensible invalidation, not requested per page.

---

- Expose the site name to the front end.
- Expose the site slogan.
- Tell the front end which path is the front page.
- Read the default language at runtime.
- Avoid hard-coding site settings in the front end.
- Change the site name without a deployment.
- Keep one source of truth for site settings.
- Cache site information in the front end.
- Invalidate cached site info on change.
- Build the title tag from Drupal's site name.
- Support several environments with one build.
- Read email or contact settings if exposed.
- Reduce configuration duplication.
- Audit what site information is exposed.
- Plan front-end caching for rarely changing data.