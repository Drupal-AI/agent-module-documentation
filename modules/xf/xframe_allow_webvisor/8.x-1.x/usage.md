<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Xframe Allow Webvisor emits a `Content-Security-Policy: frame-ancestors …` header on every response so that Yandex Metrica WebVisor can load the site inside an iframe for session recording.

---

Yandex Metrica WebVisor is a session-replay tool that records and plays back visitor sessions by rendering the page inside an iframe on Yandex's side. A Drupal site's default framing policy prevents that. Xframe Allow Webvisor removes the obstacle with a single kernel-response event subscriber (`Drupal\xframe_allow_webvisor\EventSubscriber\XframeSubscriber`): on the `kernel.response` event it calls `$response->headers->set('content-security-policy', "frame-ancestors 'self' http://webvisor.com https://webvisor.com https://metrika.yandex.ru http://metrika.yandex.ru")`, so every response carries a Content-Security-Policy whose `frame-ancestors` directive lists the site itself and the Yandex WebVisor / Metrica origins. The module has no settings form, no configuration objects, no permissions and no routes — installing and enabling it is the entire setup, and the header value is hard-coded. Because the subscriber runs unconditionally, the header is applied to all paths, including admin and authenticated pages. Note that `set()` writes the header rather than merging into an existing one, so if the site or another module already sends a Content-Security-Policy, review how the two interact after enabling. For finer-grained control over framing and other security headers, the Security Kit (`seckit`) module is the general-purpose alternative.

---

- Allow Yandex Metrica WebVisor to load the site in an iframe for session replay.
- Enable WebVisor recording on a Drupal site whose framing policy would otherwise block it.
- Emit a `frame-ancestors` Content-Security-Policy directive permitting the Yandex WebVisor origins.
- Permit framing by `webvisor.com` (http and https).
- Permit framing by `metrika.yandex.ru` (http and https).
- Keep `'self'` in the frame-ancestors list so the site can still frame its own pages.
- Turn on WebVisor framing with zero configuration — enable the module and it works.
- Add the required framing header without hand-editing web-server or settings.php config.
- Support a Yandex Metrica analytics setup that relies on WebVisor session recording.
- Apply the framing header site-wide across all routes and responses.
- Inspect the emitted `Content-Security-Policy` response header to confirm WebVisor framing is allowed.
- Verify in the browser dev-tools Network panel that the header is present on page loads.
- Provide the framing allowance a Yandex Metrica tag/counter needs for WebVisor to attach.
- Use on a marketing or content site that has adopted Yandex Metrica for behavioural analytics.
- Serve as a minimal, dependency-free way to add one CSP framing directive.
- Disable the module to immediately stop emitting the WebVisor framing header.
- Review interaction with any existing Content-Security-Policy before enabling on a hardened site.
- Combine consideration with Security Kit (`seckit`) when broader header control is needed.
- Confirm WebVisor session recordings begin appearing in the Yandex Metrica dashboard after enabling.
- Support Drupal 8, 9, 10 and 11 (core requirement `^8 || ^9 || ^10 || ^11`).
- Restrict who can install/enable modules so the framing change is made deliberately.
- Test on a staging environment before enabling in production.
