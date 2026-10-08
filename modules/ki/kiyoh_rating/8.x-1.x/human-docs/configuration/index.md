# Configuration

Kiyoh rating is configured by placing its block and telling it which Kiyoh
account to read. There is no separate settings page — everything happens in
**Block layout**. You need the **Administer blocks** permission (an administrator
by default).

## Place the Kiyoh rating block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the region where you want the rating to appear (for example a sidebar or
   the footer) and click **Place block**.
3. Search for **Kiyoh rating** and click **Place block** next to it.

## Configure the block

In the block configuration dialog:

- **Kiyoh hash** — enter the hash for your Kiyoh company profile. This is the
  identifier the module uses to read your score and review count from the Kiyoh
  XML feed. Without it the block has no account to display.
- **Title / visibility** — set the standard Drupal block options as you would for
  any block: a title (or hide it), and any pages/roles/content‑type visibility
  conditions.

Save the block. The rating renders through the `kiyoh-rating-big` template. The
module ships almost no styling, so if you want stars, colours, or spacing, add
CSS in your theme targeting the block's markup.

## Using the inline variant (for developers)

If you would rather render the rating inside a template or a preprocess function
than place a block, use the `kiyoh_rating_inline` theme hook. For example, in a
preprocess hook:

```php
$variables['kiyoh_rating'] = [
  '#theme' => 'kiyoh_rating_inline',
  '#kiyoh_hash' => 'your_hash',
];
```

Then print `{{ kiyoh_rating }}` in the corresponding Twig template. Replace
`your_hash` with your real Kiyoh hash.
