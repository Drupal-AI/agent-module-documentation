# Configuration

Configuration happens in two places, both under **Configuration → Search and
metadata → Search API** (`/admin/config/search/search-api`): the **server** (where
you choose the SQLite FTS5 backend and set storage-wide options) and each
**index** (where you tune how that index tokenises and matches text).

## Server configuration

1. Go to **Configuration → Search and metadata → Search API**.
2. Add a new server (or edit an existing one).
3. Select **SQLite FTS5** as the backend.
4. Configure the server options:
   - **Database path** — where the SQLite database files are stored. Defaults to
     `private://search_api_sqlite/`.
   - **Query logging** — log all search queries for later analysis. Leave this off
     unless you are actively investigating search behaviour.

Save the server, then point one or more indexes at it.

## Index configuration

Index-specific settings are configured per index, so different indexes on the same
server can behave differently. On your index's edit page, configure the SQLite FTS5
options:

- **Tokenizer** — how text is broken into searchable tokens:
  - **Unicode61** *(recommended for most sites)* — the default, general-purpose
    tokenizer.
  - **Porter** — English stemming, so "running" and "run" match.
  - **ASCII** — a simple English tokenizer.
  - **Trigram** — enables **substring** search (matching inside words), at the cost
    of a larger index.
- **Case-sensitive matching** — available for the **Trigram** tokenizer only.
  Useful when, for example, product codes differ only by letter case.
- **Minimum word length** — search terms shorter than this are ignored in queries.
  This filters *queries*, not what gets indexed, and does not apply to the Trigram
  tokenizer.
- **Default matching mode** — how multiple search terms are combined:
  - **Match all words (AND)** — every term must appear.
  - **Prefix matching** — matches word beginnings; best for autocomplete.
  - **Partial matching** — substring search with the Trigram tokenizer; falls back
    to prefix matching with the other tokenizers.
  - **Phrase matching** — the terms must appear in exact order.
- **Auto-optimization** — automatically optimise the index after a configured
  number of changes, to keep it fast over time.

Save the index and reindex your content so the new tokenizer and matching settings
take effect.

## Optional companion features

Several features come from other modules working through this backend, so enable
the matching module if you want them:

- **Faceted search** — via the **Facets** module.
- **Autocomplete** — via the **Search API Autocomplete** module.
- **Highlighting** — native FTS5 highlighting, provided as a Search API processor
  you enable on the index.
- **"Did you mean?" spell check** — via a processor that requires the **Search API
  Spellcheck** module.
