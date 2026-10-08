<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mailchimp Popup Block provides a block that triggers Mailchimp's hosted subscriber pop-up form. You supply
your Mailchimp pop-up parameters (base URL, account UUID, and list ID) taken from the pop-up form snippet
Mailchimp generates, and the block either shows a button that opens the pop-up on click (manual mode) or
loads it automatically on page load (automatic mode). Depends only on core `block`.

---

The block plugin (`MailchimpPopupBlock`) has two build paths selected by the `method` setting.
**Manual** mode renders the `mailchimp_popup` theme (`templates/mailchimp-popup.html.twig`) with a button
carrying `data-mailchimp-popup-block-*` attributes (baseurl/uuid/lid) plus configurable description and
button text. **Automatic** mode renders an empty (display:none) wrapper — `hook_preprocess_block` hides
it — and instead injects the settings globally into `drupalSettings.mailchimp_popup_block`
(baseurl/uuid/lid/method + a `popup_reappear_offset` in seconds controlling how long after dismissal the
pop-up may reappear). Both attach the `mailchimp_popup_block/mailchimp_popup_block` library that loads and
invokes Mailchimp's pop-up JS. All values are per-block configuration (schema in
`config/schema/mailchimp_popup_block.schema.yml`) set on the Block layout form; there are no server-side
API calls, no API keys, and no secrets handled by this module — the UUID/list-ID are public front-end
identifiers. Twig auto-escapes the rendered attributes. No permissions are defined.

---

- Show a newsletter signup pop-up via a button placed in any block region.
- Auto-open a Mailchimp subscribe pop-up on first page load.
- Set how long after dismissal the pop-up may reappear (e.g. 1 day, 1 week, 1 month).
- Force the pop-up on every page load by setting the reappear offset to 0.
- Add a "Subscribe" call-to-action button with custom label text.
- Add an intro/description above the manual trigger button.
- Reuse the same Mailchimp pop-up config across multiple placements.
- Target the pop-up to specific pages via the block's visibility conditions.
- Drop a signup pop-up into a landing page campaign.
- Use Mailchimp's own hosted form (no server-side subscription handling needed).
- Keep the automatic wrapper hidden while still firing the pop-up JS.
- Configure baseurl/UUID/list-ID directly from the Mailchimp pop-up snippet.
- Localise the button and description text per block.
- Place the manual button in a header or footer region.
- Run different pop-ups for different audiences using multiple block instances.
- Avoid storing any Mailchimp API secret (only public pop-up identifiers are used).
