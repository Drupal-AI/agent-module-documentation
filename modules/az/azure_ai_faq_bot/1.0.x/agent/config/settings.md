<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings — Direct Line secret

## Install / enable

```bash
composer require drupal/azure_ai_faq_bot
drush en azure_ai_faq_bot
```

Requires core `block` (declared dependency). Core `^10 || ^11`. No other modules, no libraries to
install locally — the Web Chat JS is pulled from Microsoft's CDN at runtime.

## Prerequisite (Azure side, not this module)

Build a question-answering bot in Azure (Language Studio / QnA Maker), publish it to **Azure Bot
Service**, enable the **Direct Line** channel, and copy one of its **secret keys**. This module only
consumes that Direct Line secret; it creates none of the AI resources.

## The settings form

- Class: `Form\AzureAIFAQBotForm` (`final`, extends `ConfigFormBase`), form id
  `azure_ai_faq_bot_config_form`.
- Route: `azure_ai_faq_bot.azure_ai_faq_bot_config_form` →
  **`/admin/config/services/azure-ai-faq-bot`**, permission **`administer azure_ai_faq_bot`**.
- Menu link (`azure_ai_faq_bot.links.menu.yml`): *Azure AI FAQ Bot* under
  `system.admin_config_services` (Configuration → Web services), weight 10.
- One field: `direct_line_secret` — `#type => 'textfield'`, `#required => TRUE`,
  default-valued from `config('azure_ai_faq_bot.settings')->get('direct_line_secret')`.
  `submitForm()` saves it into `azure_ai_faq_bot.settings:direct_line_secret`.
- `getEditableConfigNames()` → `['azure_ai_faq_bot.settings']`.

## Config object + schema

Config object **`azure_ai_faq_bot.settings`** (no `config/install/` default file is shipped — the
object is created on first save). Schema (`config/schema/azure_ai_faq_bot.schema.yml`):

```yaml
azure_ai_faq_bot.settings:
  type: config_object
  label: 'Azure AI FAQ Chatbot settings'
  mapping:
    direct_line_secret:
      type: string
      label: 'Direct Line Secret'
```

Set it non-interactively:

```bash
drush config:set azure_ai_faq_bot.settings direct_line_secret '<your-direct-line-secret>' -y
```

## Permission

`administer azure_ai_faq_bot` (`azure_ai_faq_bot.permissions.yml`): title *Administer Azure AI FAQ
Bot configuration*, `restrict access: true` (trusted-operator permission). Gates only the settings
form — not the token route (see [../api/token-and-widget.md](../api/token-and-widget.md)).

## Gotchas

- **Broken `configure` link / wrong README path.** `azure_ai_faq_bot.info.yml` sets
  `configure: azure_ai_faq_bot.settings`, but the route is actually
  `azure_ai_faq_bot.azure_ai_faq_bot_config_form`, so the "Configure" link on the Extend page does
  not resolve. The README's `/admin/config/azure-ai-faq-bot/settings` is likewise wrong. Use
  **`/admin/config/services/azure-ai-faq-bot`**.
- The secret is stored as a plain config string and shown in a plain `textfield` (not a password
  field); it is included in config export. Treat `azure_ai_faq_bot.settings` as sensitive and keep
  it out of shared config unless intended.

## After configuring

Place the **Azure AI FAQ Bot** block (`azure_ai_faq_bot_block`) in a region via *Block layout*. It
renders the widget container and attaches the JS that fetches a token and boots Web Chat.
