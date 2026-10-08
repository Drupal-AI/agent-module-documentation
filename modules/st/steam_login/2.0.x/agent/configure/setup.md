<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Steam Login — setup

## Enable
Depends on `steam_api`. `composer require drupal/steam_login` then enable both. Two user fields are added automatically: `field_steam64id`, `field_steam_username`.

## Required configuration
1. **Steam API key** — set it at `steam_api.settings` (the help text links there). Needed for player-summary lookups.
2. **Account settings** (`/admin/config/people/accounts`) — under "Who can register accounts?" choose **Visitors**, and **uncheck** "Require email verification when a visitor creates an account" (Steam logins carry no email).
3. **Place the block** — add the *Steam OpenId* block (`steam_openid`) to a region at `/admin/structure/block`. Its config form lets you pick which of the two official Steam button images to show.

## How login works
- Anonymous user clicks the button → `/steam-auth` (`steam_login.openid`).
- Controller redirects to `https://steamcommunity.com/openid/login` (`checkid_setup`, `return_to` = `/steam-auth`).
- Steam returns with `openid.mode=id_res`; `OpenIdProvider::getSteamCommunityId()` pulls the Steam64 ID from `openid_identity` (regex `^https://steamcommunity.com/openid/id/(7[0-9]{15,25})$`).
- Existing user (`field_steam64id`) is logged in; otherwise a user `steam-<id>` is created (empty password, no email) and finalized.
- Users with a Steam ID display their Steam username.
