<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Redirect — agent index

Config-entity **301 redirects**: admin defines internal from->to pairs at `/admin/config/search/simple-redirect` (`administer site configuration`); a `kernel.request` subscriber (`SimpleRedirectRequestSubscriber`) 301-redirects on exact request-URI match via `Url::fromUserInput`. Version **4.0.0**, core 8.9–<11.

Targets are admin-configured internal paths (form requires leading slash) → no user-controlled/open redirect.