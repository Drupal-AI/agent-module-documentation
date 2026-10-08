# PWA Add to Home Screen — agent index

Adds one block, `pwa_add_to_home_screen`, with an intro text and an install button that triggers the
browser's "add to home screen" prompt. Depends on `pwa`. No admin settings page.

- **Placing the block and its settings (`button_text`, `intro_text`)** →
  [configure/block.md](configure/block.md)

Key facts:
- Block plugin id: `pwa_add_to_home_screen` (admin label "PWA Add to Home Screen", category "PWA").
- Settings: `button_text` (default `Install app`) and `intro_text` (formatted text). Stored on the
  block config entity (`block.settings.pwa_add_to_home_screen` adds `button_text`).
- Attaches JS library `pwa_a2hs/pwa_a2hs_prompt`; passes `button_text` via `drupalSettings.pwaA2hs`.
- Theme hook: `pwa_add_to_home_screen` (template `pwa-add-to-home-screen.html.twig`).
