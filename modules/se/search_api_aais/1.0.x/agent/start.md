<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Azure AI Search — agent index

**Search API backend** indexing/querying content in **Azure AI Search** (semantic/vector, Azure-hosted).
Depends on core `language`, `search_api`. Config at `search_api_aais.configuration_form`; autocomplete/
key/logging submodules. Version **1.0.0-rc10**. Core `^9.2||^10||^11`.

**Security:** store Azure keys as secrets (key submodule); scope query vs admin keys; indexed content is
sent to/stored in Azure (data-residency consideration).
