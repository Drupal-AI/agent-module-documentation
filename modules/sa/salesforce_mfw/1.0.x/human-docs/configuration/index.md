# Configuration

Salesforce Messaging for Web is configured entirely on the block you place — there
is no separate settings page.

## Place the block

Go to **Structure → Block layout** (`/admin/structure/block`), add the
**Salesforce MFW** block to a region, and use the block's visibility settings to
scope it to the pages that should offer chat. Only **one** MFW block should render
on any given page. You need the **Administer salesforce_mfw blocks** permission to
manage these blocks.

## Block settings, field by field

Fill in the values from your Salesforce Messaging for Web setup:

- **Organization ID** and **Config name** — the Salesforce utility identifiers.
- **Site URL**, **Snippet config URL**, **Utility bootstrap URL** — the embed URLs
  Salesforce provides.
- **Language** — the chat language, for example `en_US`.
- **Allow token replacement** — when on, tokens in your pre-chat default values are
  expanded. See the security note below before enabling this.
- **Allow path override** — keeps an active chat session alive as the visitor moves
  between pages.
- **Pre-chat fields** — a table of fields, each with a **name**, a **default
  value**, a **hidden** flag (hidden fields quietly pass context to Salesforce
  rather than showing to the visitor), and an **editable-by-user** flag (whether the
  visitor can change the value before starting the chat).

Save the block to apply the settings.

## Extending the chat with JavaScript

The block exposes its settings to the front end under
`drupalSettings.salesforce_mfw[<blockId>]` and fires a `SalesforceMFWConfig` window
event before the utility boots. A developer can add a `Drupal.behaviors` handler
that listens for that event and overrides field values — for example pulling a value
from a cookie or from local storage — before the chat loads.

## Security note on tokens

The organization ID, config name and URLs above are **public embed identifiers, not
API secrets**, and the module makes no server-side Salesforce calls and exposes no
anonymous submission route. The one caution: if you enable **token replacement**,
each resolved token value is written into the client-visible `drupalSettings`. Do
**not** map tokens that resolve to sensitive data into your pre-chat default values.
