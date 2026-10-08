<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Greeting Cards lets a visitor build an e-card: they upload images or PDFs on a form, the module merges/renders them into a PDF (mPDF), generates a first-page thumbnail (ImageMagick `convert`), creates a `greeting_cards` node, and then e-mails a link to a recipient address entered on the form.

---

The flow spans an `EcardForm` (`/greeting-cards/e-cards`) that collects a title, sender name/relation/occasion, uploaded files, a recipient e-mail and a category term; a `SendCardsFriends` controller that lists the created cards, sends the mail and shows a single card's details; and a `GreetingCardLayOut` controller that renders a printable/searchable gallery grouped by taxonomy category. PDFs are produced by `Plugin\PdfCreation` (mpdf/mpdf) and thumbnails by `greeting_cards_convert_pdf_to_image()` shelling out to ImageMagick `convert`. Sender details and the recipient e-mail are carried in `$_SESSION`, and the outgoing mail (`hook_mail` key `greeting_cards_e_card`, HTML) embeds the sender name/relation/occasion, card image and link.

All six routes use the `access content` permission; the form creates nodes (`nodeStorage->create()`) and sends e-mail to the recipient address entered. Requirements: the `convert` binary and the `mpdf/mpdf` library must be available, plus a `greeting_cards` content type with `field_pdf`, `field_thumbnail_image` and `field_category`, and a `card_categories` taxonomy vocabulary. Typical setup: install mPDF + ImageMagick, add the content type and vocabulary, then adjust the routes' permission if you do not want anonymous card creation/e-mailing.
---
- Let a visitor create a greeting card from uploaded images
- Merge multiple uploaded images into a single PDF (mPDF)
- Accept an uploaded PDF directly as a card
- Generate a first-page thumbnail of a PDF via ImageMagick
- Create a `greeting_cards` node for each card
- Categorize cards with the `card_categories` taxonomy
- E-mail a card link to a recipient address
- Personalize the e-mail with sender name, relation and occasion
- Show the created cards and per-card send links
- Track which cards have already been e-mailed (session)
- Browse a printable gallery of cards at /printable-cards
- Filter the gallery by taxonomy category
- Search cards via /greeting-card-search
- View a single card's full details and PDF download
- Attach card thumbnails automatically on node insert/update
- Provide a Bootstrap-based front-end for card display
- Offer admins a per-card delete link in the gallery
- Restrict card creation by tightening the routes' permission
- Serve card PDFs and thumbnails from the public files directory
- Show a relative "time ago" for when a card was created
