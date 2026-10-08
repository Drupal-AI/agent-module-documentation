# Configuration

Setting up Commerce Promo Bar has two parts: placing the block that renders bars, and
creating the bars themselves. Managing bars requires the **administer commerce promo
bar** permission (keep it to trusted staff).

## 1. Place the promo bar block

The bars only appear once the block is placed:

1. Go to **Structure → Block layout** (**Block layout**).
2. Place the **Promo bar block** into the region where you want bars to appear
   (typically a header or "highlighted" region).
3. In the block settings, set **Stack promo bars**:
   - **On** (default) — render *every* matching bar (they stack).
   - **Off** — render only the single **highest-weighted** matching bar.

## 2. Create and edit a promo bar

Go to **Commerce → Promo bars** (`/admin/commerce/promo-bars`) and click **Add promo
bar**. The bar's fields are:

- **Title** — the bar's label.
- **Body** — the message, edited in a WYSIWYG editor. Tokens are allowed, so you can
  insert dynamic values (including a linked promotion's coupon code).
- **Background colour** and **Text colour** — chosen with the Color Field pickers;
  they are applied as CSS to the bar.
- **Start date** (required), **End date**, and **Countdown date** — the start/end
  dates control when the bar is live; setting a countdown date shows a live countdown
  timer driven client-side.
- **Related promotion** — reference a `commerce_promotion` entity so that promotion's
  tokens (for example its coupon code) become available to use in the body.
- **Stores** — limit the bar to one or more specific Commerce stores.
- **Customer roles** — limit the bar to selected roles.
- **Pages** and **Visibility** — enter newline-separated path patterns (with `*`
  wildcards and `<front>`). The visibility toggle decides the meaning: **show** the
  bar on the listed pages, or **hide** it on them (showing it everywhere else). Paths
  are matched against both the internal path and its alias.
- **Dismissible** — let visitors close the bar (remembered for the session).
- **Weight** — order competing bars; higher weight wins when "Stack promo bars" is
  off.
- **Status (enabled)** — turn a bar on or off without deleting it.

Save the bar. From the collection page you can also **duplicate** a bar to make a
variant quickly, enable/disable it, and bulk-delete bars.

## How visibility is decided

When the block builds, the module first loads the bars that match the **current
store** and the **current user's roles** (and are within their date window), then
applies the per-page **show/hide** path rules to decide which of those actually
render on the page being viewed. This is why a bar can be "live" but not appear on a
particular page — check its store, role, date, and path settings together.

## 3. Add your own fields (optional)

Because a promo bar is a fieldable entity, you can extend it. Go to the field-UI base
route at **`admin/commerce/config/promo_bar`** (`entity.commerce_promo_bar.settings`)
to add fields and adjust the form and display modes. Surface any added field in the
bar output via tokens, or override the `commerce-promo-bar.html.twig` template for
full control of the markup.

## Translation

Promo bars are translatable, so you can translate a bar's title and body into your
site's other languages.
