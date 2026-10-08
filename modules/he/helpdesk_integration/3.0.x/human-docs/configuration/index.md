# Configuration

Configuring Helpdesk Integration has three parts: create one or more integrations
with your helpdesk platforms, decide who may use the helpdesk feature, and expose the
`/helpdesk` page to your users.

## 1. Create an integration

1. Log in as an administrator.
2. Go to **Configuration → Web services → Helpdesk**
   (`/admin/config/services/helpdesk`).
3. Create a new integration and choose its **platform** (GitLab, Zammad, Zendesk, and
   so on — the choices available depend on which platform modules you have enabled).
4. Fill in that platform's connection settings. The exact fields depend on the
   platform and are documented by each platform module — but they generally include
   the service's **base URL** and an **API credential** (token). See, for example,
   the Zammad or GitLab integration module's own configuration guide.

You can create **many** integrations if you work with more than one helpdesk system.

## 2. Handle credentials safely

Each integration needs credentials for its external service. These are secrets:

- Store API tokens in an **environment variable** and, where the platform module
  supports it, reference them through the **Key** module rather than typing them into
  configuration that gets exported. With DDEV:

  ```bash
  ddev dotenv set .ddev/.env --helpdesk-api-token=<token>
  ddev restart
  ```

- Always connect over **HTTPS** so tokens and ticket data are not sent in the clear.
- Remember that synced ticket data can contain **user PII**, so treat the Drupal
  content it creates with appropriate care.

> **Note:** Some platform modules store their API token directly on the integration
> configuration entity as plain text. Where that is the case, restrict who can edit
> helpdesk integrations and be mindful that the token lives in configuration.

## 3. Grant permissions

Helpdesk Integration provides its own permissions that govern who may use the
helpdesk feature. Go to **People → Permissions** (`/admin/people/permissions`) and
grant the appropriate permission to the roles that should be able to use the
`/helpdesk` page and submit issues.

This permission does double duty: **only users who hold it are synchronized** into
the external helpdesk system, so their issues can be associated with the right person
and your agents know who they are talking to.

## 4. Expose the /helpdesk page

The module adds a **`/helpdesk`** route where each permitted user sees their own open
issues, creates new ones, comments, uploads attachments, and marks issues resolved.
To make it easy to reach:

- Optionally set a **path alias** if you want it at a friendlier URL.
- Add a **menu link** (for example in the main or account menu) pointing at
  `/helpdesk`.

## How data flows

Once configured, the helpdesk system remains the source of truth for issues,
comments, attachments, and statuses. Relevant data is synced into Drupal in the
background, on demand, and stored using the content type (with comments and
attachments) that this module provides — so users get a responsive local experience
without every record being copied over.
