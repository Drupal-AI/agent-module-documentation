# Configuration

This module needs two things set up: the AWS credentials and region on its own
settings form, and Amazon selected as a provider in the parent Auto Node Translate
module.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Open the module's settings page from the admin menu — it is registered as the
   `auto_node_translate_amazon.settings` route, under the Auto Node Translate
   configuration area.

The form collects the details the AWS provider needs to talk to Amazon Translate:

- **AWS credentials** — the access key ID and secret access key for an AWS account
  that is allowed to use Amazon Translate.
- **AWS region** — the region whose Amazon Translate endpoint you want to use.
  Choosing a region also matters for data-residency requirements.

Save the form. The settings are stored in the `auto_node_translate_amazon.settings`
configuration object.

## Keep the credentials out of exported config

AWS keys are secrets. Rather than typing them straight into the form (where they
would end up in exported configuration), follow this project's convention and
source them from environment variables:

- Store the keys in environment variables — for example with DDEV:

  ```bash
  ddev dotenv set .ddev/.env --aws-access-key-id=<value> --aws-secret-access-key=<value>
  ddev restart
  ```

- Reference those variables from the module's settings, or override
  `auto_node_translate_amazon.settings` per environment from `settings.php`.

If the form does store the keys directly in config, treat
`auto_node_translate_amazon.settings` as **secret**: exclude it from config
exports, or override it per environment. Verify what is stored with:

```bash
drush cget auto_node_translate_amazon.settings
```

## Select Amazon as the translation provider

The Amazon provider only translates when Auto Node Translate is told to use it.
In the parent module's configuration, choose **Amazon** as the translation
provider (and configure which fields translate and when translation is
triggered). Those settings belong to Auto Node Translate, not to this module — see
that module's documentation for details.

Once Amazon is selected and your credentials and region are set, translating a
node through Auto Node Translate will send the content to Amazon Translate and
save the returned translation.
