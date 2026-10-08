<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PrintFriendly & PDF adds a hosted PrintFriendly.com print/PDF/email button to your site, giving visitors a one-click way to print a cleaned-up page, save it as a PDF, or email it — no print CSS required.
---
The module integrates the third-party PrintFriendly.com service. On every page it attaches an inline script that loads `//cdn.printfriendly.com/printfriendly.js` and passes your chosen options (header logo/tagline, whether to keep or hide images, image alignment, and whether print/PDF/email are enabled) to that script; it also attaches a small CSS library. The clickable button itself is rendered two ways: `hook_node_view` automatically appends a button to nodes of the content types you select on the settings form (with a separate "Teaser" option for teaser view), and a "printfriendly" block (`block_printfriendly`) lets you place the button anywhere via the Block layout. Both call `printfriendly_create_button()`, which emits an anchor linking to `https://www.printfriendly.com/print?url=<current page URL>` wrapped around your chosen button image (served from `//cdn.printfriendly.com/...` or a custom image URL). Viewers need the `access printfriendly` permission to see the button; all configuration lives at `/admin/config/printfriendly/config` behind `administer printfriendly`. There is no API key: the free integration works out of the box, though PrintFriendly recommends a paid Pro subscription for password-protected or JavaScript-rendered sites. Button image choice, header options, and the print/PDF/email toggles are stored in the `printfriendly.settings` config object; the module also runs a one-time `printfriendly_upgrade_db()` routine that migrates legacy button-image filenames.
---
- Add a print/PDF/email button to full-page node views of selected content types.
- Add the button to node teasers via the dedicated "Teaser" display option.
- Place the button anywhere on the site using the "printfriendly" block.
- Let visitors save a page as a PDF without a server-side PDF generator.
- Let visitors print a cleaned-up, printer-optimized version of a page.
- Let visitors email a page via the PrintFriendly service.
- Choose which content types show the button from a checkbox list.
- Pick a button image from four preset button/icon groups.
- Supply a custom button image by URL instead of a preset.
- Show your site logo (or a custom uploaded logo) in the printed/PDF header.
- Add a custom tagline to the printed/PDF page header.
- Include or exclude images from the printed/PDF output.
- Set image alignment in output (right, left, none, or center/block).
- Enable or disable the PDF option on the PrintFriendly popup.
- Enable or disable the email option on the PrintFriendly popup.
- Enable or disable the direct print option on the PrintFriendly popup.
- Allow or disallow the reader's click-to-delete (remove content before printing).
- Apply a custom CSS file to the printed/PDF output by URL.
- Restrict who can see the button using the `access printfriendly` permission.
- Restrict who can configure the module using the `administer printfriendly` permission.
- Run the free integration with no API key or account required.
- Point paywalled or JS-heavy sites at a PrintFriendly Pro subscription for full support.
- Give editors a consistent print/PDF affordance without writing print.css.
- Reduce paper and ink by offering an optimized print rendition.
