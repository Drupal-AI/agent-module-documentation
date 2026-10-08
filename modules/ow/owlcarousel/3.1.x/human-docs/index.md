# Owl Carousel — manual setup guide

**Owl Carousel** (`owlcarousel`) connects the popular **OwlCarousel2** jQuery
slider to Drupal, so you can display content as a responsive, touch‑enabled,
swipeable carousel without writing any JavaScript. It gives you two ways to turn
content into a slider: an **image‑field formatter** (show a multi‑value image
field as a rotating gallery) and a **Views style** (turn any view's rows —
nodes, teasers, cards — into a carousel).

Both integrations share one set of carousel options: how many items show per
slide, the gap between them, previous/next arrows, pagination dots, autoplay
(with pause‑on‑hover), infinite looping, right‑to‑left support, and a simple
two‑breakpoint responsive setup (a mobile item count and a desktop item count).
The image formatter adds two extras — an image style for each slide and an
optional link (to the content or to the image file). There is **no admin
settings page**: every carousel is configured right where you use it, in a
field display or a view.

Owl Carousel does **not** bundle the OwlCarousel2 JavaScript library itself —
you install that separately into your site's `/libraries` folder (a bundled
Drush command does this for you, and the status report tells you whether it is
present). Once the library is in place and you have picked the formatter or
Views style, the module JSON‑encodes your options into the markup and initialises
the slider on the page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and add the OwlCarousel2 JavaScript library.

## Where it lives in the admin menu

Owl Carousel has no settings page of its own. You set up carousels in two places:

- **Manage display** for a content type / entity bundle
  (*Structure → Content types → [type] → Manage display*), where you set a
  multi‑value **image** field's format to **"OwlCarousel Carousel"**.
- The **Format** section of any **View**, where you choose **"OwlCarousel"** as
  the display style.

The one status indicator it adds appears on **Reports → Status report**, telling
you whether the OwlCarousel2 library is installed.

## How to use it

**As an image gallery.** On a content type that has a multi‑value image field
(for example a product gallery or an article's photo set), go to *Manage
display*, change that field's format to **OwlCarousel Carousel**, and click the
gear icon to set the carousel options — number of items per slide, arrows, dots,
autoplay, loop, an image style, and whether each image links to the content or
the file. Save, and the field renders as a slider on the entity page.

**As a Views slider.** Build a View of whatever you want to rotate — promoted
nodes for a homepage hero, testimonials, partner logos — and in the **Format**
section choose **OwlCarousel**. The same option set appears in the style
settings. Place that view in a block or a page and it renders as a carousel.

Common uses include a homepage hero slider, a swipeable card carousel, a
product‑image gallery with navigation arrows, an auto‑playing slideshow that
pauses on hover, a continuously scrolling logo strip, and a single‑item
testimonial rotator. To change a carousel's behaviour you edit the formatter or
view settings — not the template.
