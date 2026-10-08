<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Display Link Plus adds a Views header/footer area handler that renders an access-checked link from one display of a view to another display in the same view.

---

Install it like any contributed module (`composer require drupal/display_link_plus`, then enable it at **Extend** or with `drush en display_link_plus`); it depends only on core's **Views**. To use it, edit a view, open the **Header** or **Footer** section, click **Add**, choose **Display Link Plus**, and **Apply**. In the handler's options you pick the **Display** to link to (only *path-based* displays such as a `page` are offered), optionally set a **Label** (blank falls back to that display's title), one or more space-separated CSS **Class**es (use `button` to style it as a button), and a **Target** of *Default*, *Off-Screen Tray*, or *Modal Dialog* — the tray/modal options reveal a **Dialog Width** in pixels. A checkbox appends the current **destination** so a linked add/edit form returns the user to the listing, and when the current display has contextual filters an **Arguments mapping** section lets you copy each argument's value into a named query-string parameter (optionally passing multiple values). What makes this better than a hand-built link is that it performs an **access check as part of rendering** (`#access`), so the link only shows to users who can actually reach the target display; it also preserves exposed-filter and pager state in the generated link. The upgrade path added a `destination` append option (default off for new links; an update hook turns it on for links that already existed). There is no separate settings page — all configuration is per view, stored in the view's config and covered by config schema.

---

- Add an editorial "add content" style link to a public-facing view's header.
- Link from a summary listing display to its detailed page display.
- Show a "View all results" link in a block view's footer.
- Reveal the link only to users who can access the target display.
- Open the linked display in a modal dialog overlaid on the page.
- Open the linked display in an off-canvas tray.
- Set a custom pixel width for the modal or tray dialog.
- Style the link as a button with the `button` CSS class.
- Apply multiple space-separated CSS classes to the link.
- Override the link text with a custom label.
- Fall back to the target display's title when no label is entered.
- Append a destination so a linked form returns the user to the listing.
- Map a contextual filter argument into a query-string parameter on the link.
- Pass multiple argument values through to the linked display.
- Preserve exposed filter values when linking to another display.
- Preserve the current pager page in the generated link.
- Provide an in-context "jump to related view" link.
- Restrict the link target to path-based displays only.
- Add several links, one per target display, in one header.
- Replace a hand-built Views header link with an access-checked one.
- Link a listing to a `feed` display of the same view.
- Build intuitive navigation between displays of a single view.
