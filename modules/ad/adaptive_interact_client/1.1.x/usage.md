<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Embeds the Adaptive Interact conversational AI search/chat widget on a Drupal site through a placeable block, a render element and an admin-configured server URL.

---

Interact client (adaptive_interact_client) is the Drupal-side integration for the hosted Adaptive Interact conversational AI / search platform. It does not run any AI itself: it renders a `<div class="adaptive-interact-widget">` container and attaches an external JavaScript "widget loader" pulled from the configured Interact server (default `https://interact.adaptive.co.uk`), which then boots the chat/search widget in the visitor's browser. Site builders point the module at their Interact server and a default widget ID on one settings form, then expose the widget by placing the "Interact Chat Block", by using the `adaptive_interact_client__widget` render element in code, or by hand-writing the container div in a Twig template. Per-placement options (widget ID, initial prompts, button type/text, modal vs. inline display) are passed to the browser widget as a JSON `data-aiw` attribute. Optionally the module can look up an image field on the user entity and send the current user's avatar URL to the widget. The module has no external Drupal-module dependencies and ships no config schema, permissions, or Drush commands.

---

- Add an AI-powered conversational search bar to a Drupal site backed by the hosted Adaptive Interact platform.
- Place the "Interact Chat Block" (category *Adaptive Interact*) via Block Layout to show the chat widget in any region.
- Configure the Interact server URL and a default widget ID once at Configuration → System → Adaptive Interact Settings.
- Offer FAQ / knowledge-base answering drawn from your own content via the Interact widget.
- Launch the assistant as a modal dialog, or embed it inline within page content, per block placement.
- Show a launch button as an icon, text, or icon-and-text, with custom button text.
- Seed a conversation with one or more preset prompts shown as clickable bubbles when the chat opens.
- Override the user-input prompt placeholder text for a specific placement.
- Pass the signed-in user's avatar image to the widget by selecting a user image field in settings.
- Embed the widget programmatically from custom module code using the `#type => 'adaptive_interact_client__widget'` render element.
- Hand-place the widget in any theme template with `attach_library('adaptive_interact_client/widget')` plus a container div.
- Run different widgets on different pages by overriding the widget ID per block instance.
- Provide an accessible, keyboard-focusable ("Ask a question") search entry point with an ARIA live-region announcer.
- Override the `adaptive-interact-client--widget.html.twig` template in a theme to customize widget markup.
- Deliver course finders, onboarding assistants, or digital help agents sourced from Drupal content.
- Support voice/typed natural-language questions handled by the remote Interact service.
- Keep the Drupal footprint minimal — one block, one settings form, one render element, no content entities.
- Invalidate the cached widget-loader URL automatically when the server URL setting changes (hourly cache-buster).
- Run on Drupal 10, 11, or 12 without additional contrib modules.
