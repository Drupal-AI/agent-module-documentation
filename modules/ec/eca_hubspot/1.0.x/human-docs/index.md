# ECA HubSpot — manual setup guide

**ECA HubSpot** (`eca_hubspot`) adds ECA **actions for the HubSpot CRM** to
[ECA](https://www.drupal.org/project/eca) (Event-Condition-Action), Drupal's
no-code automation framework. With it, an ECA model can create, update, retrieve,
delete, and search HubSpot **contacts, companies, deals, leads, tickets, notes, and
tasks** — plus manage **associations** between objects and query **pipelines** —
all as steps inside an automated workflow. For example, when a user registers or
submits a form on your site, a model can create or update the matching contact in
HubSpot automatically.

Authentication is not handled by this module directly — it relies on the
[HubSpot API](https://www.drupal.org/project/hubspot_api) (`hubspot_api`) module to
hold your HubSpot app credentials. You create an app in HubSpot with the scopes
needed for the objects you want to read or write, and configure its API keys on the
HubSpot API module. Because these actions call out to HubSpot, expect outbound
network traffic and confirm that sending the relevant data (which may include
personal data) to HubSpot is acceptable for your site.

The module itself has **no settings form** (you configure the actions inside ECA
models) but it does define **permissions** governing who may use its actions. It
depends on the ECA base module (`eca`) and `hubspot_api`, and supports Drupal 10 and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside ECA and HubSpot API.

There is **no configuration page for this module** — it has no settings form of its
own. Credentials are configured on the HubSpot API module, and the HubSpot actions
are configured inside ECA models. See "Setting up HubSpot authentication" and "How
to use it" below.

## Where it lives in the admin menu

ECA HubSpot adds no settings page of its own. HubSpot app API keys are configured on
the HubSpot API module at **Configuration → Web services → HubSpot API**
(`/admin/config/services/hubspot-api`). The ECA models that use the HubSpot actions
are built in the ECA modeller at **Configuration → Workflow → ECA**
(`/admin/config/workflow/eca`).

## Setting up HubSpot authentication

1. In **HubSpot**, create an app with the scopes required to read and/or write the
   objects you want to work with (contacts, deals, tickets, and so on).
2. Configure the app's API keys on the HubSpot API module at
   `/admin/config/services/hubspot-api`. Keep the secret values out of version
   control — store them in an environment variable (with DDEV: `ddev dotenv set
   .ddev/.env --hubspot-...=<value>` then `ddev restart`) and reference them through
   a **Key** entity at **Configuration → System → Keys** where supported, rather
   than pasting secrets into the database.

## How to use it

1. Complete authentication above so the HubSpot API module can talk to your HubSpot
   account.
2. In the ECA modeller at **Configuration → Workflow → ECA**, build a model and add
   the HubSpot actions (create/update/search a contact, associate objects, and so
   on).
3. Grant the module's permissions to the roles that should be allowed to use these
   actions.
