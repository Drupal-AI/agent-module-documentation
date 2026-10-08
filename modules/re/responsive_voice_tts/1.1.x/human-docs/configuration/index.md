# Configuration

Setting up read‑aloud takes two stages: configure the module's settings
(including your API key), then place the block that shows the "Listen to this
content" button.

## Open the settings form

1. Log in as a user with permission to administer the module (an administrator by
   default; the module provides its own permissions, which you can review at
   **People → Permissions**).
2. Go to **Configuration → Web Services → Responsive Voice TTS Settings**.

On this form you set:

- **Content types** — tick the content types (articles, pages, and so on) where
  the "Listen to this content" button should appear.
- **Button text** — the custom label shown on the play button.
- **Voice** — the ResponsiveVoice voice to use (choose a language/accent).
- **ResponsiveVoice API key** — paste the key you obtained from
  <https://app.responsivevoice.org/>.

Save the form.

> **About the API key and data egress.** The key authorizes calls to
> ResponsiveVoice's service, and the content to be spoken is sent to that external
> service for synthesis. This is an egress and consent consideration: review
> ResponsiveVoice's terms and licensing, avoid enabling read‑aloud on content
> that shouldn't leave your site, and consider disclosing the use of the service
> to your visitors. This module stores the key in its own settings; keep it out of
> any public configuration exports you share, and rotate it if it is ever exposed.

## Place the block

1. Go to **Structure → Block layout**.
2. Place the **Responsive Voice TTS** block in the region where you want the
   "Listen to this content" button to appear.
3. Use the block's **Visibility** settings to scope it to the right pages, content
   types, or roles, then save.

## Using it

On pages of the selected content types, visitors will see the play button. They
can click it, or use the keyboard shortcuts — **Shift + P** to play and
**Shift + S** to stop or resume — which also makes the feature friendlier for
visually impaired users.
