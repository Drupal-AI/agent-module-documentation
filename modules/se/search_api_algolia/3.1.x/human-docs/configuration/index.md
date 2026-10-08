# Configuration

Algolia Search is configured through **Search API**, not through a settings page of
its own. There are three parts: create a server that uses the Algolia backend,
create an index that writes to an Algolia index, and (optionally) adjust the small
module‑wide settings. All of the Search API screens are under **Configuration →
Search and metadata → Search API** (`/admin/config/search/search-api`).

## 1. Add the Algolia server

1. Go to **Search API** and click **Add server**.
2. Give it a name and choose **Algolia** as the backend.
3. Fill in the backend settings:
   - **Application ID** — your Algolia Application ID.
   - **API Key** — your Algolia **Write** API Key.
   - **Disable truncate** — leave off unless you specifically need to stop values
     being truncated before indexing.
4. Save. The server connects to Algolia using these credentials.

Store the Write API Key securely (Key module or environment variable) rather than in
committed configuration.

## 2. Add an index pointed at Algolia

1. Back on the Search API page, click **Add index**.
2. Choose the data sources (e.g. Content/nodes), and set the index's **server** to
   the Algolia server you just created.
3. Save, then edit the index. On the index edit form you'll see extra
   **Algolia‑specific options**:
   - **Algolia index name** — the name of the Algolia index this Search API index
     writes to.
   - **Apply language suffix** — for multilingual sites, appends a language code
     (e.g. `_en`, `_fr`) so each language gets its own Algolia index.
   - **Batch deletion** — delete items from Algolia in batches; required if you want
     to use a custom object‑id field (below).
   - **Object ID field** — a field to use as Algolia's `objectID` instead of the
     Search API default. (Setting this requires batch deletion to be on — the form
     rejects it otherwise.)
   - **Partially update objects** — update only the populated fields rather than
     replacing the whole Algolia record.
4. Add the fields you want indexed, configure any processors, and index your
   content.

### Keeping records under Algolia's size limit

Algolia caps the size of a single record. If you index large items, add the
**Algolia item splitter** processor to the index — it splits one Drupal item into
several Algolia records so each stays under the limit.

## 3. Module‑wide settings

Two site‑wide options live in the `search_api_algolia.settings` config object.
There's no form for them; set them with Drush:

- **debug** (default off) — verbose logging around indexing and queries, useful when
  troubleshooting.
- **wait_for_delete** (default off) — wait for Algolia delete operations to complete
  before continuing.

```bash
drush cget search_api_algolia.settings
drush cset search_api_algolia.settings debug true -y
```

## Flushing queued deletions (Drush)

When content is deleted, its Algolia records are queued for removal (in the
`search_api_algolia_deleted_items` table). Flush that queue with the module's Drush
command:

```bash
drush search_api_algolia:delete        # alias: drush sapia-d
drush sapia-d --batch-size=100         # tune how many items per batch (default 100)
```

The command needs a working Algolia connection (valid Application ID and Write API
Key on the server) to actually remove the remote objects.

## Sorting and autocomplete (conventions)

These are set up in Algolia following naming conventions rather than in a Drupal
form:

- **Sorting** uses Algolia **replicas** — create a replica per exposed sort, named
  like `PREFIX_LANGCODE_field_direction` (direction `asc`/`desc`).
- **Autocomplete** uses Algolia **Query Suggestions** — create a query index named
  `INDEXNAME_query` and use the **Search API Autocomplete** module.

See the module's `INSTALL.md` for the full field/processor walkthrough.

## Extending it (developers)

Three alter hooks let you customise behaviour: the Algolia client config, the
objects sent for indexing, and the sorts. See the [`agent/`](../agent/start.md)
hooks docs.
