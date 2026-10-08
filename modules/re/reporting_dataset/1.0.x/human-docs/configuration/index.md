# Configuration

Reporting Dataset Builder is used through its **dataset builder** UI — a visual
schema explorer plus a drag-and-drop interface for choosing the fields that make
up a dataset. Rather than editing a single settings form, you create one or more
**datasets**, each of which the module turns into a SQL VIEW (or a materialized
table) in your database.

## Access

The module provides a permission that gates the builder. Grant it only to
**trusted administrators** — a dataset can flatten and surface data from across
your content, so building and viewing datasets is a privileged action. Assign the
permission at **People → Permissions**.

## Build a dataset

The typical workflow is:

1. **Open the dataset builder** and use the **visual schema explorer** to browse
   your entity structures — nodes, paragraphs, nested paragraphs, and entity
   references.
2. **Select the fields** you want in the dataset by dragging them into the
   builder. For example, from an *article* node you might pick `node.title`,
   `node.created`, and `node.field_tags.name`.
3. **Choose a data strategy** for how repeated or nested values are flattened:
   - **Expand** — produce one row per repeated/nested value.
   - **Aggregate** — combine repeated values into a single aggregated value.
   - **JSON** — store nested/multi-value data as a JSON structure in one column.
4. **Choose the storage type**:
   - **SQL VIEW** (default) — a live database view that always reflects current
     content.
   - **Materialized dataset table** — a physical table for better query
     performance, which you rebuild when the data changes.
5. **Save** the dataset. The module generates a database object named after the
   dataset, e.g. `reporting_dataset_article`.

Multilingual content is supported, so datasets can carry translated values.

## Rebuilding datasets

A dataset (especially a materialized one) needs to be rebuilt when the underlying
content changes. You can trigger a rebuild:

- from the **UI**, on the dataset's management screen,
- automatically on **cron**, or
- with **Drush**.

## Using the dataset

Once generated, a dataset is a normal database view or table:

- **Query it directly** in the database for ad-hoc analysis.
- **Use it in Drupal Views** by installing the
  [View Custom Table](https://www.drupal.org/project/view_custom_table) module and
  creating a View whose base table is the generated dataset — then display it as a
  report, dashboard, or export.
- **Export it** with a tool such as
  [Views Data Export](https://www.drupal.org/project/views_data_export), or point
  external BI tools (PowerBI, Tableau, Metabase) at the dataset.
