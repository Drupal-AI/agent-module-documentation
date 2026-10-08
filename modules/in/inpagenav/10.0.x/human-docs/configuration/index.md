# Configuration

The settings form tells the block **which headings to turn into jump links** and
**where to look for them**. It lives at **Structure → Inpage navigation →
Settings** (`/admin/structure/inpagenav/settings/config_settings`) and requires
the **Administer site configuration** permission.

## Open the settings form

1. Log in as a user with **Administer site configuration** (an administrator by
   default).
2. Go to **Structure → Inpage navigation → Settings**, or navigate directly to
   `/admin/structure/inpagenav/settings/config_settings`.

## The settings

- **Parent wrapper class** — the CSS class of the container element that holds the
  headings you want in the navigation. The JavaScript only scans inside this
  container, so point it at the wrapper around your main content (for example the
  class your theme uses for the article body). This keeps the table of contents
  from picking up headings in the header, footer, or other regions.

- **Wrapper class(es) to exclude** — one or more CSS classes whose headings should
  be **left out** of the navigation. Use this to skip headings that live inside a
  container you don't want represented in the jump list.

- **Card component wrapper class** — a dedicated exclusion for headings that appear
  inside card-style components. Headings inside elements with this class are
  omitted, so a grid of cards with their own titles doesn't flood the table of
  contents.

- **Heading levels to include** — a comma-separated list of the heading tags to
  collect, for example `h1, h2, h3`. List only the levels you want as links: use
  `h2, h3` for a shallower two-level table of contents, or add `h1`/`h4` to go
  deeper. Each matching heading on the page becomes one entry in the navigation.

## Save

Click **Save configuration**. The settings are read by the block each time it
renders and passed to the JavaScript that builds the list, so reload a page that
has the block placed to see your changes take effect.

Remember that placing the block itself happens separately, under **Structure →
Block layout** — see the [installation guide](../installation/index.md) and the
"How to use it" section of the [overview](../index.md).
