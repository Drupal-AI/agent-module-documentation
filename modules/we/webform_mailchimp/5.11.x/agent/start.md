<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform MailChimp — agent index

Adds **one Webform handler** (`mailchimp`) that subscribes webform submitters to a Mailchimp
audience. No settings page (`configure: null`), no permissions, no Drush. Depends on
`webform` and `mailchimp` (the Mailchimp module holds the API key + audience/merge metadata).

- **The handler and its settings (list, email, merge fields, interest groups, control)** →
  [configure/handler.md](configure/handler.md)
- **Altering merge vars in code** (`hook_webform_mailchimp_lists_mergevars_alter`) →
  [hooks/mergevars.md](hooks/mergevars.md)

Quick reference:
- Handler plugin id `mailchimp` (`WebformMailChimpHandler`), `CARDINALITY_UNLIMITED`,
  `RESULTS_PROCESSED`. Add via *Webform → Settings → Handlers → Add handler → MailChimp*.
- Handler settings (schema `webform.handler.mailchimp`, `defaultConfiguration()`):
  `list` (audience id), `email` (webform email element), `double_optin` (bool, default TRUE),
  `mergevars` (YAML map), `interest_groups` (category → group ids), `control` (gate field).
- Subscription happens in `postSave()` via the Mailchimp module. Configure the API key in the
  Mailchimp module first.
- Stored inside the host webform config: `webform.webform.<id>` → `handlers.<key>`.
