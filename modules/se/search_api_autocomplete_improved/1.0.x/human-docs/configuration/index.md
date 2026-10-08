# Configuration

Search API Autocomplete Improved is designed to work **out of the box** — it
automatically discovers your Views and Search API configuration from your existing
Search API Autocomplete entities, so for most sites there is nothing you need to
configure. This page is here for the cases where you want to adjust its behaviour.

## Open the settings form

1. Log in as a user with the **Administer Search API autocomplete**
   (`administer search_api_autocomplete`) permission. The module deliberately reuses
   this existing Search API permission rather than inventing a new one.
2. Navigate to
   `/admin/config/search/search-api/search_api_autocomplete_improved` (under
   **Configuration → Search and metadata → Search API**).

## What the form is for

The settings form lets you tune the module's behaviour on top of its sensible
defaults. Since it works with zero configuration, treat the form as optional
fine-tuning rather than a required step — the automatic discovery, duplicate removal,
suggestion validation, and cached result-count calculation are all active whether or
not you open it.

## How caching stays fresh

The module keeps its own cache bin for the extra result-count lookups so autocomplete
stays fast, and it invalidates those cached counts automatically when the search index
is updated (via an event subscriber). A standard `drush cr` cache rebuild also clears
them. In normal use you should not need to manage the cache manually.
