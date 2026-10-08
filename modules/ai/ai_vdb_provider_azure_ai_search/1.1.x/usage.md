<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registers Azure AI Search as a vector-database provider for the Drupal AI module's AI Search submodule.

---

Azure AI Search VDB Provider adds an "Azure AI Search DB" vector-database (VDB) provider plugin to the
Drupal AI module, so the AI Search / Search API stack can store document embeddings in — and run similarity
(kNN) queries against — an Azure AI Search index instead of a self-managed vector store. You create the index
in Azure first, then point a Search API server (AI Search backend) at it by choosing the provider and
supplying the Azure service URL, API version, index name and an API key held in a Key entity. It talks to the
Azure REST Search Service API over HTTPS and normalizes results back into the shape the AI Search module
expects. It is an experimental module in the AI Vector Database Providers package and provides no routes or
permissions of its own beyond a single admin settings form.

---

- Use Azure AI Search as the vector store behind Drupal AI Search / RAG.
- Register the "Azure AI Search DB" VDB provider (plugin id `azure_ai_search`).
- Store and update embeddings in an existing Azure AI Search index.
- Run vector (kNN) similarity queries against Azure from Search API.
- Run metadata-only (filter) queries with no vector input.
- Map Search API condition groups to Azure filter expressions.
- Reuse an Azure AI Search service you already operate.
- Keep the Azure API key in a Key entity rather than plain config.
- Configure the Azure service URL and REST API version per site.
- Select which Azure index a Search API server writes to.
- Delete indexed documents by Drupal entity ID.
- Fetch stored documents by Drupal entity ID.
- View index storage size and document count on the server status page.
- Ping the Azure service to validate connectivity and credentials.
- Swap Azure in for another VDB provider without changing your Views.
- Back an AI Assistant / chatbot with Azure-hosted semantic search.
- Build retrieval-augmented generation (RAG) over content indexed to Azure.
- Restrict configuration to users with the "administer ai providers" permission.
- Let Search API handle chunking/embedding while Azure handles storage/retrieval.
- Support Drupal 10.2+ and Drupal 11.
