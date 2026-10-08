<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TMGMT Lara Translate provides a Lara Translate provider plugin for TMGMT.

---

TMGMT Lara Translate provides a **Lara Translate provider for TMGMT** — so the Translation Management Tool
can send content to the **Lara** machine-translation service and receive translations. It depends on Key, SM,
TMGMT and TMGMT Content, provides its own permissions, in the Translation Management package.

Use it to machine-translate content via Lara through TMGMT. It is a multilingual/integration feature.
Security/data handling: it **sends content to the external Lara service** (data egress — confirm acceptable) and
authenticates with a **Lara API credential** — good news: it depends on the **Key** module, so store the
credential as a **Key** (env/secret provider), over HTTPS, rather than in plain config. It has no access-control
role beyond its permissions. Configure the Lara credentials (via Key) and TMGMT provider.

---

- Provide a Lara TMGMT provider.
- Machine-translate via Lara.
- Send content for translation.
- Depend on Key/SM/TMGMT.
- Provide its own permissions.
- Receive translations.
- Send content to the external Lara service (egress).
- Confirm the egress is acceptable.
- Store the Lara credential as a Key.
- Use HTTPS.
- Have no access-control role beyond permissions.
- Configure the Lara credentials.
- Handle Lara translation.
- Translate content.
- Configure the provider.
- Send translations.
- Handle the integration.
- Machine-translate.
- Secure the credential.
- Provide Lara translation.
