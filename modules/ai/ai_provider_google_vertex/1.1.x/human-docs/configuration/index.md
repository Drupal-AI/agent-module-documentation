# Configuration

Unlike the simple API-key providers, Google Vertex authenticates with a Google
Cloud **service-account credential** and needs to know which **project** and
**region** to run against. Configuration has three parts.

## Step 1 — Prepare Google Cloud

1. In the Google Cloud console, select (or create) a **project** and note its
   **project ID**.
2. Enable the **Vertex AI API** for that project.
3. Create a **service account** with permission to use Vertex AI, and create and
   download a **JSON key** for it.
4. Decide the **region / location** you will use (for example `us-central1` or
   `europe-west4`), matching where your models are available.

## Step 2 — Store the service-account JSON as a Key

The service-account JSON is a sensitive credential — never paste it into plaintext
configuration. On this project the convention is to hold secrets in an environment
variable and reference them through a **Key** entity.

1. Save the JSON into DDEV's dotenv file (as a single-line value):

   ```bash
   ddev dotenv set .ddev/.env --vertex-credentials='<json contents>'
   ddev restart
   ```

   The flag `--vertex-credentials` becomes the environment variable
   `VERTEX_CREDENTIALS` inside the web container.

2. Create a Key entity that reads that variable at **Configuration → System →
   Keys** (`/admin/config/system/keys`) → **Add key**, using the **Environment**
   key provider pointing at `VERTEX_CREDENTIALS`. (Depending on how the settings
   form expects the credential, you may instead select a file-based Key — follow
   the field labels on the form.)

## Step 3 — Configure the Vertex provider

1. Open the Vertex provider settings form, reached from **Configuration → AI**
   (`/admin/config/ai`) under the provider settings (route
   `ai_provider_google_vertex.settings_form`).
2. Select the **Key** holding your service-account credential.
3. Enter your Google Cloud **project ID** and **region / location**.
4. Save.

## Step 4 — Choose Vertex for AI operations

Open the AI module's default-provider settings under **Configuration → AI**
(`/admin/config/ai/settings`) and select **Google Vertex** as the provider for the
operation types you want it to serve (for example chat and embeddings).

## A note on cost and data

Vertex usage is billed to your Google Cloud account — set budgets and alerts
there. Prompts sent to Vertex leave your site to Google; treat unpublished or
personal data accordingly, and pick a region consistent with any data-residency
requirements.
