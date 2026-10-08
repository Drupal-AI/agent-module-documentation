<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced PWA makes a Drupal site installable as a Progressive Web App (manifest + service worker) and broadcasts web push notifications to subscribed users.

---

Install the module and configure the manifest at /admin/config/system/advanced-pwa, push settings under /config, device caching, subscriptions and broadcast forms (all require 'administer site configuration'). A manifest is served at /manifest.json and a service worker at /serviceworker-advanced_pwa_js. Front-end subscribe/unsubscribe endpoints are gated by 'access content'; the 'display push notification prompt' permission controls who is prompted.

---

- Serve a web app manifest at /manifest.json.
- Serve a service worker script route.
- Let users subscribe/unsubscribe to push (access content).
- Store subscription endpoint + keys per user.
- Broadcast push notifications from an admin form.
- Send new-content notifications on publish.
- List subscriptions in an admin report.
- Provide a 'display push notification prompt' permission.
- Use parameterised DB queries for subscriptions.
- Unsubscribe users automatically on logout via subscriber.
- Include an advanced_pwa_unregister submodule.
- Configure device caching behaviour.
- Note: subscribe/unsubscribe accept anonymous (uid 0).
- Deserialize subscription data with allowed_classes FALSE.
- Serve PWA/performance and engagement features.
- Require VAPID/push keys in configuration.
- Gate all admin forms behind site configuration.
- Track read history via a /history override route.
