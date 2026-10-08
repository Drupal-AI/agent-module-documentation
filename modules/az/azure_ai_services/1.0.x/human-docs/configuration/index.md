# Configuration

This module's job is to hold the connection to Azure AI / Cognitive Services so other
features can use it. Configuration is therefore a single step: supply the connection
details.

## Supply the Azure endpoint and key

Open the module's settings form as a user with its administration permission and enter
the **endpoint** and **access key** for your Azure AI / Cognitive Services resource.

### Keep the access key out of committed config

The Azure access key is a secret. Do **not** commit it in exported configuration.
Supply it from the environment instead:

1. Store the value as an environment variable. With DDEV:

   ```bash
   ddev dotenv set .ddev/.env --azure-cognitive-key=<your-key>
   ddev restart
   ```

   (The flag `--azure-cognitive-key` becomes the variable `AZURE_COGNITIVE_KEY`.
   Never commit `.ddev/.env`.)

2. Reference that variable from Drupal — through a **Key** entity (the `key` module
   with its *env* provider) or via `getenv('AZURE_COGNITIVE_KEY')` where the module
   reads settings directly.

The endpoint URL is not secret and can stay in ordinary configuration.

## Cost and privacy

Any feature that calls Azure through this module sends its request data to Microsoft's
cloud and incurs Azure usage cost. Keep that in mind for both budgeting and privacy.
