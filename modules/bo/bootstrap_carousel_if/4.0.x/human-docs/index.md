# Bootstrap Carousel Image Formatter — manual setup guide

**Bootstrap Carousel Image Formatter** (`bootstrap_carousel_if`) renders a
multi‑value image field as a Bootstrap carousel. A multi‑value image field on a
product, a property listing, or a gallery node is a set of images that a design
usually wants shown as a carousel — and doing that as a **field formatter** is
the right layer, because it is a display decision that belongs in *Manage
display*, per view mode, rather than in a template.

Choosing the Bootstrap carousel specifically means the markup and behavior come
from a framework the theme probably already loads, so there is no extra slider
library to add and the styling follows the site's Bootstrap variables. It has no
module dependencies and is selected in *Manage display*. There is no admin
settings page.

**Two things to check before relying on it:**

- **The theme must actually provide Bootstrap's carousel JavaScript.** The
  formatter only emits the markup. If the theme ships Bootstrap's CSS but not its
  JS, the carousel will look right and simply not move — that is the first thing
  to test if it seems broken.
- **Accessibility caveats apply**: keyboard operation, visible focus on the
  controls, a pause control if it auto‑advances, and the general point that
  images past the first are seen by few visitors. These objections are much
  weaker for a **product gallery**, where the images are alternatives rather than
  a sequence meant to be read — which is the case this formatter fits best.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings form of its own. You select it at **Structure → Content
types → (a type) → Manage display** (`/admin/structure/types`), on a multi‑value
image field, per view mode.

## How to use it

1. On an entity that has a **multi‑value image field**, go to its **Manage
   display** tab for the view mode you want (for example *Full content*).
2. For that image field, choose the **Bootstrap carousel** formatter.
3. Order the images within the field to control the slide order.
4. Confirm the active theme ships Bootstrap's carousel **JavaScript** — otherwise
   the slides render but do not advance. Consider using a thumbnail in teaser and
   the carousel only in the full view.
