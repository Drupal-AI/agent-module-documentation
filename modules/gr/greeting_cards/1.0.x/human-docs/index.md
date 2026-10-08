# Greeting Cards — manual setup guide

**Greeting Cards** (`greeting_cards`) turns uploaded images or PDFs into
printable, e-mailable greeting cards. A visitor fills in a form — a title, their
name and relationship to the recipient, the occasion, one or more uploaded
files, a recipient e-mail address and a category — and the module merges or
renders the files into a PDF (using the mPDF library), generates a thumbnail of
the PDF's first page (using ImageMagick's `convert`), creates a **Greeting Card**
node, and e-mails a link to the recipient.

There's a front-end to browse the results, too: `/printable-cards` shows a
gallery of created cards grouped by taxonomy category where visitors can preview,
download, or print each card, and there's a search page as well. If an
administrator is logged in, each card in the gallery gets a delete link for easy
cleanup.

Because the module relies on external tooling and a specific content structure,
it needs some setup before it will work — the `convert` binary, the mPDF library,
a `greeting_cards` content type with the right fields, and a `card_categories`
taxonomy vocabulary. All of that is described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, install the
   external tools, and enable the module.

There is **no settings page** for this module. Setup happens on the content type,
its fields, and its form display, described below.

## Route permissions

All of the module's routes use the "access content" permission. If you do not
want anonymous visitors creating cards and sending e-mails, tighten the
permission on these routes (for example with a custom route-access requirement).
Note also that this module is *not covered* by Drupal's security advisory policy.

## How to set it up

1. **Install the external tools.** Make sure the **ImageMagick** `convert`
   binary and the **Symfony Process** component are available on the server, and
   install the **mPDF** library. See [Installation](installation/index.md).
2. **Create the content type and fields.** The module expects a `greeting_cards`
   content type with a PDF field (`field_pdf`), a thumbnail image field
   (`field_thumbnail_image`), and a category field (`field_category`).
3. **Create the vocabulary.** Add a `card_categories` taxonomy vocabulary for the
   card categories (Birthday, Christmas, and so on).
4. **Configure the form display.** Visit the greeting card form display at
   `admin/structure/types/manage/greeting_cards/form-display` and make sure the
   **PDF** and **Category** fields are in the enabled section.
5. **(Optional) Let the category field create terms.** At
   `admin/structure/types/manage/greeting_cards/fields/node.greeting_cards.field_category`
   you can allow the Category field to create a new term when one doesn't exist
   yet.

## How to use it

Once set up, visitors create cards on the e-card form at
`/greeting-cards/e-cards`, browse the printable gallery at `/printable-cards`
(grouped by category, with preview/download/print), and search cards via the
search page. The module e-mails a link to the recipient address entered on the
form, personalized with the sender's name, relationship and occasion.
