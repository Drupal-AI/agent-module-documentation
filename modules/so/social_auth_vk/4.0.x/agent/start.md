<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth Vkontakte — agent index

"Log in with **VKontakte (VK)**" — a **Social Auth** provider plugin (on Social API) using OAuth2.
Supplies the VK client + settings (client ID/secret); the OAuth2 flow, **random `state`/CSRF**, and
token exchange live in the Social Auth base. Depends on `social_auth`. Version **4.0.1**. Core
`^9||^10||^11`.

Register a VK app, store client secret as config/secret, set the Social Auth callback URL. Account
creation/matching governed by Social Auth settings.
