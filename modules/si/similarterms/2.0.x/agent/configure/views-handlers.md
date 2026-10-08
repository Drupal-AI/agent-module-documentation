# The three Views handlers and their options

No settings form (`configure` is null). You build a view and add the handlers. On the `node`
table they live in the Views group **"Similar by terms"**.

## Contextual filter — `similar_nid` (handler `similar_terms_arg`)

Add under *Advanced → Contextual filters* → "Similar by terms: Nid". Takes a node ID as the
argument and restricts results to nodes sharing that node's terms. Extends core's numeric
argument. Options (config schema `views.argument.similar_terms_arg`):

| Option | Type | Default | Meaning |
|---|---|---|---|
| `vocabularies` | sequence of vocab ids | `[]` (all) | Limit similarity to terms in these vocabularies only. Leave empty to use all. |
| `include_args` | boolean | `false` | Include the argument node itself in the results (default excludes it). |
| `min_match_percentage` | integer | `0` | Minimum share of the source's terms a result must match: `0`, `25`, `50`, `75`, or `100` (exact match). Implemented as a HAVING clause on the matching-term count. |

## Sort — `similar_terms_sort`

Add under *Sort criteria* → "Similar by terms: Similarity". Options
(`views.sort.similar_terms_sort`):

| Option | Type | Default | Meaning |
|---|---|---|---|
| `sort_method` | string | `count` | `count` = order by number of matching terms; `weight` = order by SUM of matching terms' weights. |
| `order` | string | `DESC` | Standard Views sort order. |

## Field — `similarterms` (handler `similar_terms_field`)

Add under *Fields* → "Similar by terms: Similarity". Options
(`views.field.similar_terms_field`):

| Option | Type | Default | Meaning |
|---|---|---|---|
| `count_type` | integer | `1` | `0` = raw count of common terms; `1` = percentage of the source node's terms; `2` = sum of matching term weights. |
| `percent_suffix` | boolean | `true` | Append `%` when `count_type` is `1` (percentage). |
| `weight_suffix` | string | `''` | Text appended after the weight sum when `count_type` is `2` (e.g. ` pts`). |

## Typical wiring

1. Create a view of Content (nodes), display type Block.
2. Add contextual filter **Similar by terms: Nid**; set its default value to the current node
   (e.g. "Content ID from URL") so the block works on node pages.
3. Add sort **Similar by terms: Similarity** (DESC).
4. (Optional) Add field **Similar by terms: Similarity** to show the score.
5. Place the block on the node page.

## Where it is stored / drush

Everything is in the view config:

```
drush config:get views.view.<id> \
  display.<display>.display_options.arguments.similar_nid
drush config:get views.view.<id> \
  display.<display>.display_options.sorts.similarterms
```

With `taxonomy_entity_index` enabled the argument id becomes `similar_<entitytype-idkey>`
(e.g. `similar_nid` stays for nodes, `similar_mid` for media) and the handlers are available on
each content entity type's base table.
