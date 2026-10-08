# Configuration

Steam Login has no settings form of its own — you configure it through three
existing places in Drupal: the Steam API module's settings, the account
registration settings, and the block layout.

## 1. Set the Steam API key

Steam Login uses the **Steam API** module to look up the player's display name on
login, so you must configure the key there:

- Go to `/admin/config/services/steam_api` and enter your Steam Web API key.

## 2. Allow visitors to register, without email verification

Steam logins carry no email address, so Drupal's normal registration flow has to
be relaxed:

1. Go to **Configuration → People → Account settings**
   (`/admin/config/people/accounts`).
2. Under **Who can register accounts?** choose **Visitors**.
3. **Uncheck** *Require email verification when a visitor creates an account*
   (there is no email to verify).
4. Save.

Without this, the module cannot create accounts for first-time Steam visitors.

## 3. Place the Steam OpenId block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Add the **Steam OpenId** block (`steam_openid`) to a region.
3. In the block's configuration, choose which of the two official Steam sign-in
   button images to display.

For authenticated users, the block shows a logout link and an account link instead
of the sign-in button.

## How login works

- An anonymous visitor clicks the Steam button, hitting `/steam-auth`.
- The controller redirects them to Steam's OpenID login
  (`https://steamcommunity.com/openid/login`), with a return URL back to
  `/steam-auth`.
- Steam returns the visitor to `/steam-auth`. The module reads the Steam64 ID from
  the returned identity, looks up an existing user by `field_steam64id`, creates a
  `steam-<id>` account if none exists, and logs the user in — then sends them to
  their profile.
