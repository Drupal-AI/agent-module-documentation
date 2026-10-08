<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Coveo Integration — agent index

A **Search API backend for the Coveo** search engine (index Drupal content into Coveo; queries served by
Coveo). `search_api_coveo_keys` submodule. Depends on `search_api`. Version **1.0.0-alpha9**. Core
`^9.5||^10||^11`.

**Security:** store Coveo API keys as **secrets** (keys submodule/Key); HTTPS; ensure search **respects
content access** (don't surface restricted content). No access role of its own.
