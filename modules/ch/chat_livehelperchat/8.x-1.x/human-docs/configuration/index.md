# Configuration

All of this module's settings live on a single form. Open it at
**`/admin/config/chat_livehelperchat/livehelperchatformsettings`**
(route `chat_livehelperchat.live_helper_chat_form_settings`). You need the
**Administer chat_livehelperchat** permission to reach it. Settings are saved to
the `chat_livehelperchat.livehelperchatformsettings` configuration object.

## Choose how the widget is embedded

There are two approaches — pick the one that suits you:

- **Configure visually.** Enter your Live Helper Chat server **domain/URL** and the
  widget's presentation options — **height**, **size**, **subject**, and similar —
  and let the module assemble the embed for you.
- **Paste the generated snippet.** In your LHC server's own admin (System → HTML
  code → Design), generate the chat embed JavaScript, then paste it here. The
  module injects this snippet into the page header. Using this option requires the
  **Use injectjs server config** permission described in
  [Installation](../installation/index.md).

## Visibility rules

The form uses Drupal's standard condition plugins to control **where** the widget
shows. You can combine:

- **By page / path** — restrict the widget to specific paths (or exclude paths).
- **By user role** — show the widget only to selected roles.
- **By content type** — show the widget only on pages of certain content types.

Set these so the chat widget appears only where you want live support offered.

### Advanced: PHP visibility

If the **Use PHP for livehelperchat visibility** permission is granted, an
additional PHP‑snippet visibility option is available for complex rules. Treat this
with great care: the snippet is evaluated with full site privileges, exactly like
core's old PHP filter. Prefer the page/role/content‑type conditions above whenever
they can express what you need, and review any PHP you add.

## Save

Save the form. The widget and its visibility rules take effect immediately — reload
a matching front‑end page to see the chat widget appear.
