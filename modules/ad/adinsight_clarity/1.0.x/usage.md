AdInsight Clarity attaches the AdInsight/ResponseTap dynamic call-tracking script to a Drupal site and provides four ways to place a tracked telephone number in the markup.

---

AdInsight Clarity (the service is now branded ResponseTap) is a subscription call-tracking product: each visitor is shown a unique telephone number drawn from a "number pool" so that phone calls can be attributed to a specific visit and marketing source. This module adds the vendor's dynamic-number JavaScript to every page once an account ID is configured, and exposes the tracked phone number through a block, a text-format filter (`<adinsight />`), Token replacements (when the Token module is enabled), and a plain `<span>` you can paste into a theme template or content. A base number and pool ID are configured in the admin form; the vendor script replaces the base number with a pooled number on page load, while visitors without JavaScript still see the base number. An active AdInsight/ResponseTap account is required for the numbers to actually swap and for calls to be tracked.

---

- Track which website visits lead to inbound phone calls for marketing attribution.
- Show each visitor a unique, dynamically generated telephone number from an AdInsight number pool.
- Add the AdInsight/ResponseTap tracking script site-wide with no template edits (via `hook_page_attachments`).
- Place a tracked phone number in a region using the provided "AdInsight Clarity Telephone Number" block.
- Insert a tracked number inside body/rich-text content with the `<adinsight />` filter tag.
- Reuse the tracked number in Twig templates or entity fields via the `[adinsight_clarity:tag]` token.
- Expose the raw account ID, pool ID or base number as tokens for custom markup or scripts.
- Keep a working fallback number for users who have JavaScript disabled (the base number is rendered server-side).
- Fire call events into Google Analytics (handled by the vendor script) when a tracked number is called.
- Standardise the phone-number markup across a site so every placement uses the same class hooks (`tel-number`, `adinsightNumber{pool}`).
- Render the number as a clickable `tel:` link by choosing the `a` tag variant of the theme.
- Configure the account, pool and base number from a single admin page under Configuration.
- Restrict who can change tracking settings with the dedicated "Administer AdInsight Clarity" permission.
- Migrate an existing AdInsight/ResponseTap setup onto a Drupal 8–11 site without hand-coding the snippet.
- Swap the number pool or base number centrally when a campaign changes, updating every block/filter/token placement at once.
- Provide marketing teams a no-code way to drop tracked numbers into landing pages using the filter tag.
- Cleanly remove all tracking configuration on uninstall (config is deleted in `hook_uninstall`).
- Serve the tracking script over HTTPS automatically when the page is HTTPS (the vendor snippet selects the SSL host).
- Support multiple placements of the same tracked number on one page (block, filter and manual span can coexist).
