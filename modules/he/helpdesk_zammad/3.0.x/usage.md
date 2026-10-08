<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Zammad for Helpdesk Integration adds a Zammad backend to the Helpdesk Integration framework, syncing Drupal issues and comments to Zammad tickets and optionally embedding the Zammad chat widget.
---
The module provides a `zammad` HelpdeskPlugin whose configuration form (surfaced by the parent `helpdesk_integration` helpdesk entity) collects a Zammad instance **URL**, an **API token**, a default group, the closed-ticket state, and chat-widget options (id, label, font size, auto-show, debug). It talks to Zammad through the `zammad_api_client` PHP library via a small `ZammadClientFactory` service (`helpdesk_zammad.client_factory`) that builds a `ZammadAPIClient\Client` from the URL + `http_token`. Core operations map Drupal ↔ Zammad: `createIssue` opens a ticket on behalf of the issue owner, `addCommentToIssue` appends a ticket article, `resolveIssue` sets the closed state, `pushUser` upserts the remote Zammad user, and `getAllIssues` pulls tickets (optionally since a date) with their articles and attachments back into `helpdesk_integration` Issue entities. A `Service` helper lists active Zammad instances and finds the one enabled for chat.

Setup: enable `helpdesk_integration` and this module, then create/configure a helpdesk instance of type *Zammad*, entering the Zammad URL and API token. If a chat id is set, `hook_page_bottom` + `hook_library_info_alter` inject the Zammad chat JS (loaded from `<zammad-url>/assets/chat/chat.min.js`) and pass settings via `drupalSettings`. Security/operational notes: this module ships **no routes, permissions or forms of its own** — all UI comes from `helpdesk_integration`, and ticket creation is a server-side action triggered by that framework (no anonymous ticket-create endpoint here). The **API token is stored as plaintext** on the helpdesk config entity (a `textfield`, not a password field and not a Key-module reference), so treat that config as sensitive. TLS is not disabled anywhere — the client is constructed with only `url` + `http_token`, leaving certificate verification to the underlying HTTP client (no `verify => false`). The chat widget script URL is derived from the configured, admin-set instance URL.
---
- Enable `helpdesk_integration` then this module.
- Create a helpdesk instance of type *Zammad*.
- Enter the Zammad base URL and API token in the instance config form.
- Set the default Zammad group new tickets are filed under.
- Choose which Zammad state represents a closed ticket.
- Push a Drupal helpdesk issue to Zammad as a ticket (`createIssue`).
- Append Drupal comments to the matching Zammad ticket article (`addCommentToIssue`).
- Resolve/close a ticket by setting its closed state (`resolveIssue`).
- Upsert the Zammad customer/user record from a Drupal user (`pushUser`).
- Pull all Zammad tickets (with articles + attachments) into Drupal Issues (`getAllIssues`).
- Fetch only tickets updated since a date for incremental sync.
- Enable the embedded Zammad chat widget by setting a chat id.
- Customise chat label, font size, auto-show and debug mode.
- List active Zammad instances programmatically via the `helpdesk_zammad.service`.
- Locate the chat-enabled Zammad instance via `getZammadChatInstance()`.
- Map remote Zammad users back to Drupal users (falls back to user 1).
- Operate multiple Zammad instances, each its own helpdesk entity.
