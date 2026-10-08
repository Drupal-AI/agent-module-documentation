<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Gutenberg Blocks adds a set of extra content and media blocks to the Gutenberg editor in Drupal.

---

Advanced Gutenberg Blocks extends Drupal's Gutenberg integration with roughly two dozen additional,
ready-made blocks — headings, highlighted/custom text, image grids and mosaics, text-and-image layouts,
sliders, a call-to-action, a link list/mosaic, a featured-media block, an FAQ accordion, an audio block
and a spacer. The blocks are registered client-side in JavaScript against the Gutenberg editor, so they
appear in the block inserter alongside Gutenberg's defaults. Several blocks are media-aware, which is why
the module depends on the Gutenberg module together with core Media and Media Library.

The module ships no settings form, routes, permissions, services or configuration entities: enabling it
simply makes the extra blocks available in the editor. It is purely a content-editing / page-building
feature — authors compose pages visually and the resulting markup is rendered through Drupal's normal
render pipeline. Two example Twig templates (`gutenberg-block--example*.html.twig`) and a matching
preprocess hook are included as a server-side rendering example for the demo `example` block namespace.

---

- Give Gutenberg authors extra ready-made content blocks without writing custom blocks.
- Add a Section Break (H2) heading block to structure long pages.
- Insert a styled Custom Heading (H1) block.
- Highlight callouts with the Highlighted Text block.
- Lay out a Custom Text Block with title and body copy.
- Build responsive Image Grid layouts.
- Compose an Image Mosaic from multiple media items.
- Combine copy and imagery with the Text + Image block.
- Add a repeating Text + Image Slider for carousels.
- Feature a single media item with the Featured Media block.
- Repeat media items in a Media Repeater Grid.
- Add a full-width image slider hero.
- Drive conversions with a Call to Action block.
- Present grouped links with a Link List block.
- Build a visual Link Mosaic of image links.
- Arrange copy blocks with the Text Mosaic block.
- Emphasise a message with the Featured Text block.
- Add expand/collapse FAQs with the FAQ Accordion block.
- Embed audio with the Custom Audio block.
- Insert vertical whitespace with the Spacer block.
- Use core Media and Media Library pickers inside media-aware blocks.
- Extend Gutenberg's default block palette on any Gutenberg-authored content type.
- Compose landing pages and marketing content visually inside the editor.
- Keep authored content rendering through Drupal's standard render layer.
