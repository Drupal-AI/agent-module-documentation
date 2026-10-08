<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Qcart is a thin loader that attaches the hosted Qcart button script from `qcart.app` to every page so the third-party shopping-cart widget renders site-wide.
---
The whole module is one `hook_page_attachments()` that unconditionally attaches the `qcart/library_qcart` library. That library (qcart/qcart.libraries.yml) declares a single external, deferred/async script: `https://qcart.app/btn.js?trg=any`, loaded in the header on all pages. There is no configuration form, route, permission, or service — behaviour is entirely delegated to the remote Qcart service, and all cart logic/state lives in that external script and Qcart's own backend, not in Drupal.

Operational/security notes: this loads and executes remote third-party JavaScript on every page of the site, which is a supply-chain and privacy consideration (the remote script can change at any time and can observe all pages). The script is served over HTTPS. To scope it to specific pages you must edit `qcart_page_attachments()` — the code comment invites adding conditions there. There is no Drupal-side pricing/order handling to manipulate; the module simply embeds a widget.

Typical setup: enable the module; the button appears automatically.
---
- Add the Qcart button to every page.
- Enable a hosted shopping cart without local commerce code.
- Load `qcart.app/btn.js` asynchronously.
- Restrict the script to certain pages by editing the hook.
- Remove the widget by disabling the module.
- Prototype a cart quickly on a small site.
- Delegate cart state to the Qcart service.
- Review third-party JS before deploying to production.
- Deploy a cart widget with zero configuration.
- Serve the script over HTTPS.
- Audit the remote script before production.
- Disable the cart by uninstalling the module.
- Load the button in the page header.
- Defer/async the external script.
- Scope the widget to product pages via the hook.
