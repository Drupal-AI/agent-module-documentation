# Configuration

Swiper Cards has no site‑wide settings form. You configure it entirely within the
**Swiper Cards block** — you place the block, enter your cards, and choose a
layout and appearance.

## Place the block

1. Log in as a user who can administer blocks (an administrator by default).
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. In the region where you want the slider, click **Place block**.
4. Find **Swiper Cards** in the list and click **Place block** next to it.

## Configure the cards and appearance

In the block's configuration form you can set:

- **Cards** — add each card with its content: a photo/image, a title, a subtitle,
  a short blurb/description, and related information.
- **Order (weight)** — use the order/weight select on each card to control the
  sequence in which the cards appear in the slider.
- **Layout** — choose one of the module's predefined card layouts (four are
  available).
- **Container background colour** — the background colour of the slider container.
- **Header text** — header content for the slider, entered through a
  formatted‑text (rich‑text) editor. You can also add custom CSS for the header
  content, and the active theme's CSS is applied.

Save the block. Configure the usual block visibility and placement settings
(pages, roles, content types) as you would for any block.

## Customising the layout (for developers)

The card layout is fully overridable. Copy the template from
`templates/swiper-cards.html.twig` into your theme and customise the HTML to build
your own layout with custom CSS, and you can override the JavaScript too. The
template exposes these variables:

- `swiper_cards_data` — an array of the cards, where each card has `card_image`,
  `card_title`, `card_subtitle`, `card_description`, `weight`, and `image_url`.
- `swiper_card_layout` — the chosen card layout.
- `default_data` — includes the container background colour.

## A note on content trust

Card content is authored by administrators or editors and rendered as markup, so
keep the ability to create and edit these blocks to trusted users. The module has
no access‑control role of its own.
