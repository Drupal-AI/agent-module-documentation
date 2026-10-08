# Configuration

TagClouds has three things to know about: the **global settings form**, the
**per‑vocabulary block**, and the ready‑made **cloud pages**.

## Global settings

Open **Configuration → Content authoring → TagClouds**
(`/admin/config/content/tagclouds`). You need the **administer tagclouds settings**
permission. These options are stored in the `tagclouds.settings` config object and apply
to every cloud unless a block overrides them.

- **Sort order** (`sort_order`, default *Title, ascending*) — how tags are ordered.
  Choose title ascending/descending, count (usage) ascending/descending, or random.
- **Display type** (`display_type`, default *style*) — *style* sizes each tag by
  popularity; *count* shows the raw usage number next to each tag instead.
- **Link to node** (`display_node_link`, default off) — when a term is used by only one
  item, link the tag straight to that item.
- **Show "more" link** (`display_more_link`, default on) — show a "more tags" link when
  the list is truncated.
- **Tags per page** (`page_amount`, default `60`) — how many tags appear on a cloud
  page. Set `0` to show them all.
- **Levels** (`levels`, default `6`) — the number of size levels, output as CSS classes
  `level1` … `levelN`. More levels give a finer range of sizes.
- **Language separation** (`language_separation`) — on a multilingual site, separate the
  tags by language. This option only appears when the site has more than one language.

Click **Save configuration** to apply. You can also set these from the command line:

```bash
drush cset tagclouds.settings levels 12 -y
drush cset tagclouds.settings sort_order 'count,desc' -y
drush cset tagclouds.settings display_type count -y
```

## The tag‑cloud block

TagClouds provides a block for **each vocabulary** (one derivative per vocabulary,
labelled "Tags in {vocabulary}"). Place it from **Structure → Block Layout**
(`/admin/structure/block`):

1. Click **Place block** in your chosen region.
2. Search for **Tags in …** and place the block for the vocabulary you want.
3. In the block's settings you can set:
   - **Number of tags** — how many tags this block shows (`0` = all).
   - **Vocabulary** — the vocabulary machine name (defaults to `tags`).
   - **Sort order** — leave it as *default* to follow the global setting, or pick a
     specific order just for this block.

The block renders nothing if the vocabulary machine name doesn't match a real
vocabulary, so double‑check the machine name if a block appears empty.

## The cloud pages

The module also exposes ready‑made pages, all visible to anyone with the *access
content* permission:

| Page | Path | Shows |
|------|------|-------|
| Cloud | `/tagclouds/chunk/{vocabulary}` | The weighted tag cloud for a vocabulary. |
| Term list | `/tagclouds/list/{vocabulary}` | The vocabulary's terms with their descriptions. |
| Legacy landing | `/tagclouds` | A general cloud entry point. |

Replace `{vocabulary}` with a vocabulary machine name (for example
`/tagclouds/chunk/tags`). You can combine several vocabularies in one path — see the
[`agent/`](../agent/configure/settings.md) docs for the exact syntax.

## Styling the cloud

Each tag is given a size class from `level1` to `level{levels}` based on how often it is
used. Style those classes in your theme's CSS to control the font size or colour of each
level. The module ships a baseline stylesheet (`tagclouds/clouds`) you can override, and
two Twig templates — `tagclouds-list-box.html.twig` and `tagclouds-weighted.html.twig` —
you can override to change the markup.

## Permission

| Permission | Machine name | Gates |
|------------|--------------|-------|
| Administer tagclouds settings | `administer tagclouds settings` | The global settings form. |

The cloud pages and blocks need only the standard *access content* permission.
