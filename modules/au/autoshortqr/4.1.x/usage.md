Auto short qr adds computed self-referencing short-URL and QR-code fields (with optional UTM tagging) to nodes, users, taxonomy terms and redirects.

---

Enabled per bundle from an "Autocode" section that the module injects into the content-type, vocabulary, account-settings and redirect-settings forms, Auto short qr exposes two computed link fields on each entity: a **short URL** (e.g. `/ns/<base36-id>`) and a **QR/barcode** (rendered as an SVG via drupal/barcodes, linking to `/nc/<base36-id>`). Short routes decode the base36 id back to the entity and 302-redirect to its canonical URL; matching `/autoshortqr/*` routes stream the QR as a downloadable SVG. Per-type UTM parameters (source, medium, campaign, content, term) — each token-aware — are appended to the resolved destination URL, and three tokens (`iqac_short_link`, `iqac_qr_link`, `iqac_qr_download_link`) expose the same links for use in text, mail or other tokenized output. Views field handlers and edit-form previews are provided too. It depends on the Barcodes module (and the tecnickcom/tc-lib-barcode library).

---

- Add a scannable QR code to every article/page that points back to the node itself for print-to-mobile hand-off.
- Give each taxonomy term a QR code so printed category signage links to the term listing page.
- Put a QR code on user profiles (digital business cards) that resolves to `/user/<uid>`.
- Attach QR codes to redirect entities so a scanned code follows the redirect's configured target.
- Generate a compact short URL (`/ns/<code>`) for a node to embed in SMS, print or offline media where a long alias is unwieldy.
- Append campaign UTM parameters automatically to every scan/short-link click for a content type, without editing each node.
- Track a print QR campaign by setting `utm_source`/`utm_medium`/`utm_campaign` once per vocabulary or content type.
- Use entity tokens inside UTM values (e.g. `utm_content = [node:nid]`) so each entity's links carry unique campaign data.
- Offer visitors a downloadable high-resolution SVG QR (`/autoshortqr/nc/<code>`) for reuse in their own materials.
- Show the live QR code and/or its URL directly on the node/term/user/redirect edit form for editors to copy.
- Render the QR code or short link as a column in a View of nodes, terms, users or redirects.
- Point short links at a different display domain (e.g. a dedicated short-domain) via the per-type "Base domain" setting.
- Preserve any UTM query the visitor already supplied while filling in only the missing campaign params.
- Provide language-aware short links that resolve to the correct translation of a node.
- Encode a term's canonical URL in a QR for museum/exhibit signage that deep-links to the collection page.
- Add self-QR codes to event or product content types so attendees can scan to open the detail page.
- Expose the short URL as a standard link field so it can be themed, formatted or placed like any other link.
- Let marketing embed `[node:iqac_short_link]` in emails to route recipients through UTM-tagged short links.
- Provide a scan-to-download-QR flow by linking the on-page QR image to its SVG download route.
- Reuse the same QR/short-link mechanism uniformly across four entity types from a single module.
- Turn existing redirect entities into QR-addressable, UTM-tagged campaign endpoints.
