# Configuration

Setting up a content index is a two-step rhythm: **define** the index (which entity,
which fields, how each field is shaped) in Drupal, then **set it up** (create it in
Elasticsearch) from the index-management list. Everything here requires the
**Administer site configuration** permission.

## Create a content index

1. Go to **Configuration → Search and metadata → Elasticsearch Helper → Index**
   (`/admin/config/search/elasticsearch_helper/index`).
2. Click **Add content index**.
3. Fill in the form:
   - **Label** — a human-readable name for the index.
   - **Index name** — the Elasticsearch index name the documents will be written to.
   - **Entity type / bundle** — the content entity type (and bundle) you want to
     index, for example Article nodes.
   - **Fields** — select which of the entity's fields should be indexed.
4. Save the form.

## Choose a normalizer per field

For each field you index, you assign a **normalizer** — the plugin that decides how
that field's value is written into Elasticsearch. The module ships a broad library,
so you can pick the shape that matches how you'll query the field:

- **Text** and **Keyword** — full-text-analysed text versus exact-match strings.
- **Boolean**, **Integer**, **Float**, **Date**, **Email** — typed scalar values.
- **Entity reference** — index the referenced entity by **id** or by **label**,
  depending on whether you need to match/filter on the reference or display its
  name.
- **Link** — index the **uri**, the **label**, or both.
- **Path / File path / Image path** — index the path to a file or image.
- **Rendered entity / Rendered field** — index the rendered HTML output of the whole
  entity or a single field.
- **Address (plain)** — map a structured address into the index.

Choosing the right normalizer per field is what makes the resulting documents useful
for the queries you plan to run.

## Set up (create) the index in Elasticsearch

Defining the index in Drupal does not create it in Elasticsearch — you do that from
the index-management list:

1. Back on the index list at `/admin/config/search/elasticsearch_helper/index`, find
   your new index.
2. Click **Setup** next to it to create the index in Elasticsearch.
3. Use the same list's operations later to **reindex** content or **drop** the index
   when needed.

## A note on unpublished content and access

The module includes handling for how unpublished content is treated during
indexing, so review that behaviour for your entity type before you rely on it.
Remember, too, that once documents are in Elasticsearch they are outside Drupal's
entity access system — anything querying the index directly sees what's in it — so
be deliberate about which fields (and which content states) you index if the data is
sensitive.

## Extending with custom normalizers

If a field needs shaping the shipped normalizers don't cover, a developer can add a
custom **field** or **entity** normalizer plugin; once defined, it becomes
selectable on this same content-index form.
