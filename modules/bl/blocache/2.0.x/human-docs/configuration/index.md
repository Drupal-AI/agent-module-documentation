# Configuration

Blocache has no central settings page. You configure caching **per block**, right
on that block's configuration form.

## Permission

The Cache Settings section only appears for users with the **Administer block
cache** (`administer block cache`) permission. Grant it on **People → Permissions**
to the roles that should be able to tune block caching.

## Open a block's Cache Settings

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Configure** on any placed block (or navigate to
   `/admin/structure/block/manage/<block-id>`).
3. Scroll to the **Cache Settings** section.

## Override cacheability metadata

At the top of the section is a master switch:

- **Override cacheability metadata** — leave this unticked and Blocache does
  nothing; the block keeps its default, code-defined caching. Tick it to apply the
  values below. You can untick it later to instantly revert to the defaults.

When ticked, three vertical tabs let you set each part of the block's
cacheability:

### Max-Age

A single number controlling how long the block may be cached:

- A **positive number** — cache the block for that many seconds (for example
  `3600` for an hour).
- **`0`** — the block is **not cacheable**. As a side effect, any page containing
  this block will also skip the full page cache, so use it only for genuinely
  real-time blocks.
- **`-1`** — cache the block **forever**; it will only be refreshed when one of its
  cache tags is invalidated.

### Contexts

A checkbox for each available cache context — the conditions the block should vary
by. Common choices:

- **url.path** or **url.query_args** — vary the block per URL or per query
  parameter (some contexts take an optional argument, such as a specific query key).
- **user.roles** — vary the block per user role.
- **languages:language_interface** — vary the block per interface language.

Tick the contexts your block genuinely depends on. Missing a needed context is what
causes a block to show the wrong content to the wrong visitor; adding too many
reduces how often the block can be cached.

### Tags

An add-as-many-as-you-need list of cache tag strings. Cache tags invalidate the
block when related data changes — for example:

- `node:5` — refresh when node 5 is updated.
- `config:system.site` — refresh when site settings change.

Use **Add tag** to add more rows. If the Token module is installed, tags may
contain tokens, which are replaced when the block is rendered — handy for building
dynamic, entity-specific tags.

## Save

Click **Save block**. The new caching behavior takes effect immediately. Because
these settings are stored on the block itself, they export with the rest of your
site configuration and deploy across environments like any other block setting.
