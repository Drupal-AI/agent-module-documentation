# API Sync — manual setup guide

**API Sync** (`apisync`) is a framework for integrating Drupal with an external
**REST / OData** API — synchronising entities and records between Drupal and an
outside system in both directions. If you have used the Salesforce integration
suite, the model will feel familiar: you define mappings that describe how Drupal
entities correspond to remote records, then pull data in and push data out along
those mappings.

It is a developer/site-builder integration framework rather than a turnkey feature.
You point it at an API connection and configure the field mappings; the module
handles the pull/push mechanics. This release is an early alpha
(1.0.0-alpha22), so treat it as work in progress and test carefully.

**On credentials and data.** API Sync authenticates to the external API with
credentials — store these as **secrets** (an environment variable feeding a Key
entity, or `getenv()` in settings), never as plain committed config — and always
talk to the remote system over **HTTPS**. The records it exchanges may contain
personal data (PII), so handle them according to your privacy obligations. The
module provides its **own permission** for its configuration; gate the sync setup
behind that permission and grant it only to trusted roles. It has no access-control
role beyond that permission.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Enable the module.
2. Configure the connection to your external REST/OData API. Keep the API
   credentials out of configuration — save the secret into the DDEV environment
   (`ddev dotenv set .ddev/.env --apisync-secret='<value>'`, then `ddev restart`)
   and read it through a **Key** entity or `getenv()`, over HTTPS only.
3. Define the **mappings** that describe how Drupal entities relate to the remote
   records, and set the direction (pull, push, or both).
4. Restrict who can change the sync configuration using the module's own
   permission at **People → Permissions** — grant it to trusted administrators
   only.

Because the records flowing through the sync may include PII, review what you are
synchronising and make sure it is compatible with your data-protection
obligations.
