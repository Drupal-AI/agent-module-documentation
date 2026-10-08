# Apigee Edge — manual setup guide

**Apigee Edge** (`apigee_edge`) integrates Drupal with **Apigee** (Edge or X),
Google's API-management platform, turning your Drupal site into an **API developer
portal**. Developers register, create apps, receive API keys, and subscribe to API
products — Drupal is the front-end portal, Apigee is the backend that actually
manages the APIs, developers, apps and products.

An API program needs a place where developers sign up, read documentation, create
an application, receive credentials and manage their usage. This module makes
Drupal that place: it synchronises Drupal users with Apigee developers and exposes
app and key management as Drupal entities and forms. It is the official building
block for running an Apigee-backed developer portal on Drupal.

It requires a real **Apigee organization** to connect to — without an Apigee
backend it has nothing to integrate. The connection is authenticated with
credentials, and this module handles them correctly: it depends on the **Key**
module and stores the Apigee auth secret in a **Key entity** rather than in plain
configuration. Keep it that way — see the configuration page for how to feed the
secret in from an environment variable.

This is a substantial integration with a real security surface. The permission to
watch is **`bypass api product access control`**: API products gate which
developers may consume which APIs, and this permission overrides that gate, so it
belongs only to trusted administrators. The general admin permission is
**`administer apigee edge`**.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it needs the Key
   module), enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — connect to your Apigee organization,
   store the auth credentials safely via a Key, and set the permissions.

## Where it lives in the admin menu

After enabling, the Apigee connection and portal settings live under
**Configuration** in the Apigee section, and the permissions are set at
**People → Permissions** (`/admin/people/permissions`). See
[Configuration](configuration/index.md) for the connection walk-through.
