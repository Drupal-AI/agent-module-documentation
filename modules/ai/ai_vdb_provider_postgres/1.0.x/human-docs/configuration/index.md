# Configuration

This provider has a proper settings form of its own, where you enter the Postgres
connection, choose how the password is supplied, and pick a pgvector index
strategy. Setup is two steps: store the password as a Key, then fill in and test
the connection.

## 1. Store the database password as a Key

Never paste the Postgres password into a plain settings field or configuration
file. Instead:

1. Make the password available to the site as an **environment variable** (for
   DDEV, `ddev dotenv set` then `ddev restart`).
2. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and add a
   new key that reads from that environment variable (authentication key type,
   environment provider).

The settings form stores only the **Key's id**, not the secret — the plaintext is
read in memory just to test the connection — so nothing sensitive reaches exported
configuration.

## 2. Fill in the settings form

Open the module's settings form under the site's AI configuration
(**Configuration → AI**; route `ai_vdb_provider_postgres.settings_form`). Provide:

- the Postgres **host**, **port**, **database name**, and **username**;
- the **password**, selected from the Key you created in step 1 (a Key selector,
  not a free-text field);
- the pgvector **index strategy** — this is the main performance lever in pgvector,
  trading build time, memory, and recall against each other. Start with the
  default unless you have a reason to tune it.

## 3. Test the connection

Use the form's connection test before saving. This is also the moment you will
find out whether **pgvector is actually installed** on the server — if the
extension is missing, the test fails. The module does not install pgvector for
you, so if the test reports it is unavailable, add the extension to your Postgres
server and try again.

Once the connection succeeds, save the form, then index your content so its
embeddings are written into Postgres.

## Things to check

- **Experimental.** The module is marked experimental (release 1.0.0-alpha3) —
  treat its API and behavior as unsettled and test before relying on it.
- **Content leaves your site to be embedded.** Generating embeddings still calls
  your configured AI provider (cost + data egress); only the resulting vectors are
  stored in Postgres.
- **Respect access.** A vector index is not governed by Drupal's permissions by
  default, so restrict what you index and make sure any search you expose does not
  surface content a viewer shouldn't see.
- **Backups.** Because the vectors live in Postgres, they are covered by your
  normal database backups — convenient, but account for the added size.
