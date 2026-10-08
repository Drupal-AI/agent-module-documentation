# Configuration

Common Overrides has a single settings form. In this release it controls the
heading shown above the node search results.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Common Overrides**
   (`/admin/config/common_overrides`).

> If the automatic **Configure** link doesn't work, that's the known `info.yml`
> route‑name mismatch — just navigate to `/admin/config/common_overrides`
> directly.

## Settings, field by field

- **Search results title** — the text to display as the heading above the node
  search results. Set it to whatever wording you want (for example your site name
  plus "search results").
- **Search results tag** — the HTML heading tag to wrap that text in, chosen from
  a fixed list (`h1` through `h6`). Choosing `h1` is a common choice for SEO on a
  results page.

When you save, a route subscriber swaps core's node search controller for the
module's controller, which renders your configured heading in place of core's
default.

## Save and verify

Click **Save configuration**, then run a search and open the **node search
results** page (`/search/node/...`). Confirm the heading now shows your text
wrapped in the tag you selected. Disabling the module restores core's default
search heading.
