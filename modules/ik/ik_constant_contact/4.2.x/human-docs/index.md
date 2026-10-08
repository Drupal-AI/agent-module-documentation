# Constant Contact Module — manual setup guide

**Constant Contact Module** (`ik_constant_contact`) connects your Drupal site to
the [Constant Contact](https://www.constantcontact.com/) email-marketing platform
using its API v3. Once you have authorized a Constant Contact account, the module
lets you enable specific contact lists and then collect newsletter signups through
several channels: per-list signup blocks, a multi-list block, a Webform handler, an
entity field ("subscribe on save"), and an optional REST endpoint. Every path funnels
the contact through one shared service that creates or updates the person on Constant
Contact.

Authorization uses OAuth2. You provide an app's API key (client ID) and secret —
either in `settings.php` or through the admin form — then click **Authorize** to run
the standard authorization-code flow. The resulting access and refresh tokens are
stored in the database and refreshed automatically before each API call and on cron,
so the connection keeps working without you re-authorizing. The module ships no
secrets of its own; the credentials are always the ones you supply.

The module is deliberately flexible about how you gather signups. A signup block can
show extra fields (name, company, phone, address, birthday, anniversary) and even your
Constant Contact custom fields; the Webform handler maps form elements to Constant
Contact fields with YAML "mergevars"; and the field type subscribes or unsubscribes a
contact whenever a content entity is saved or deleted.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and the optional companion modules for blocks, REST, Webform, and date fields.
2. [Configuration](configuration/index.md) — enter credentials, authorize the account,
   enable lists, and understand token storage and cron.

## Where it lives in the admin menu

The main settings form is at **Configuration → Web services → Constant Contact**
(`/admin/config/services/ik-constant-contact`). It has three tabs: the main config
form, a **Lists** tab where you enable individual contact lists, and a read-only
**Custom Fields** tab that lists your account's custom field IDs. Access is gated by
the **Administer constant contact configuration** permission.

## How to use it

Once an account is authorized and at least one list is enabled, pick whichever signup
channel suits the page:

- **Signup blocks** — place the **Constant Contact Signup Form** block (there is one
  per enabled list, plus a multi-list block) via *Structure → Block layout*. Each
  block's settings let you toggle and require individual contact fields and custom
  fields, and add rich-text body and a success message.
- **Webform handler** — on any webform, add the **Constant Contact** handler under
  *Settings → Emails/Handlers*, choose the target list and email element, and map
  fields with YAML mergevars.
- **Subscribe on save** — add a `constant_contact_lists` field to a content type. With
  "subscribe on save" enabled, saving an entity subscribes the mapped contact and
  deleting it can unsubscribe them.
- **REST endpoint** — with core REST enabled, a decoupled front end can `POST` a signup
  to `/constant_contact/{list_id}` for any enabled list.
