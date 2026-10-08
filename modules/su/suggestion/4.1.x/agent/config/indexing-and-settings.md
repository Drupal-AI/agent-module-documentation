<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Indexing, sources & settings

## Settings (`suggestion.config`, form `/admin/config/suggestion`)
| Key | Default | Meaning |
|---|---|---|
| `entry_style` | `simple` | `simple` = one `form_key`/`field_name` pair; `advanced` = many `form_id:field_name` lines. |
| `form_key` | `search_form` | (simple) form id to attach autocomplete to. |
| `field_name` | `keys` | (simple) field within that form. |
| `autocomplete` | `[]` | (advanced) map of `form_id => field_name`. |
| `min` | `4` | Minimum characters in an n-gram / minimum query length to serve. |
| `max` | `45` | Maximum characters in an n-gram. |
| `atoms_min` | `1` | Minimum words per n-gram. |
| `atoms_max` | `6` | Maximum words per n-gram. |
| `limit` | `20` | Max suggestions returned per request. |
| `types` | `[]` | Content types whose titles are indexed (required to index anything). |
| `action` | `/search/node` | Default form action for the search block. |
| `synced` | `true` | `false` triggers a reindex on next cron. |
| `rpp` | `100` | Results-per-page for admin listing/batch. |

`suggestion.stopword`: `stopwords` (sequence) + `hash`. Stopwords are removed during tokenization
and are edited from the same admin form.

Changing `atoms_max`, `atoms_min`, `limit`, `max`, `min`, `types`, or the stopword list sets
`synced = false`, scheduling a rebuild.

## The three index sources (`src` bitmap in `{suggestion}`)
- **Content (`1`)** — titles of published nodes of the selected `types`. Seeded by the
  "Index Suggestions" batch (`SuggestionIndexForm` → `BatchHelper`) and by cron
  (`suggestion_cron` → `Helper::index()` when not `synced`). Kept live by:
  - `hook_node_insert` — index title if published and of a selected type.
  - `hook_node_update` — remove old title / index new when publish state or title changes.
  - `hook_node_delete` — remove title n-grams if the node was published.
- **Priority (`4`)** — phrases an admin types in the "Priority Suggestions" textarea. Highest score.
- **Surfer (`2`)** — search terms visitors submit through an attached form
  (`suggestion_surfer_submit`). A term is only added when it already scores against published
  content (`SuggestionStorage::getScore()` matches the words in `node__body` of selected published
  types); otherwise an existing matching n-gram just has its `qty`/`density` bumped. This bounds
  what visitors can inject into the index to vocabulary already present in the site's content.

## Indexing pipeline (`SuggestionHelper`)
1. `tokenize($txt, $min)` — lowercase, replace non-`[a-z]` with spaces, drop words shorter than
   `min`, collapse whitespace.
2. `atomize()` — split into words, dropping stopwords.
3. `ngrams()` — forward and reversed word windows of `atoms_min`..`atoms_max` words.
4. Each n-gram over `max` chars is skipped; the rest are `MERGE`-ed into `{suggestion}` with
   `atoms` (word count), `qty` (occurrence count), `src` (OR-ed bitmap via `getBitmap()`), and
   `density` (`calculateDensity()` — a source-weighted score with a diminishing-returns delta).

## Admin index management
- `/admin/config/suggestion/index` — status ("Indexing required." / "No indexing required.") and
  a batch "Index Suggestions" run, with an optional **Flush all suggestions** (truncate) checkbox.
- `/admin/config/suggestion/search[/{ngram}]` — browse/search the index.
- `/admin/config/suggestion/edit/{ngram}` — edit one n-gram's `atoms`/`qty`/`src` (source) or
  remove it. Useful for suppressing an undesirable completion.

## Operational notes
- A fresh install indexes nothing until `types` is set and an index run happens; the
  `{suggestion}` table starts empty (confirmed on the reference site: 0 rows out of the box).
- Suggestion quality scales with content volume; low-content sites lean on priority phrases,
  high-content sites tune `min`/word-count/`limit` down to keep the table and latency manageable.
