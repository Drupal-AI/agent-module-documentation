# Configuration

Configuring Content Workflow (by Bynder) is a matter of connecting your Content
Workflow account, then defining how its items map onto your Drupal content and
running the import. Everything here is gated by the **administer
content_workflow_bynder** permission, so grant that only to trusted
administrators.

## Before you start: get your API credentials

You need a **Content Workflow (by Bynder)** account and its **API credentials**
(an account email/username and an API key/token issued in Content Workflow).
Because the module makes **outbound calls to Bynder's Content Workflow API**,
these credentials are sensitive — handle them like any other secret.

## Store the API credentials securely (do not commit them)

Never hard‑code the API key in settings or commit it to version control. Store it
in an environment variable and reference it from Drupal.

With **DDEV**, save the value into DDEV's dotenv file and restart so the web
container picks it up:

```bash
ddev dotenv set .ddev/.env --content-workflow-api-key=<your-api-key>
ddev restart
```

The flag `--content-workflow-api-key` becomes the environment variable
`CONTENT_WORKFLOW_API_KEY`. Keep **`.ddev/.env` out of version control.**

Where the module (or your workflow) supports a **Key** entity for the credential,
prefer that. Install the Key module if it is not already enabled, confirm the
variable is present in the container **without printing its value**, then create a
Key backed by the environment provider:

```bash
ddev composer require drupal/key
ddev drush en key -y
ddev exec 'test -n "$CONTENT_WORKFLOW_API_KEY"'   # exit status 0 means it is set
ddev drush key:save content_workflow_api_key \
  --label='Content Workflow API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"CONTENT_WORKFLOW_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Then select that Key (or reference the environment variable) in the module's
connection settings rather than typing the raw secret into a form field.

## Connect your account

In the module's admin settings, enter your Content Workflow **account details**
and the **API credential** (the Key or environment‑backed value from above).
Once the connection is authenticated, the module can list the projects and
templates available in your Content Workflow account.

## Map and import content

With the account connected, set up the import:

- **Choose the content** to bring in from your Content Workflow project(s).
- **Choose the target content type** — items can be imported as any node content
  type — and **map** the platform's structured fields onto your Drupal fields,
  including taxonomy, media, and menu/hierarchy where applicable.
- **Decide create vs. overwrite** — create new pages, or update/overwrite
  existing entities.
- For multilingual sites, translations are handled via entity translation.

Because imports run on Drupal's **Migrate** framework, you can also run and
re‑run them from the command line with the Migrate Tools Drush commands, which is
convenient for repeatable or scheduled imports. Updates can flow both ways — from
Content Workflow into Drupal, and from Drupal back to Content Workflow.

## Operational notes

- **Egress:** the module reaches out to Bynder's Content Workflow API. Ensure
  outbound HTTPS to that service is allowed from your environment, and import only
  from **trusted** projects.
- **Least privilege:** keep the **administer content_workflow_bynder** permission
  with trusted administrators, since it controls both the API connection and what
  gets written into your site's content.
