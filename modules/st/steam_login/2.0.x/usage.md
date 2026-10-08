<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds "Sign in through Steam": a block and callback that send anonymous visitors to Steam's OpenID endpoint and, on return, create or log in a Drupal account identified by the visitor's Steam community (Steam64) ID.

---

On enable the module adds two user fields — `field_steam64id` (the Steam community ID) and `field_steam_username` — and provides a *Steam OpenId* block showing one of two official Steam sign-in button images. Clicking it hits `/steam-auth` (route `steam_login.openid`, gated `access content`), whose controller redirects the user to `https://steamcommunity.com/openid/login` in `checkid_setup` mode with a `return_to` back to `/steam-auth`. When Steam returns with `openid.mode=id_res`, the controller extracts the Steam64 ID from the `openid_identity` query value (validated against a `steamcommunity.com/openid/id/<id>` regex), looks up an existing user by `field_steam64id`, creates one named `steam-<id>` if none exists (with an empty password and no email), and calls `user_login_finalize()`. Users with a Steam ID have their displayed username set to their Steam username. It depends on the `steam_api` module for the Steam API key (configured at `steam_api.settings`) and player-summary lookups.

Operational setup: configure the Steam API key, set account registration to allow visitors and disable email verification (Steam logins have no email), then place the Steam OpenId block.

---
- Add a "Sign in through Steam" button block to the site
- Let gamers log in with their existing Steam account
- Auto-create a Drupal account on first Steam login, keyed by Steam64 ID
- Link returning visitors to their existing account via `field_steam64id`
- Store each user's Steam community ID in `field_steam64id`
- Store each user's Steam username in `field_steam_username`
- Show the user's Steam username as their display name
- Choose between the two official Steam sign-in button images
- Configure the Steam API key through the `steam_api` module
- Set account registration to "Visitors" and disable email verification
- Place the Steam OpenId block in a region via the block layout
- Provide a one-click login for a gaming community site
- Show a logout link + account link to authenticated users in the block
- Fetch player summaries (persona name) from the Steam API on login
- Redirect the user to their profile page after connecting
- Pair with steam_api for broader Steam Web API access
