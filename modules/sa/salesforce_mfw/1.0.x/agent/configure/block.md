<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Salesforce MFW block

## Placing the block
Place the `Salesforce MFW` block (`salesforce_mfw` plugin) via Block Layout and
scope it to the pages that should show chat. Only one MFW block should render on
any given page.

## Block settings
- `organization_id`, `config_name` — Salesforce utility identifiers.
- `site_url`, `snippet_config`, `utility_bootstrap` — Salesforce embed URLs.
- `language` — e.g. `en_US`.
- `allow_token_replacement` — expand tokens in pre-chat default values.
- `allow_path_override` — keep an active chat across pages.
- `prechat_fields` — table of `{name, default_value, hidden, editable_by_user}`.

## Client-side extension
The block exposes settings under `drupalSettings.salesforce_mfw[<blockId>]` and
fires a `SalesforceMFWConfig` window event; a custom `Drupal.behaviors` handler
can override field values from cookies/local storage before the utility boots.

## Security
The parameters above are public embed identifiers, not API secrets. There is no
server-side Salesforce call and no anonymous submission route. Do **not** enable
token replacement for tokens that resolve to sensitive data, since resolved
values are serialized into client-visible drupalSettings.
