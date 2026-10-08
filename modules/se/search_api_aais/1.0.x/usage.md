<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Azure AI Search provides an integration for Search API to index content in an Azure AI Search server.

---

Search API Azure AI Search (search_api_aais) provides a Search API backend that indexes and queries
content using Azure AI Search (formerly Azure Cognitive Search) — Microsoft's hosted search service with
AI/semantic capabilities. Content indexed via Search API is stored in and queried from Azure. It depends
on core Language and Search API, is configured at `search_api_aais.configuration_form`, and ships
autocomplete, key and logging submodules.

Use it to power site search with Azure AI Search (semantic/vector search, Azure-hosted). The
security-relevant point is the Azure credentials (admin/query keys) — store them as secrets (the module
integrates a key submodule for this), scope query vs admin keys appropriately, and note that indexed
content is sent to and stored in Azure (a data-residency/handling consideration). It is a search-backend
integration; configure the Azure service connection and index.

---

- Index content in Azure AI Search.
- Provide a Search API backend.
- Use Azure semantic/vector search.
- Depend on Language and Search API.
- Configure at the configuration form.
- Use the key submodule for credentials.
- Store Azure keys as secrets.
- Scope query vs admin keys.
- Note indexed content is stored in Azure.
- Consider data residency.
- Ship autocomplete/logging submodules.
- Power search with Azure.
- Query from Azure AI Search.
- Configure the Azure connection.
- Index via Search API.
- Handle Azure credentials securely.
- Support semantic search.
- Send content to Azure.
- Integrate a hosted search backend.
- Configure the index.
