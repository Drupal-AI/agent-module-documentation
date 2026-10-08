Announcement Bar provides a dismissible site announcement banner as a single Drupal block.

---

Announcement Bar adds one block plugin (id `announcementbar`, admin label "Announcementbar") that you place in a region to show a site-wide announcement banner. Its block configuration form sets the message text, a CTA button label, the fixed screen position (top or bottom), background and text colors, and a "cookie interval/period" that controls how long the bar stays hidden after a visitor dismisses it. A small jQuery behavior shows the bar, and clicking the button slides it away and writes a dismissal cookie that expires after the configured interval. The module ships no routes, no permissions, and no config schema of its own — it depends only on core Block and stores its settings on the block config entity. It targets Drupal 9, 10, and 11.

---

- Show a site-wide announcement banner to all visitors.
- Place the "Announcementbar" block in a theme region via Block layout.
- Display a promotional or informational message at the top of the page.
- Display the banner pinned to the bottom of the viewport instead.
- Add a call-to-action button label next to the message.
- Let visitors dismiss the banner by clicking the button.
- Suppress the banner for a set number of minutes after dismissal.
- Suppress the banner for a set number of hours after dismissal.
- Suppress the banner for a set number of days after dismissal.
- Choose a custom background color for the bar.
- Choose a custom text color for the message.
- Announce a cookie-consent or privacy notice.
- Announce a sale, promotion, or campaign.
- Announce planned maintenance or downtime.
- Announce a new feature or release.
- Restrict the banner to specific pages using core block visibility conditions.
- Restrict the banner to specific roles using core block visibility conditions.
- Remove the banner cleanly on uninstall (its block config is deleted).
- Style the bar further via the `announcementbar/announcementbar` library CSS.
- Reuse the `announcementbar_template` theme hook in a custom theme override.
