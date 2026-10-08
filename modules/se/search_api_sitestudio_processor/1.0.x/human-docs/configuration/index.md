# Configuration

There is no central settings page for this module. Instead, you add one field to
your Search API index, and that field carries all of the configuration. Adding the
field is what switches the processor on.

## Add the field to your index

1. Make sure Acquia Site Studio and Search API are installed and you already have
   a Search API index.
2. Go to your index's **Fields** page under **Configuration → Search and metadata
   → Search API** (`/admin/config/search/search-api`).
3. Add a field for the property **Sitestudio Components**. This is the anchor
   point into which the decoded Site Studio text will be injected.
4. Adding the field automatically activates the processor; it will run on the next
   indexing operation.

## Choose which components feed the index

Once the field is added, its configuration form is where you decide how much of
your Site Studio content to index:

- **Enable all Site Studio components** *(default: on)* — indexes the text from
  every component on the page. This is the simplest choice and gives the most
  comprehensive search coverage. Turn it off when you want to be selective.
- **Per-category selection** — the form presents a set of tabs, one for each Site
  Studio component category. Within a category you can tick **Enable full
  &lt;category&gt;** to index every component in that group.
- **Per-component selection** — inside each category you can instead tick
  individual components, so only the named components you choose (for example only
  a *Hero Banner* or only a *Text* component) contribute their text to the index.

Narrowing the selection is how you keep the index smaller and exclude decorative
or settings-only components that add no useful search text.

## What gets extracted

For each item, the processor finds the Site Studio layout, decodes the component
tree (including nested child components), and pulls the readable text from each
selected component's model — skipping settings values, numeric-only and
media-reference values, and stripping tags and entities from rich text. The
cleaned text from all selected components is concatenated into the **Sitestudio
Components** field.

## Reindexing and error handling

Changes take effect when the affected items are reindexed. Extraction is wrapped
in broad error handling: if a component tree can't be decoded, the module logs an
error and — during immediate ("index on save") indexing — adds a warning so the
item is re-queued for the next cron run rather than being marked done. A single
malformed layout will not break the whole index.

You can audit exactly which components are feeding your search by reading back this
field's configuration.
