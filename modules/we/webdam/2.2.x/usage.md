<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webdam provides Webdam digital asset management system integration.

---

Webdam integrates the **Webdam (Acquia DAM) digital-asset-management** system with Drupal — browsing and
using Webdam-hosted assets as Drupal media via Entity Browser, with a `webdam_sns` submodule (asset-update
notifications via AWS SNS) and a demo submodule. It depends on core Media and Entity Browser, provides its own
permissions, in the Media package.

Use it to use Webdam assets in Drupal. It is a media/DAM integration feature. Security handling: it
authenticates to the **Webdam API with credentials** (OAuth/API key) — store these as **secrets** (env/Key),
use HTTPS; the `webdam_sns` submodule receives **AWS SNS notifications** (ensure that endpoint validates the
SNS message signature so it can't be spoofed). Its permission gates who can browse/use assets. Configure the
Webdam credentials.

---

- Integrate Webdam (Acquia DAM).
- Use Webdam assets as media.
- Browse assets via Entity Browser.
- Provide an SNS-notifications submodule.
- Depend on core Media and Entity Browser.
- Provide its own permissions.
- Authenticate with Webdam API credentials.
- Store credentials as secrets.
- Use HTTPS.
- Validate SNS message signatures (webdam_sns).
- Gate who can use assets.
- Configure the Webdam credentials.
- Handle Webdam.
- Use DAM assets.
- Configure the integration.
- Browse assets.
- Handle the DAM.
- Import assets.
- Secure credentials.
- Provide Webdam integration.
