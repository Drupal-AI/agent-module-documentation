<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EngageBay Module integrates the EngageBay CRM and embeds EngageBay forms and landing pages through CKEditor.

---

EngageBay Module connects a Drupal site to the EngageBay CRM/marketing platform. An admin logs in with EngageBay credentials, the module stores the returned domain and REST/JS API keys, and editors can then embed EngageBay forms and landing pages into content through two CKEditor plugins.

The configuration flow (`/engagebay/configure`, `access administrator pages`) posts the username/password to EngageBay's login endpoint via the `EngageBayAPI` service (Guzzle over HTTPS, default TLS verification), then stores `domain`, `email`, `rest_api_key` and `js_api_key` in `engagebay.settings`. The CKEditor dialogs (`/engagebay/dialog/form/{filter_format}` and `/engagebay/dialog/landingpage/{filter_format}`, gated by `_entity_access: filter_format.use`) list the account's forms/landing pages so an editor can insert a placeholder token; `hook` processing in the `.module` later replaces `{engagebayform_id}…{/engagebayform_id}` markers in node bodies by fetching the form/landing-page HTML from EngageBay's hosted URLs.

Setup: enable, connect the account, add the CKEditor buttons to a text format, then embed. The embed processing does a server-side `file_get_contents` against fixed EngageBay hosts.

---
- Connect a Drupal site to an EngageBay account.
- Store EngageBay REST and JS API keys.
- Embed an EngageBay form into node content.
- Embed an EngageBay landing page into content.
- Add EngageBay buttons to a CKEditor toolbar.
- List available EngageBay forms in a dialog.
- List available EngageBay landing pages in a dialog.
- Insert a form placeholder token via CKEditor.
- Render embedded forms by replacing body placeholders.
- Fetch hosted landing-page HTML for display.
- Re-authenticate as a different EngageBay user.
- Capture leads through embedded CRM forms.
- Drive marketing campaigns from Drupal content.
- Restrict embedding to formats a user may use.
- Configure the account domain used for hosted pages.
- Surface EngageBay content without leaving the editor.
- Provide a home/settings landing page for the integration.
- Log EngageBay API errors to the engagebay channel.