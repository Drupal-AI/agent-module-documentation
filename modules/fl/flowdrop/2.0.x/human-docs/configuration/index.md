# Configuration

FlowDrop's configuration has four parts you should set up deliberately: the
**settings form**, the **permissions**, **secrets** handling for anything a
workflow authenticates to, and the **trusted-publisher** model that governs
importing workflows.

## The settings form

FlowDrop does not declare a `configure` route in its info file, but its settings
form lives at:

> **`/admin/flowdrop/config/flowdrop`** (`FlowDropSettingsForm`)

There you set logging verbosity, whether to log to watchdog, the default
orchestrator, and the icon picker. Runtime secret settings live separately under
the `flowdrop_runtime` submodule (`SecretSettingsForm`).

## Permissions

FlowDrop separates its permissions so that different responsibilities can be held
by different people. Assign them at **People → Permissions**:

| Permission | What it allows |
|-----------|----------------|
| **administer flowdrop** *(restricted)* | Full administration of FlowDrop. |
| **administer flowdrop configuration** | Manage FlowDrop configuration. |
| **administer flowdrop trusted publishers** *(restricted)* | Decide which publishers are trusted for importing signed workflow bundles. |

The restricted permissions are marked as security-sensitive — grant them only to
highly trusted roles. In particular, **who may grant trust to a publisher** is a
different, weightier decision than who may build workflows, which is exactly why it
is a separate permission.

## Secrets — keep credentials out of config

Workflows call AI models and external APIs, which means credentials. **Do not** put
API keys into node configuration or workflow config (which exports to YAML and
lands in git). Instead store each secret as an environment variable and reference
it through a **Key** entity, and use FlowDrop's runtime secret settings.

On a DDEV site:

```bash
ddev dotenv set .ddev/.env --openai-api-key=YOUR_KEY   # never commit .ddev/.env
ddev restart
ddev composer require drupal/key
ddev drush en key -y
ddev exec 'test -n "$OPENAI_API_KEY"'   # exit status 0 means it is set
ddev drush key:save openai_api_key --label='OpenAI API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"OPENAI_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Then reference the Key from your workflow nodes rather than pasting the raw value.

## Importing workflows — the trusted-publisher model

Workflows can be exported as **bundles** and imported. Because an imported workflow
can call models, make HTTP requests, and touch your content, importing one is a
supply-chain decision. FlowDrop handles it as follows:

1. A publisher is represented by a **`FlowDropTrustedPublisher`** entity holding its
   publisher key.
2. Signed bundles are **verified against that key before import**.
3. Trusting a publisher is an explicit action, gated behind the restricted
   **administer flowdrop trusted publishers** permission. As the permission's own
   description puts it: *"Granting trust to a publisher allows its signed bundles to
   be imported."*

Only trust publishers you actually control or have vetted, and keep the trusted
list small.

## Cost and egress

Every AI-model node and HTTP node makes an **outbound** call that may cost money and
sends data off your site. Review what each workflow reaches out to, cache or rate
where sensible, and keep an eye on model/API spend.

## Building workflows

With settings, permissions, and secrets in place, build automations in the visual
editor: drag typed nodes onto the canvas, connect their ports, and run them. Export
finished workflows with `drush cex` to version them in git and deploy across
environments.
