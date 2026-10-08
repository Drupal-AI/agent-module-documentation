<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
The native content provider for the Advertisement module: an `ad_content` entity you author in the admin UI, served to ad blocks as a random matching ad.

---

`ad_content` turns the `ad` framework into a working self-served ad system. It defines the
**Advertisement** content entity (`ad_content`) — revisionable, translatable, owned, publishable —
with two shipped bundles: **Image advertisement** (an image field, formatted as a click-through
image) and **Text advertisement** (a formatted-text field). It registers the `AdContentBucket`
bucket plugin (id `ad_content`) that answers ad blocks with a random published ad for the requested
placement, an AJAX controller (`/ad/content/render`) that renders ads into their placeholders so
each view can be counted, and image formatters that link the ad to its target URL (optionally
through the `ad_track` click-tracking route). It depends on `ad`, `ad_track`, and core `image`,
`link`, `options`, `text`. Every ad also carries a required **Target URL** and a **Placement**
chosen from the placements defined by the base module.

---

- Create image banner ads through the Drupal admin UI (no ad network needed).
- Create text ads with formatted body text and a summary.
- Give every ad a click-through **Target URL** (rendered with `rel=nofollow`, `target=_blank`).
- Assign each ad a **Placement** so it only serves in matching-size blocks.
- Publish/unpublish ads to control which are live.
- Keep full revision history of ad changes and revert when needed.
- Add custom fields to an ad type via Field UI (bundle base route provided).
- Define additional ad content **types** beyond image/text at `/admin/structure/ad-content`.
- Serve a random published ad per block view via the `AdContentBucket` provider.
- Track impressions per view thanks to the AJAX render placeholder (with `ad_track`).
- Choose the "Ad Image with local click tracking" formatter to route clicks through `ad_track`.
- Show a legally-required "Advertisement" indicator on ad output (`ad.settings` indicator + extra field).
- Grant fine-grained per-type permissions (create/edit/delete/revisions) to editor roles.
- Restrict ad management to trusted users with `administer ads` / `create ads` / etc.
- List and bulk-manage all ads at `/admin/content/ad` with publish/unpublish/delete actions.
- Attach an ad to a section by placing a block that draws from the ad_content bucket.
- Prevent duplicate ad titles (unique-title constraint on the entity).
- Localize ad title and target URL per language (translatable fields).
- Use the `ad_statistics` view (optional config) to review ad performance.
