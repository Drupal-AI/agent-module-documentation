# ECA: Google — manual setup guide

**ECA: Google** (`eca_google`) integrates Google's APIs with
[ECA](https://www.drupal.org/project/eca) (Event-Condition-Action), Drupal's
no-code automation framework. It adds ECA **actions that call Google services**, so
a model can read and write Google data as part of an automated workflow — or, going
the other way, trigger Drupal actions in response to changes in your Google data.
Across the suite the supported services include Google **Sheets**, **Meet**,
**Calendar**, **Docs**, **Drive**, **Gmail**, and **YouTube**.

Authentication is not handled by this module directly — it relies on the
[Google API PHP Client](https://www.drupal.org/project/google_api_client)
(`google_api_client`) module to hold your Google credentials. This module supports
both **API key** and **service account** methods (note that service accounts often
do not work as expected for user-scoped services such as Meet and Calendar, where
an API key operating under a specific user account is usually required). Because
these actions call out to Google, expect outbound network traffic and make sure
sending the relevant data to Google is acceptable for your site.

The module itself has **no settings form** (you configure the actions inside ECA
models) but it does define **permissions** governing who may use its actions. It
depends on the ECA base module (`eca`) and `google_api_client`, and supports Drupal
10 and 11. The individual services are enabled by installing the matching service
submodules from the suite (for example *ECA: Google Sheets*, *ECA: Google Meet*).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside ECA and Google API PHP Client.

There is **no configuration page for this module** — it has no settings form of its
own. Credentials are configured on the Google API PHP Client module, and the Google
actions are configured inside ECA models. See "Setting up Google authentication"
and "How to use it" below.

## Where it lives in the admin menu

ECA: Google adds no settings page of its own. Google credentials are configured on
the Google API PHP Client module at **Configuration → Web services → Google API
Client**:

- API key authentication: `/admin/config/services/google_api_client`
- Service account authentication: `/admin/config/services/google_api_service_client`

The ECA models that use the Google actions are built in the ECA modeller at
**Configuration → Workflow → ECA** (`/admin/config/workflow/eca`).

## Setting up Google authentication

1. In the **Google Cloud Console**, create a project and enable the APIs you want
   to use (Sheets, Meet, Calendar, and so on).
2. Decide between an **API key** and a **service account**, then create the
   corresponding credentials in the Google Cloud project. For an API key, set the
   redirect URI to `https://YOUR_DOMAIN/google_api_client/callback`.
3. Enter the credentials on your Drupal site via the Google API PHP Client pages
   listed above. Keep the secret values out of version control — store them in an
   environment variable (with DDEV: `ddev dotenv set .ddev/.env
   --google-...=<value>` then `ddev restart`) and, where the credential type
   supports it, reference them through a **Key** entity at **Configuration → System
   → Keys** rather than pasting secrets into the database.
4. For an API key, authenticate it to a specific user account from
   `/admin/config/services/google_api_client` using the *Authenticate* option.

## How to use it

1. Complete authentication above, then install and enable the service submodule(s)
   that match the APIs you enabled (for example *ECA: Google Sheets*).
2. In the ECA modeller at **Configuration → Workflow → ECA**, build a model and add
   the Google actions the submodule provides.
3. Grant the module's permissions to the roles that should be allowed to use these
   actions.
