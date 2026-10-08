<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LegalWeb Cloud — agent index

Integrates the **legalweb.io** cloud service (legal texts + consent popup from a subscription). Requires PHP
7.3. Provides permissions; `legalweb_cloud_enhancements` submodule. Version **2.0.2**. Core `^9||^10||^11`.

`generateAssets()` stores the JS legalweb.io returns (`dppopupjs`) in `public://…/legalweb_cloud.js` and loads
it as a library on every non-admin page (refreshed by cron every 24h). The API guid lives in module config.
