Back To Top adds a configurable button that hovers over the page and smoothly scrolls the visitor back to the top when clicked.

---

Back To Top attaches a small front-end library (`js/back_to_top.js`, jQuery + core/once) to every page via `hook_page_attachments()`. Once the visitor scrolls past a configurable pixel threshold, a `#backtotop` button fades in; clicking it runs an eased `requestAnimationFrame` scroll to the top, and the animation cancels if the user scrolls, clicks, or types (so it never "locks" the screen). Everything is driven from one settings form at **Admin → Configuration → User interface → Back To Top** (`/admin/config/user-interface/back_to_top`, route `back_to_top_settings`), gated by the single `access back_to_top settings` permission. Site builders choose between a PNG image button (`back_to_top_icon` library) or a CSS/text button (`back_to_top_text` library), set the button label, pick one of nine screen positions, and tune the scroll trigger distance and animation speed. The text button's background, border, hover, and text colors are configurable and injected as an inline `<style>` in the page head when they differ from defaults. Visibility can be suppressed on mobile/touch screens (≤760px), on all admin/node-edit pages, and on the front page; a `hook_back_to_top_admin_prevent` alter lets other modules refine the admin check. All settings live in the `back_to_top.settings` config object with a full schema, so they export and deploy as configuration.

---

- Add a floating "back to top" button to a long-scrolling site so readers can jump to the header.
- Smoothly animate the scroll instead of teleporting the viewport to the top.
- Let the scroll animation cancel automatically when the user interacts with the page.
- Show the button only after the visitor scrolls a set distance (default 100px trigger).
- Speed up or slow down the scroll animation via the millisecond speed setting (default 1200).
- Use the default PNG-24 image button for a graphical look.
- Switch to a CSS/text button and set your own label (e.g. "Top", "Back to top").
- Style the text button's background, border, hover, and text colors to match the theme.
- Place the button in any of nine positions (bottom/top/mid × left/center/right).
- Hide the button on mobile and touch devices (screens up to 760px wide).
- Keep the button off all administration pages and node edit forms.
- Keep the button off the front page while showing it on interior pages.
- Refine which pages count as "admin" for the prevent-in-admin check via a hook.
- Deploy button configuration between environments as exported config.
- Give a non-admin role rights to tune the button with the `access back_to_top settings` permission.
- Improve UX on documentation or blog pages with very long content.
- Provide an accessible scroll control (button wrapped in a labelled `<nav>` with an aria-label).
- Add a return-to-top affordance without writing any custom JavaScript or theme code.
- Match the button color scheme to a dark or branded theme using the color fields.
- Reposition the button to top-center or mid-left for unconventional layouts.
- Reset to an image button by choosing the "Image (default)" button type.
