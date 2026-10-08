printfriendly adds a Print Friendly & PDF button to chosen node types that opens the third-party PrintFriendly.com widget, letting visitors print, email, or download a page as a PDF.

---

The module is a thin integration with the hosted PrintFriendly service. On every page it injects an inline `<script>` (built in `printfriendly_page_attachments()`) that sets `pf*` JavaScript variables from the module's config and loads `//cdn.printfriendly.com/printfriendly.js`. `printfriendly_node_view()` appends a button to nodes whose type (or the `teaser` view mode) is selected in config, but only for users who hold the `access printfriendly` permission; the button is an `<a href="https://www.printfriendly.com/print?url=…">` pointing at the current page URL, rendering a chosen button image from `cdn.printfriendly.com` (or a custom image URL). All configuration lives in `printfriendly.settings` and is edited at `admin/config/printfriendly/config`: which content types/teasers show the button, the button image, and PrintFriendly feature toggles (header logo/tagline, click-to-delete, include/exclude images and image alignment, allow/deny the email/PDF/print actions, custom CSS URL). There is no config schema shipped, no Drush, and no plugin types. Because PrintFriendly renders the printable version by fetching the page, password-protected or JS-rendered sites require a PrintFriendly Pro subscription. Note the integration sends the visited page URL to printfriendly.com and loads third-party JS/assets on every page.

---

- Add a Print/PDF/email button to article and page nodes.
- Show the button on teaser listings as well as full nodes.
- Let visitors download any node as a PDF via the PrintFriendly widget.
- Let visitors email a cleaned-up version of a page.
- Offer an on-page lightbox print preview without leaving the site.
- Restrict who sees the button with the `access printfriendly` permission.
- Choose from several bundled button/icon images.
- Use a fully custom button image by URL.
- Add a custom header logo and tagline to the printed output.
- Toggle whether images are included in the printable version.
- Set image alignment (left/right/none/center) in the printout.
- Enable or disable the Email action in the widget.
- Enable or disable the PDF action in the widget.
- Enable or disable the Print action in the widget.
- Allow or forbid click-to-delete of page elements before printing.
- Apply a custom CSS URL to the printable output.
- Give editorial/marketing pages a professional print option with no print.css work.
- Provide branded PDFs so the site URL is retained in saved documents.
- Limit the button to specific content types only.
- Integrate hosted print/PDF without hosting a PDF library on the server.
