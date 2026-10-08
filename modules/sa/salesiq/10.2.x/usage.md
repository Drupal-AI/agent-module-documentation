<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Zoho SalesIQ adds the Zoho SalesIQ live-chat and visitor-tracking widget to your site by injecting the snippet you paste from your Zoho account into every (or non-admin) page.

---

The module (machine name `zohosalesiq`; project/on-disk name `salesiq`) stores a widget-code snippet in `zohosalesiq.settings`, editable at `/admin/config/services/zohosalesiq` under the `administer zohosalesiq` permission. `hook_page_attachments()` validates the snippet against a regex, rewrites the widget URL to add `plugin_source=drupal`, and outputs it as an inline `<script>` in the head. It can optionally hide the chat float button (tracking-only mode) and can be limited to view pages only (excluding admin/node-edit routes). For logged-in users it also emits an inline script calling `$zoho.salesiq.visitor.name(...)` / `.email(...)` with the current user's own display name and email. The widget code is only settable by a trusted `administer zohosalesiq` admin, and the prefilled visitor name/email belong to the viewing user themselves. No server-side HTTP calls are made from PHP.

---

- Add live chat to the site via the Zoho SalesIQ widget.
- Track visitors with Zoho SalesIQ analytics.
- Prefill the chat with a logged-in user's name and email.
- Run in tracking-only mode by hiding the chat float button.
- Limit the widget to front-end view pages, excluding admin.
- Paste the Zoho-provided snippet into a single admin field.
- Tag traffic with `plugin_source=drupal` automatically.
- Restrict widget configuration to the `administer zohosalesiq` permission.
- Skip the widget during installation and on node-edit pages.
- Provide support chat across all public pages.
- Enable or disable the chat widget from one setting.
- Keep the embed code in exportable configuration.
- Offer proactive chat to anonymous visitors.
- Integrate a SaaS chat tool without custom theming.
- Show the widget site-wide with a single module.
