# xnttsql — usage

External Entities SQL Database Storage Client. Adds a `sql` storage client so an external entity type
can be backed by an external SQL database or schema (MySQL/PostgreSQL, and whatever the dbxschema
module supports). You provide SQL queries for Read, List, Count and — optionally — Create, Update and
Delete, and each column the Read query returns becomes a field on the entity.

---

The client uses the Database Cross-Schema Query API (dbxschema) to reach other schemas or other
database connections declared in `settings.php`. Tables are referenced with a `{index:table}`
notation tied to the configured schema list, computed columns are aliased with `AS`, and filter values
supplied by the entity query are bound as parameters. Optional named placeholders (resolved from a
constant or a lookup query) keep the same query set portable across databases. It is not enabled in
the parent's default storage clients because of the extra dbxschema dependency.

---

- Expose rows of an external SQL table as a Drupal entity type.
- Read from a different schema of the same PostgreSQL database as Drupal.
- Read from a separate MySQL database sharing the Drupal server credentials.
- Read from a completely separate database server (different driver, credentials).
- Join several tables in a Read query and map the result columns to fields.
- Return a computed/expression column (e.g. concatenation) as a single field.
- Make entities read-only by providing only Read/List/Count queries.
- Enable create/update/delete by adding the corresponding queries.
- Use SQL procedures/functions in CREATE/UPDATE to keep logic in the database.
- Parameterize queries with named placeholders resolved from constants or lookups.
- Filter and sort remote rows from Views or entity queries via source-side SQL.
- Read PostgreSQL array columns (`array_*`) into multi-value fields.
- Read JSON columns (`json_*`) into structured field values.
- Combine multiple schemas/databases into one entity type with several sql clients.
- Migrate or mirror data between two schemas by pointing write queries at a second schema.
