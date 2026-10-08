# Configuration

All configuration happens on your **Search API index** (backed by an Elasticsearch
Connector server) — there is no separate settings page. It's a two‑step process:
turn on the ngram analyzer for the index, then mark the fields you want
partial‑word matching on.

## 1. Enable the ngram analyzer on an index

1. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`) and **Edit** your Elasticsearch‑backed
   index.
2. Find the **Elasticsearch specific index options** section the module adds, and
   tick **Enable ngram analyzer**.
3. Set the ngram configuration:
   - **Ngram type** — choose *edge_ngram* for **prefix matching** (matches from the
     start of a word — the usual choice for typeahead), or *ngram* for **substring
     matching** (matches a fragment anywhere in a word).
   - **min gram** *(default 3)* — the shortest fragment that gets indexed, i.e. the
     fewest characters a visitor must type before matches appear.
   - **max gram** *(default 20)* — the longest fragment indexed. This bounds token
     size; larger ranges match more but grow the index.
4. Save.

Enter whole numbers for min/max gram. Keep the range sensible — a very large range
substantially increases index size.

> **Rebuild warning.** If you enable, disable, or change the ngram settings on an
> index that **already exists**, the module must delete and rebuild that index. The
> form shows a confirmation: *"You are changing the analyzer on an existing index.
> This will result in the index being deleted and rebuilt and you will have to
> reindex all items."* Confirm to proceed, then re‑index the content.

## 2. Apply the Fulltext (ngram) type to fields

Once ngram is enabled on the index, a new field data type becomes available:

1. Open the index's **Fields** tab.
2. For each field you want search‑as‑you‑type on (for example **Title** or
   **Name**), change its type to **Fulltext (ngram)** (`text_ngram`). A boost
   select appears for it, so you can weight ngram fields relative to others.
3. Leave other fields on standard **Fulltext** if they don't need partial‑word
   matching.
4. Save, then re‑index if prompted.

If you later uncheck *Enable ngram analyzer*, the **Fulltext (ngram)** option
disappears from the field type list again.

## What the module sends to Elasticsearch

You don't have to configure any of this — it's handled for you — but for
reference: when ngram is enabled the module adds a custom `ngram_filter` and
`ngram_analyzer` (a standard tokenizer with lowercase + the ngram filter) to the
index's analysis settings, and maps each *Fulltext (ngram)* field as a `text`
field using `ngram_analyzer` at index time and the standard analyzer at query
time, with an extra `keyword` sub‑field for exact matching and sorting. Using the
standard analyzer at query time means a typed fragment matches the indexed ngrams
without over‑matching.

## Where the settings are stored

These options are saved as **third‑party settings** on the Search API index config
entity (under the `elasticsearch_connector` provider), not in a config object owned
by this module. That means they travel with the index when you export your site
configuration.
