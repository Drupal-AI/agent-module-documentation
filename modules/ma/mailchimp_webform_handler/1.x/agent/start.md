<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mailchimp webform handler (mailchimp_webform_handler) — agent index

Webform **handler plugin** that, on submission, adds the submitter to a Mailchimp list/audience via
the Mailchimp Marketing REST API. Version dir **1.x** (installed **1.0.9**), package *Webform*.

## What it provides
- One `@WebformHandler` plugin, id **`mailchimp_webform_handler`**, class
  `src/Plugin/WebformHandler/MailchimpWebformHandler.php` (extends `WebformHandlerBase`), category
  *Transaction*, cardinality **unlimited**.
- No routes, permissions, services, hooks, config schema, install config, submodules or Drush.

## Dependencies
- Drupal **`webform`** module (`^6.2`).
- Composer library **`mailchimp/marketing`** (`^3.0`) — the `MailchimpMarketing\ApiClient` SDK.
- Core `^10 || ^11`.

## How it works (one file)
- Handler config keys (`defaultConfiguration()`): `api_key`, `server_prefix`, `list_id`, `email`,
  plus one key per selected Mailchimp merge-field tag. Stored in the **webform config entity** as
  handler settings.
- `buildConfigurationForm()`: API-key + server-prefix inputs, an *Update Mailchimp lists* AJAX
  button, a list `<select>` filled by `getLists()` (`lists->getAllLists()`), and a mapping of
  webform elements onto `EMAIL` + merge fields from `getMergeFields()` (`lists->getListMergeFields()`).
- `submitForm()`: builds `['email_address','status'=>'subscribed','merge_fields'=>…]` and calls
  `client->lists->addListMember($list_id, $data)`.

## Solution docs
- [Configure & operate the handler](plugins/webform_handler.md) — install, settings form, field
  mapping, submission call, and known behaviour/limitations.
