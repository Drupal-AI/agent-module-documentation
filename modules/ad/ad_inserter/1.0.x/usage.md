Ad Inserter (Ad Manager) stores HTML/JavaScript ad snippets as content entities and renders them across a Drupal site through blocks, with mobile/desktop screen targeting.

---

Ad Inserter is a lightweight ad-management module built on a single content entity type, `ad_inserter`. An administrator creates an ad by giving it a name, an optional machine name, a `body` (the raw HTML or ad-network `<script>` snippet), a screen target (`all`, `mobile`, or `desktop`), and an active/inactive status. Ads are surfaced on the site with two block plugins: "Ad Inserter" (pick an ad by entity reference) and "Ad Inserter by machine name" (reference an ad by its stable machine name so the same slot works across environments). A small loader library reads a configurable mobile breakpoint from the settings form and, in the browser, removes or reveals each ad block depending on whether the current viewport is mobile or desktop. Managing ads (create/edit/delete, plus the settings form) is gated by the single `administer ad inserter` permission; ad markup is authored by administrators and rendered as-is, so it is trusted, script-capable input. Requires the core `field` module.

---

- Store banner and ad-network snippets as reusable ad entities.
- Paste a third-party ad tag (AdSense, GAM, affiliate) into the ad body and render it site-wide.
- Serve house ads without an external ad network.
- Place an ad in any region via the "Ad Inserter" block and pick the ad from an autocomplete.
- Reference an ad by machine name (`ad_inserter_sidebar_top`) so the same block works across dev/stage/prod.
- Target an ad to mobile screens only.
- Target an ad to desktop screens only.
- Show an ad on all screens regardless of viewport.
- Configure the mobile/desktop breakpoint (default 600px) on the settings form.
- Toggle an ad active or inactive without deleting it (inactive ads render nothing).
- Manage all ads from an admin list at `/admin/ad-inserter/list`.
- Add, edit, and delete ads from the admin UI.
- Give each ad a human-readable name plus an optional stable machine name.
- Attach the same ad to multiple regions by placing multiple blocks.
- Keep ad configuration and markup inside Drupal rather than a remote console.
- Rotate house-ad creatives by editing one ad entity referenced from many blocks.
- Monetise content with network or direct-sold ads.
- Use Views (an `ad_inserter` base-table view ships) to build custom ad listings.
- Restrict ad management to trusted staff via the `administer ad inserter` permission.
- Support Drupal 9, 10, and 11 sites.
- Add per-ad theme overrides using the `ad_inserter__<id>` template suggestion.
- React to ad visibility in custom code via the `hook_ad_inserter_alter_status` alter hook.
