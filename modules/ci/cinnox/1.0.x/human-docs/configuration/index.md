# Configuration

The module does nothing until you tell it which CINNOX account to load. That is a
single, short settings form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → CINNOX → Settings**, or navigate directly to
   `/admin/config/cinnox/settings`.

## Enter your CINNOX widget details

The form stores the CINNOX identifier / script details that link your site to your
CINNOX service account. Obtain these from your CINNOX dashboard (the widget
snippet or ID CINNOX provides for your site), enter them here, and save.

- With a valid identifier saved, the module injects the CINNOX widget script into
  your **public** pages, and the chat/call launcher appears for visitors.
- Clearing the configuration disables the widget again — a quick way to switch it
  off on, say, a staging environment without uninstalling the module.

## Save

Click **Save configuration**. Reload a public page as an anonymous visitor to
confirm the launcher now appears. Because injection is skipped on admin pages, you
will not see it while browsing the administration area.

> **Tip:** if you run separate environments, you can leave the setting empty on
> staging so the live-chat widget only loads in production.
