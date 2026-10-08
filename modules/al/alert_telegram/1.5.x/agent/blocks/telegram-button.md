<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Telegram Button block — alert_telegram

Block plugin `Plugin\Block\TelegramButtonBlock` (`@Block(id = "telegram_button_block",
admin_label = "Telegram Button")`), implements `ContainerFactoryPluginInterface` and injects `config.factory`.

- `build()` reads `telegram_bot_url` from `alert_telegram.settings` and returns a render array:
  `#theme => 'telegram_button_block'`, `#telegram_bot_url => $telegram_bot_url`, attaching the library
  `alert_telegram/telegram_button_styles`.
- Theme hook registered in `alert_telegram_theme()` (`alert_telegram.module`): `telegram_button_block` with
  variable `telegram_bot_url` (default NULL).
- Template `templates/telegram-button-block.html.twig` renders an `<a href="{{ telegram_bot_url }}"
  target="_blank" rel="noopener noreferrer">` (Twig auto-escapes the URL) wrapping the "Telegram Bot" label
  and an inline SVG chat icon.
- Library `alert_telegram/telegram_button_styles` (`alert_telegram.libraries.yml`) = component CSS
  `css/telegram_button.css` (pulse/animation styling; no JS, no external assets).

## Operate
1. Set `telegram_bot_url` on the settings form (e.g. `https://t.me/YourBot`).
2. Place the **Telegram Button** block in a region via Block layout (core `block` dependency).
3. The block reflects config on every render; no per-block settings form beyond core block defaults.
