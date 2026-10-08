<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Building a guide

## Install

```bash
composer require drupal/localgov_guides
drush en localgov_guides -y
drush cr
```

## The two bundles

| Bundle | Key field | Meaning |
|---|---|---|
| `localgov_guides_overview` | `localgov_guides_pages` | Ordered entity references to the guide's pages — **this is the running order** |
| `localgov_guides_page` | `localgov_guides_parent` | Reference to the overview this page belongs to |

Create a guide from the CLI:

```bash
drush php:eval '
$overview = \Drupal\node\Entity\Node::create([
  "type" => "localgov_guides_overview",
  "title" => "Applying for a parking permit",
]);
$overview->save();

foreach (["Check you are eligible", "Gather documents", "Apply online"] as $title) {
  \Drupal\node\Entity\Node::create([
    "type" => "localgov_guides_page",
    "title" => $title,
    "localgov_guides_parent" => $overview->id(),
  ])->save();   // node_insert appends it to the overview automatically
}
print implode(",", array_column($overview->localgov_guides_pages->getValue(), "target_id"));
'
```

You never have to maintain both sides: setting `localgov_guides_parent` on a page is enough, and
editing the overview's list re-syncs the other direction.

## Reordering

Order lives in the **overview's** `localgov_guides_pages` field. Drag the rows on the overview
edit form, or set deltas programmatically:

```bash
drush php:eval '
$o = \Drupal\node\Entity\Node::load(12);
$o->set("localgov_guides_pages", [["target_id" => 15], ["target_id" => 13], ["target_id" => 14]]);
$o->save();'
```

## Blocks

| Block plugin | Label | Renders |
|---|---|---|
| `localgov_guides_contents` | Guide contents | The guide's table of contents |
| `localgov_guides_prev_next_block` | Guides prev next block | Previous / next page links |

Place them at `/admin/structure/block`, typically restricted to the two guide bundles. On
LocalGov Base they are placed for you; on a custom theme they are not.

## The sync behaviour in detail

`ChildParentRelationship::overviewPagesCheck()` runs on **prepare form and presave** of an
overview:

```php
$actual_children  = // entity query: localgov_guides_page WHERE localgov_guides_parent = overview
                    // ->accessCheck(TRUE)
$linked_children  = array_column($node->localgov_guides_pages->getValue(), 'target_id');
// append array_diff($actual_children, $linked_children)
// unset  array_diff($linked_children, $actual_children)
```

Two consequences worth planning around:

1. **`accessCheck(TRUE)`** — the query runs as the current user. If a page is unpublished and the
   editor saving the overview cannot view unpublished content, that page counts as "not a child"
   and is **removed** from the list. Give guide editors `bypass node access` or the relevant
   `view own unpublished content` permission, or expect list churn on moderated sites.
2. `pageUpdateOverview()` **saves the other overview node(s)** as a side effect of saving a page —
   so a page save can generate two or three node saves, each with its own revision if the bundle
   creates revisions by default.

## Optional integrations

```bash
# Guides inside the services tree:
drush en localgov_services_navigation -y   # hook_modules_installed imports localgov_services_parent
# Guides classified by topic:
drush en localgov_topics -y                # imports localgov_topic_classified
```

If those modules were installed during a config sync, the hook returns early — import the optional
config manually:

```bash
drush php:eval '\Drupal::service("config.installer")->installOptionalConfig(NULL, ["config" => "field.storage.node.localgov_services_parent"]);'
```

## Preview

The `Guides` PreviewLinkAutopopulate plugin means generating a preview link for an overview also
covers its pages — useful for sharing an unpublished guide with a reviewer.
