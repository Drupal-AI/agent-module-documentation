# Configuration

Juicer has no central settings form — you configure everything on the **Juicer
Social Feed** block when you place it. This page walks through those block settings
field by field.

## Place the block

1. Log in as a user who can administer blocks (an administrator by default).
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Click **Place block** in the region where you want the feed to appear, then find
   and choose **Juicer Social Feed**.

The block configuration form opens with the fields below.

## Feed slug

The one required field. Enter your **Juicer feed ID** (the "slug") — you'll find it
on your Juicer.io dashboard. This is what connects the block to your aggregated
feed; without it the block has nothing to display. When you save, the module checks
the slug against the Juicer API and warns you if no such feed is found.

## Post limit

Controls **how many posts** the feed shows. Leave it empty to use Juicer's own
default, or enter a number (1–100) to cap the count.

## Source filter

Restricts the feed to a **single social network** — for example only Instagram, or
only LinkedIn. Leave it unset to show posts from every source your Juicer feed
aggregates.

## Title and subtitle

- **Title** — an optional heading rendered above the feed.
- **Title tag level** — choose the heading level (**H1** through **H6**) so the
  title fits your page's document outline.
- **Subtitle** — optional secondary text shown under the title.
- **Display title and subtitle** — toggle whether the title and subtitle are shown.

## Save

Click **Save block**. The feed renders on the front end straight away in a
responsive masonry grid. Clicking a post opens a detail overlay with the full
content and a link to the original, and a **Load More** button appears when there
are additional posts to fetch.

> **Tip:** To limit the feed to specific pages or roles, use the block's standard
> *Visibility* settings, or pair it with a module such as Block Visibility Groups.
> To position it precisely on individual pages, place it through Layout Builder.
