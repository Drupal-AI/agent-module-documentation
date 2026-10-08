<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ORCID — agent index

**ORCID OAuth2 login / account-linking.** Provides permissions. Version **8.x-1.1**. Core `^8||^9||^10||^11`.

OAuth callback: `OauthController::redirectPage()` at `/orcid/oauth` (`_access: TRUE`) — exchanges the returned
`code`, then logs the user in or links the ORCID iD to the current account.
