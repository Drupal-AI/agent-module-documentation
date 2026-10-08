# Steam Login — manual setup guide

**Steam Login** (`steam_login`) adds "Sign in through Steam" to your Drupal site.
It provides a block with an official Steam sign-in button that sends anonymous
visitors to Steam's OpenID login (protected by Steam Guard), and a callback page
that, when Steam sends the visitor back, creates or logs in a Drupal account keyed
by the visitor's Steam community (Steam64) ID. It is aimed at gaming-community
sites where people already have a Steam account and you would rather not run a
separate registration flow.

As soon as you enable it, two fields are added to the user profile:
`field_steam64id` (the Steam community ID) and `field_steam_username` (the Steam
username). Returning visitors are matched to their existing account through
`field_steam64id`, and users who have a Steam ID have their displayed username set
to their Steam username. A **Steam profile** submodule provides a block you can
place on user pages to show that user's Steam community information. The module
depends on the **Steam API** module, which supplies the Steam Web API key and
looks up the player's display name on login.

Because Steam logins have no email address, setup includes allowing visitors to
register and turning off email verification (see the configuration guide).

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the Composer command (which pulls in
   Steam API) and enabling the modules.
2. [Configuration](configuration/index.md) — the API key, account-registration
   settings, and placing the block.

## How to use it

Once configured, an anonymous visitor clicks the Steam button in the placed block,
authenticates on Steam, and is returned to your site's `/steam-auth` callback,
which creates or logs in their account and sends them to their profile. See
[Configuration](configuration/index.md) for the required setup.
