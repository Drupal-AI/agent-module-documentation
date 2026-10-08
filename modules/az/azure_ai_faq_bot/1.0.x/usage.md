<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Azure AI FAQ Bot embeds a Microsoft Bot Framework Web Chat widget as a Drupal block and mints the Direct Line access token server-side.

---

Azure AI FAQ Bot connects a Drupal site to a chatbot you build and host on Azure (Language Studio / QnA Maker question-answering, published as a Bot Service with a Direct Line channel). The module itself is thin: it provides one admin settings form where you paste the channel's Direct Line secret, one block that outputs an empty container and attaches the front-end assets, and one controller route that exchanges the stored secret for a short-lived Direct Line token. The included JavaScript behavior fetches that token, then loads the Bot Framework Web Chat library from `cdn.botframework.com` and renders the chat widget bound to your bot. The Direct Line secret never leaves the server — only the minted token reaches the browser — so the visitor's browser talks straight to the Direct Line service for the actual conversation. Store the secret carefully and place the block only where a public chat widget is intended.

---

- Add an Azure-hosted FAQ chatbot to a Drupal page as a block.
- Answer common visitor questions from an Azure QnA / question-answering knowledge base.
- Provide interactive customer-support chat without building a bot backend in Drupal.
- Reuse a bot already published to Azure Bot Service via its Direct Line channel.
- Place the chat widget in any theme region using Drupal's block layout.
- Paste a Direct Line secret once in a settings form and have the site mint tokens automatically.
- Keep the Direct Line secret server-side while exposing only short-lived tokens to browsers.
- Load the Microsoft Bot Framework Web Chat UI from Microsoft's CDN with no local build step.
- Offer a self-service help widget on high-traffic landing or documentation pages.
- Deflect repetitive support tickets by answering FAQs conversationally.
- Give anonymous visitors a chat entry point for common questions.
- Restrict who can change the bot credentials via the `administer azure_ai_faq_bot` permission.
- Configure the bot's knowledge separately in Azure without redeploying Drupal.
- Swap the connected bot by updating a single Direct Line secret value.
- Run on Drupal 10 or Drupal 11 with only core `block` as a module dependency.
- Show a branded conversational assistant sourced from Azure Cognitive Services.
- Prototype an AI FAQ experience quickly on an existing Drupal site.
- Serve multilingual QnA answers where the Azure bot supports multiple languages.
- Centralize FAQ content in Azure while surfacing it inside Drupal.
- Combine with Drupal's block visibility rules to show the widget on selected paths only.
