# MJML preview — manual setup guide

**MJML preview** (`mjml_preview`) lets you preview the MJML rendering of a node.
MJML is an email markup language that compiles to responsive HTML email; this
module takes a node rendered through an **`mjml` view mode**, sends that MJML to the
MJML rendering service, and shows you the resulting HTML email — so editors can see
how the email version of a node will look before it is sent. It can also download
the raw MJML template for a node.

Concretely, once set up you get two new tabs — **Preview MJML** and **Download
MJML** — on each node. It does *not* send email itself (for that, see the separate
MJML module); it is purely a preview/download tool.

There are two setup pieces beyond enabling the module. First, MJML preview calls an
external MJML rendering service, so you need an **MJML API key**, which the module
reads through a **Key** entity (so the secret is stored securely, not in
configuration). Second, MJML is not HTML — to produce a preview you must create an
`mjml` view mode for the relevant bundle and provide a Twig template for that view
mode in your theme that outputs MJML markup. It depends on core's **Node** module
and the contributed **Key** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install MJML preview and the Key module
   with Composer, and enable them.

There is no complex settings screen documented for this version; the small amount
of setup — API credentials plus the `mjml` view mode — is covered below.

## Where it lives in the admin menu

After enabling, the module's API-credentials screen is at **Configuration →
Web services → MJML preview** (`/admin/config/services/mjml_preview`).

## How to use it

1. **Get an MJML API key.** Request API credentials from the MJML service.
2. **Store the key securely.** Because credentials are secrets, keep the key out of
   version control. With DDEV, save it as an environment variable and expose it
   through a Key entity:

   ```bash
   ddev dotenv set .ddev/.env --mjml-api-key=<your-key>
   ddev restart
   ```

   Then create a Key that reads the environment variable (install the Key module
   first if it isn't enabled):

   ```bash
   ddev drush key:save mjml_api_key --label='MJML API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"MJML_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

3. **Point the module at the key.** Go to **`/admin/config/services/mjml_preview`**
   and set your MJML API credentials, selecting the Key you created.
4. **Create an `mjml` view mode.** Under **Structure → Display modes → View modes**,
   add an `mjml` view mode, enable it for your content type's display, and add a
   Twig template for that view mode in your theme whose output is **MJML markup**
   (not HTML).
5. **Preview.** Open a node of that bundle — you'll see **Preview MJML** and
   **Download MJML** tabs. Preview renders the MJML to responsive HTML email;
   download gives you the raw MJML template.
