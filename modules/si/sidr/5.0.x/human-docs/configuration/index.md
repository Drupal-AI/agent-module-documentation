# Configuration

Sidr has two layers of configuration: a small **global settings form** (theme and
close behaviors that apply to every panel) and the **per‑block trigger settings**
(where the real work happens — each button's source, side, label, and animation).

## Global settings

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → User interface → Sidr**
   (`/admin/config/user-interface/sidr`).

The form has three settings:

- **Sidr theme** *(default: Dark)* — which packaged CSS is attached to every panel:
  **Bare**, **Light**, or **Dark**. Choose **Bare** to disable the packaged styling
  entirely and style the panel and trigger yourself with your own CSS (target
  `.sidr-trigger` and the Sidr panel). Note that the theme is global — the per‑block
  form shows a Theme field but it is display‑only/disabled; this global setting is
  what actually applies.
- **Close on Escape** *(default: on)* — pressing the Escape key closes any open
  panel.
- **Close on blur** *(default: on)* — clicking or tapping outside an open panel
  closes it.

Click **Save configuration**.

## Placing and configuring a trigger block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the hamburger/button to appear,
   and choose **Sidr trigger button block**.
3. Configure the block. The form is split into a **Basic** group and an **Advanced**
   group.

### Basic settings

- **Trigger text** — the label shown on the button. You must set **either** this or a
  trigger icon (below); a block with neither won't validate.
- **Sidr source** *(required)* — where the panel's content comes from. This can be a
  jQuery selector for an element already on the page (for example your main menu
  block), a URL to load content from, or a callback. This is the heart of the block:
  it's what slides in.
- **Sidr side** — which edge the panel slides from: **left** or **right**.

### Advanced settings

- **Trigger icon** — raw HTML markup for an icon, for example
  `<span class="icon-hamburger"></span>`. Because block configuration is authored by
  trusted administrators, this markup is rendered as‑is, which is what lets you drop
  in an icon‑font hamburger.
- **Sidr name** — a unique DOM id for this Sidr instance. Give each block a distinct
  name if you place more than one (e.g. a left menu and a right cart), so they don't
  collide and so you can target them from custom JS.
- **Sidr method** — what the button does: **toggle** (default behavior most people
  want), **open**, or **close**.
- **Sidr speed** — animation speed: `slow`, `fast`, or a number of milliseconds.
- **Sidr timing** — the CSS timing function for the slide.
- **Sidr nocopy** — use the original source elements instead of copying their inner
  HTML into the panel. Mutually exclusive with renaming (below).
- **Sidr renaming** — rename the source elements' classes/IDs when copying them into
  the panel, to avoid duplicate IDs. Mutually exclusive with nocopy.
- **Sidr displace** — push (displace) the page content aside while the panel opens
  and closes, rather than sliding the panel over the top of it.
- **Sidr body** — only shown when displace is on; the element to displace. Defaults
  to `BODY`.

Save the block. Sidr encodes all of these into a `data-sidr-options` attribute on the
button and instantiates the jQuery Sidr plugin on click.

## Tips

- **Multiple panels:** place several Sidr trigger blocks, each with its own **Sidr
  name** and source, to get independent drawers (for example a navigation menu on the
  left and a cart on the right).
- **A custom close button:** any element you add with the class `js-sidr-close` will
  close open panels when clicked — handy for putting an "×" inside the panel content.
- **Reuse across pages:** use the block's normal visibility rules to control where
  each trigger appears.
