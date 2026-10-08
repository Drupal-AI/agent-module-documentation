# Installation

## Requirements

- **Drupal 10.1+, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The **AI** module (`ai`) — provides the LLM provider system the chat calls.
- The **Search API** module (`search_api`) — supplies the indices RAG retrieves
  from. You need at least one index over the content you want searchable.
- The **Key** module (`key`) — stores the AI provider's credential securely.

Drupal pulls these in as dependencies. You also need a working **AI provider**
configured in the AI module (with its API key stored as a Key), and a Search API
index built over the content you want the chat to answer from.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_rag_search_chat -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_rag_search_chat -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_rag_search_chat -y
```

The module's install step creates its two database tables
(`ai_rag_search_chat_sessions`, `ai_rag_search_chat_messages`). If you are
upgrading an existing install, run `drush updb -y` to apply any pending update
hooks.

## Set up the pieces it depends on

1. **Configure an AI provider** in the AI module and store its API key as a Key
   (not in plain configuration).
2. **Build a Search API index** over the content you want the chat to answer
   from, and index it. For meaning-based retrieval, pair it with a vector /
   embeddings backend (for example the AI Search module).
3. **Configure the module** at **Configuration → AI → AI RAG Search Chat** —
   point it at your index(es) and choose the LLM provider and model. See
   [Configuration](../configuration/index.md).
4. **Grant permissions** at **People → Permissions**: give *Access AI RAG search
   chat* to the roles that may use the search/chat, and keep *Administer AI RAG
   search chat* for administrators.

## Verify it worked

Visit `/ai-search` and `/ai-search/chat`. Ask a question whose answer is in your
indexed content — you should get a grounded answer with source citations. Leave
rate limiting enabled so the LLM-calling endpoints stay throttled.
