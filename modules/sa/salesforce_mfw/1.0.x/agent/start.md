<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Salesforce Messaging for Web (salesforce_mfw) — agent index

**A block plugin that embeds the Salesforce Messaging for Web chat utility with configurable pre-chat fields and token support.**

- **Version:** 1.0.x
- **Core:** ^10.2 || ^11 || ^12
- **Depends on:** token
- **Block:** `salesforce_mfw` — org id, config name, site/snippet/bootstrap URLs, language, pre-chat fields; emits `drupalSettings` + `SalesforceMFWConfig` JS event
- **Permission:** `administer salesforce_mfw blocks` (`restrict access: true`)
- **Services:** `RouteSubscriber`, `_salesforce_mfw_access` access check, `SalesforceMfwHooks`

**Security:** Configuration values are public Salesforce embed identifiers, not secrets; no server-side Salesforce API calls and no anonymous submission endpoint (the browser talks to Salesforce directly). Block admin is gated by the restricted `administer salesforce_mfw blocks` permission. Caution: token replacement expands token values into client-visible drupalSettings — don't map sensitive tokens.

See [configure/block.md](configure/block.md)
