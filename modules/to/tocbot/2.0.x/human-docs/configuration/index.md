# Configuration

Tocbot has two parts to set up: **placing the block** (required — this is what makes
a table of contents appear) and **tuning the settings form** (optional — sensible
defaults ship out of the box).

## Step 1: Place the "Tocbot TOC" block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the region where you want the table of contents (a sidebar is typical) and
   click **Place block**.
3. Choose **Tocbot TOC** from the list and configure the standard block visibility
   settings (for example, restrict it to certain content types or paths).
4. Save the block.

The block itself renders as an empty `<div class="js-toc-block">`; the JavaScript
fills it with the list of headings once the page loads. For a list to actually
appear, the page must contain an element matching your **content selector** with at
least **min activate** matching headings (defaults: `#content` and 3 headings).

## Step 2: Open the settings form (optional)

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → Tocbot**
   (`/admin/config/content/tocbot`).

The form exposes almost every Tocbot option. The most important ones are below;
the rest are fine at their defaults for most sites.

### Which headings become entries

- **Content selector** (`content_selector`, default `#content`) — the container
  Tocbot scans for headings. **This must match your theme's main content wrapper.**
  If your theme uses a different id/class (for example `main` or `.node__content`),
  set it here, or the TOC will find nothing.
- **Heading selector** (`heading_selector`, default `h2, h3, h4, h5, h6`) — which
  heading levels become entries. Narrow it to `h2, h3` for a shorter, shallower
  list.
- **Ignore selector** (`ignore_selector`, default `.visually-hidden`) — headings
  matching this are skipped, so you can exclude decorative or screen-reader-only
  headings.

### When the TOC activates

- **Min activate** (`min_activate`, default `3`) — only build the table of contents
  when the page has at least this many matching headings. Raise it to keep the TOC
  off shorter pages.
- **Create auto IDs** (`create_auto_ids`, default on) — when enabled, Tocbot slugs
  each heading's text into an `id` so the anchor links work even if nothing else on
  the page adds heading ids. Leave this on unless your content already has stable
  heading ids.

### Where the list renders

- **TOC selector** (`toc_selector`, default `.js-toc-block`) — the element the list
  is rendered into. The default matches the block itself, so by default the TOC
  appears *inside the Tocbot TOC block*. Point it at a different element in your
  theme if you want the list somewhere else.

### List appearance and behavior

- **Ordered list** (`ordered_list`, default off) — set it on to render an ordered
  (numbered) list instead of a bulleted one.
- **Collapse depth** (`collapse_depth`, default `0`) — automatically collapse
  nesting beyond this depth.
- **Extra body class** (`extra_body_class`, default `toc-is-active`) — a CSS class
  added to `<body>` when the TOC activates, so you can adjust your layout (for
  example, make room for a sidebar) only when a table of contents is present. Leave
  blank for none.
- The list, link and state CSS class names (`toc-list`, `toc-list-item`,
  `toc-link`, `is-active-link`, `is-collapsed`, `is-collapsible`,
  `is-position-fixed`) are all configurable, and you can add your own via **extra
  link classes** / **extra list classes** to style the output in your theme.

### Scrolling and sticky positioning

- **Smooth scroll** (`scroll_smooth`, default on) with a configurable duration
  (`scroll_smooth_duration`, default 420ms) and offset (`scroll_smooth_offset`) —
  animates the jump to a section.
- **Headings offset** (`headings_offset`) and **throttle timeout**
  (`throttle_timeout`, default 50ms) — fine-tune scroll calculations and
  performance, useful with a fixed header.
- **Position fixed** (`position_fixed_selector` / `position_fixed_class`) and
  **fixed sidebar offset** (`fixed_sidebar_offset`, default `auto`) — make the TOC
  stick to the viewport as you scroll past it.

> **Known quirk:** the form also shows an *includeHtml* checkbox, but this option is
> not actually saved or passed to Tocbot — changing it has no effect.

## Step 3: Save

Click **Save configuration**. Reload a content page that has enough headings and the
table of contents will reflect your changes. If nothing appears, the usual causes
are: the block isn't placed on that page, the **content selector** doesn't match
your theme's wrapper, or the page has fewer headings than **min activate**.
