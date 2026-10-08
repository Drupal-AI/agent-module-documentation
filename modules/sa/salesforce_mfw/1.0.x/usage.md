<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Salesforce Messaging for Web integrates the Salesforce "Messaging for Web" chat utility into Drupal through a configurable block plugin.

---

The `salesforce_mfw` block collects the public Salesforce embed parameters — organization id, config name, site URL, snippet config URL, utility bootstrap URL and language — plus a table of pre-chat fields (each with a name, default value, hidden/visible flag and whether the end user can edit it). Values are pushed to the front end as `drupalSettings`, and the module's JavaScript listens for a `SalesforceMFWConfig` event so integrators can override configuration client-side. Optional token replacement (via the required `token` module) expands tokens in pre-chat default values, and an "allow path override" flag keeps a chat session alive across pages. A route subscriber and a `_salesforce_mfw_access` access check adjust the block administration routes, gated by the `administer salesforce_mfw blocks` permission (marked `restrict access: true`).

Security notes: the configured values are Salesforce embed identifiers intended for client-side use, not secret API keys, and the module has no server-side Salesforce API calls or anonymous submission endpoint — chat submissions go directly from the browser to Salesforce. The one caution is that enabling token replacement on pre-chat default values renders those token values into client-visible `drupalSettings`, so avoid mapping sensitive tokens. Administration is limited to the restricted `administer salesforce_mfw blocks` permission. Typical setup is placing the block, entering the Salesforce Messaging for Web parameters, defining pre-chat fields, and choosing per-page visibility.

---

- Embed a Salesforce Messaging for Web chat widget via a block
- Configure organization id and config name for the utility
- Set the site URL, snippet config and utility bootstrap URLs
- Add visible pre-chat fields with default values
- Add hidden pre-chat fields to pass context to Salesforce
- Mark pre-chat fields as user-editable or fixed
- Enable token replacement in pre-chat default values
- Persist a chat session across pages with path override
- Place different chat configs on different pages
- Restrict chat administration to a dedicated permission
- Set the chat language (e.g. en_US)
- Override chat configuration client-side via the JS event
- Browse available tokens from the block form
- Avoid mapping sensitive tokens into client settings
- Add multiple MFW blocks with distinct configurations
- Ensure only one chat block renders per page
- Pass user or cookie data into pre-chat fields
- Show chat only on selected paths via block visibility
- Provide customer support chat without custom code
- Manage block routes via the module's access check
