# Configuration

This connector has no settings page of its own. You configure it where all Data
Pipelines destinations are configured: on a **dataset's destination**. After
enabling the module, edit (or create) a dataset at **Content → Datasets**
(`/admin/content/datasets`), go to its destination configuration, and choose the
**OpenSearch** destination type. You then supply the connection details for your
cluster — its host/URL, the target index, and the credentials to authenticate.

## Handle the credentials as secrets

Connecting to OpenSearch requires authentication details, and those are secrets.
Do not paste them into plain configuration where they can end up in exported
config or version control. The recommended pattern:

1. **Store the secret in an environment variable.** With DDEV, save it to the
   project's dotenv file and restart so the web container picks it up:

   ```bash
   ddev dotenv set .ddev/.env --opensearch-password=<value>
   ddev restart
   ```

   The flag `--opensearch-password` becomes the environment variable
   `OPENSEARCH_PASSWORD`. Never commit `.ddev/.env`.

2. **Expose it through a Key entity.** Install the
   [Key](https://www.drupal.org/project/key) module if it is not already enabled
   (`ddev composer require drupal/key && ddev drush en key -y`), then create a Key
   backed by the environment provider so the value is read from the variable at
   runtime rather than stored in config.

3. **Use HTTPS.** Point the destination at the cluster over `https://` so the data
   and credentials are encrypted in transit.

## Mind the egress

Every dataset that uses this destination sends its processed data out to the
OpenSearch cluster. Before wiring it up, confirm that:

- the data is appropriate to send to that cluster, and
- your environment is permitted to make the outbound connection to it.

Once the destination is configured, running the dataset through its pipeline pushes
the transformed records into the OpenSearch index.
