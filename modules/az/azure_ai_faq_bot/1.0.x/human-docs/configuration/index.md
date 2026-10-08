# Configuration

Getting the bot working is two steps: give it your Azure credentials, then place the
chat block on your site.

## 1. Connect to Azure Cognitive Services

The module authenticates to Azure with an **endpoint** and an **access key** from
your Cognitive Services resource. Open the module's settings form (as a user with the
`administer azure_ai_faq_bot` permission) and enter the connection details for your
Azure language/QnA service.

### Keep the access key out of committed config

An Azure Cognitive Services key is a secret. Do **not** paste it into configuration
that gets exported and committed to version control. Supply it from the environment
instead:

1. Store the value as an environment variable. With DDEV:

   ```bash
   ddev dotenv set .ddev/.env --azure-cognitive-key=<your-key>
   ddev restart
   ```

   (The flag `--azure-cognitive-key` becomes the variable `AZURE_COGNITIVE_KEY`.
   Never commit `.ddev/.env`.)

2. Reference that variable from Drupal — either through a **Key** entity (install the
   `key` module and create a key backed by the *env* provider) or, where the module
   reads settings directly, via `getenv('AZURE_COGNITIVE_KEY')` in `settings.php`.

The endpoint URL itself is not secret and can live in normal configuration.

## 2. Place the chat block

Go to **Structure → Block layout** (`/admin/structure/block`), find the FAQ bot block
provided by this module, and place it in the region where you want the chat widget to
appear (for example a sidebar or a dedicated support page). Configure the block's
visibility so it only shows on the pages where you want visitors to reach the bot.

## Cost and privacy

Every question a visitor types is sent to Azure to be answered. That incurs Azure
usage cost and means visitor‑entered text is transmitted to Microsoft's cloud —
account for both in your budgeting and your privacy notice.
