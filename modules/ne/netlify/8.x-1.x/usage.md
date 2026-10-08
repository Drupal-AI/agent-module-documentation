<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Netlify triggers a Netlify build hook when content changes.

---

Netlify **triggers a Netlify build hook when content changes** — POSTing to a configured Netlify build-hook
URL on content save/publish so a decoupled (static/Jamstack) front-end hosted on Netlify rebuilds with the
latest content. It provides its own permissions.

Use it to auto-rebuild a Netlify front-end on content changes. It is a decoupled/integration feature. Security/
data handling: the **Netlify build-hook URL is effectively a secret** (anyone who has it can trigger builds) —
store it securely (env/Key, not committed config), send over HTTPS, and gate who can configure/trigger it via its
permission. It has no access-control role beyond its permission. Configure the Netlify build hook.

---

- Trigger a Netlify build hook.
- Rebuild on content changes.
- Serve a decoupled Netlify front-end.
- Provide its own permissions.
- POST to the build-hook URL.
- Support Jamstack rebuilds.
- TREAT the build-hook URL as a secret.
- Store it securely (env/Key) + HTTPS.
- Gate who can configure/trigger it.
- Have no access-control role beyond permission.
- Configure the build hook.
- Handle Netlify rebuilds.
- Trigger builds.
- Configure the hook.
- Rebuild the front-end.
- Handle the integration.
- Deploy on change.
- Rebuild sites.
- Secure the hook URL.
- Provide Netlify build triggers.
