# Configuration

Queue Import has a single admin form: the connection details for the **legacy
Drupal 7 database** you want to import content from. Everything else is done with
Drush (see the [overview](../index.md) for the full command workflow).

## Open the database‑connection form

1. Log in as an administrator.
2. Go to **Configuration → Development → Queue Import**, or navigate directly to
   `/admin/config/development/queue-import`.

## Fill in the database connection

Enter the connection information for your source database. **It must be a Drupal 7
database** — the module reads the D7 schema to discover a content type's fields and
scaffold a map class for it. Typical fields are the host, database name, username,
password, and port for that database.

Save the form, then continue with the Drush workflow:

```bash
drush d7fm article   # generate MapArticleQueueProcessor.php from the D7 fields
# …edit the mapping, rename to ArticleQueueProcessor.php…
drush d7 article 1   # queue content of that type
drush queue-run article_queue_processor
```

## A note on the database credentials

The connection details you enter here include a **database password** — treat them
as a secret. Avoid committing them to version control, and remove or rotate the
credentials once the migration is finished. Where your workflow allows, prefer
defining the legacy connection as an extra database in `settings.php` (which is kept
out of version control) rather than leaving live credentials sitting in site
configuration.
