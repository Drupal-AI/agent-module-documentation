# Configuration

FAQ Block has no separate settings page — you configure each FAQ section on the
**block** as you place it. This page walks through that block configuration form.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
   block** in the region you want, or add a **FAQ Block** to a **Layout Builder**
   section.
2. Choose **FAQ Block** from the list. Its configuration form opens.

## The configuration form, field by field

- **Section title** *(optional)* — a heading shown above the accordion, for example
  "Frequently Asked Questions". Leave it blank if you don't want a heading.
- **Section description** *(optional)* — an intro paragraph shown under the title,
  before the questions.
- **Toggle icon colour** — the colour of the expand/collapse (plus/minus) icon next to
  each question. Use it to match your theme.
- **FAQ items** — the heart of the block. Each item has:
  - a **Question** (entered in an autocomplete‑assisted field), and
  - an **Answer**, authored with the CKEditor rich‑text editor (a `text_format`
    field), so you can add formatting, links, and embedded media.

## Adding, removing, and ordering items

- Use the **Add FAQ Item** button to add another question/answer pair; the form
  updates in place (via AJAX) without a full reload.
- Use **Remove FAQ Item** to delete one.
- Items are **draggable**, so you can reorder them to control the sequence shown in the
  accordion.
- Any item left with a blank question is pruned automatically when you save, so empty
  rows won't appear on the page.

## Save

Give the block a title (or hide it) and set its visibility and region as you would any
block, then **Save block**. On save, the module records file usage for any images or
files embedded in the answers and promotes them from temporary to permanent so they
are not garbage‑collected. The FAQ section then renders as an accordion on the pages
where the block is shown.

> **Multiple sections:** because the content is stored per block, you can place
> several independent FAQ blocks — each with its own questions, title, and icon
> colour — on different pages.

## Theming (optional)

To change the markup, copy the module's default template
`templates/block/faq-block.html.twig` into your active theme and adjust it. Useful Twig
variables include `faqs` (the array of items — loop and use `faq.question` and
`faq.answer['value']`), plus `faqs_data['color']`, `faqs_data['section_title']`, and
`faqs_data['section_description']`. You can also override the module's stylesheet or add
your own CSS for the accordion elements.
