# ECA External Workflows — manual setup guide

**ECA External Workflows** (`eca_external_workflows`) lets your Drupal site trigger
automated workflows on **external platforms** — Pipedream, n8n, Zapier, and
Make.com — directly from
[ECA](https://www.drupal.org/project/eca) (Event-Condition-Action) models. When
content is created, a user registers, or any Drupal event fires, an ECA model can
call out to one of these services (via its webhook/API) and kick off an automation
sequence there. Typical uses: sending user registrations to a CRM, triggering an
email campaign when content is published, or syncing content to an external API.

It works by adding an **"Execute External Workflow"** action to your ECA palette.
You pick a provider, point it at a webhook URL, and use ECA tokens to build the
payload of Drupal data to send; the action can also return a response token so a
later step in the model can react to what the external service sent back. This is a
minimal initial implementation — a complete **Pipedream** provider is included, and
provider support is community-extensible.

Two things to weigh before using it. First, it **sends data — event and entity
payloads — to external services** (egress); those payloads can include site data
and PII, so confirm that is acceptable and always send over HTTPS. Second, it
authenticates using credentials/webhook secrets stored via the **Key** module,
which is the right way to keep secrets out of exported configuration. The module has
no access-control role of its own. Note this is an early alpha whose maintenance
status is currently listed as **unsupported/obsolete**, so evaluate it carefully.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside ECA and the Key module.

There is **no standalone module settings form** documented for this module. You set
up authentication using the Key module and configure the provider, webhook URL, and
payload inside the ECA action itself — described in "Setting up credentials" and
"How to use it" below.

## Where it lives in the admin menu

You build models in the ECA modeller at **Configuration → Workflow → ECA**
(`/admin/config/workflow/eca`). The module's provider authentication is managed
under **Configuration → Workflow → ECA → External Workflows**, and the secrets
themselves are stored as Key entities under **Configuration → System → Keys**
(`/admin/config/system/keys`).

## Setting up credentials

Never paste a webhook secret or API token directly into configuration. Instead:

1. Store the secret in an environment variable rather than in the database or a
   committed file. With DDEV: `ddev dotenv set .ddev/.env
   --external-workflow-secret=<value>` (keep `.ddev/.env` out of version control),
   then `ddev restart`.
2. Install the **Key** module if it is not already enabled, then create a Key
   entity that reads from that environment variable (Key's built-in *env* provider),
   at **Configuration → System → Keys**.
3. Reference that Key when you configure the provider's authentication under
   **Configuration → Workflow → ECA → External Workflows**.

Because payloads leave your site, make sure outbound HTTPS egress to the provider
is permitted and that sending the data (including any PII) is acceptable for your
site's policies.

## How to use it

1. Enable the provider you need (for example the included Pipedream provider).
2. In the ECA modeller at **Configuration → Workflow → ECA**, build a model that
   listens for the Drupal event you care about.
3. Add the **Execute External Workflow** action, choose the provider, set the
   webhook URL, and build the payload from ECA tokens.
4. Optionally capture the response token and continue the model based on what the
   external service returns.
