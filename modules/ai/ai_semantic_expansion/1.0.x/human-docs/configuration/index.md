# Configuration

AI Semantic Expansion has no global settings page of its own. You switch it on
**per Search API index**, and it takes effect the next time that index is built.

## Before you start

Make sure the **AI** module has a working provider configured, with its API key
stored as a secret (via the Key module or an environment variable, per the AI
module's own setup). The expansion cannot generate synonyms without a provider to
call, and every generation is billed by that provider.

## Turn on the expansion for an index

1. Log in as a user who can administer Search API (an administrator by default).
2. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`) and open the index you want to improve.
3. Enable the AI Semantic Expansion enrichment on that index and save. This is
   where the module adds the AI-generated synonyms and search intents to the
   index data.
4. **Reindex** the content so the new AI-derived terms are written into the
   index.

## What to expect

- Indexing will now make calls to your AI provider for the content being
  processed, so a full reindex of a large site can take longer and will incur
  provider cost. Plan reindexes accordingly.
- Because the extra terms are stored in the ordinary Search API index, no vector
  database is involved and your existing Search API backend keeps working as
  before — searches simply match more broadly.
