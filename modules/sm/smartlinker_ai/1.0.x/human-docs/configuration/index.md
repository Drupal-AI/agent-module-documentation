# Configuration

SmartLinker AI needs two things in place before it can suggest links: a working AI
Search index over your content (so the AI has candidate pages to link to), and the
feature switched on inside a text format's CKEditor toolbar. The steps below follow
the maintainers' documented setup.

## 1. Set up the vector database (Zilliz Cloud)

1. Sign up on **Zilliz Cloud** and create a cluster (the free tier offers one
   cluster with 5 GB of storage).
2. From the cluster settings, copy the **endpoint** and **API key**.

## 2. Set up the Milvus DB provider

1. Install and enable the **Milvus** module (the vector-database provider for AI
   Search).
2. Take the API token from Zilliz Cloud, save it as a `.key` file, and place it in
   the directory your Key configuration expects. Keep this token out of plain
   config.

## 3. Configure the AI Search server and index

1. In **Search API** settings, add a server that uses **AI Search** as its backend.
2. Choose **Milvus DB** as the vector database and link it to your Zilliz
   collection.
3. Create a **search index**, select **Content** as the data source, and configure
   the indexing settings.

## 4. Choose the fields to index

Index the fields the AI should use to find and describe link targets, for example:

- **Content type** — as a filterable attribute.
- **Title** — as the main content.
- **Body** — as contextual content.
- Any additional fields you want considered.

Then run indexing so your content is embedded and searchable.

## 5. Turn on SmartLinker AI in CKEditor

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`) and edit the text format whose
   editor should gain the feature.
2. In the **CKEditor 5** toolbar/plugin settings, **enable the SmartLinker AI
   feature**.
3. In its settings, select the **search index** you created and the **AI provider**
   (for example OpenAI GPT-4o).
4. **Save** the text format.

## Permissions and cost

SmartLinker AI provides its own permission — grant it only to the editor roles that
should use the feature. Remember that every *Generate internal links* action makes a
paid AI call and runs a vector search over your indexed content, so keep it scoped
to trusted editors and mind your provider and vector-database usage limits.
