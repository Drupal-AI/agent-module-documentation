<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds Tamper AI is an AI extension for Tamper.

---

Feeds Tamper AI adds an **AI-powered Tamper plugin** — Tamper transforms values during a Feeds import, and
this plugin uses an AI model to transform/clean/classify the imported value (e.g. summarize, translate,
categorize a feed field) as part of the pipeline. It is in the Custom package.

Use it to apply AI transformations during Feeds imports. It is an integration/data feature. Security/data
handling: it **sends the imported field data to an AI model/service** (external data egress if the AI provider
is cloud-based — confirm that's acceptable for the content), and it runs during import (which processes
external feed data). Handle any AI provider **credentials** as secrets. It has no access-control role. Configure
the AI Tamper plugin on a feed.

---

- Provide an AI Tamper plugin.
- Transform Feeds data with AI.
- Summarize/translate/classify feed fields.
- Run during a Feeds import.
- Extend the Tamper module.
- Process imported values.
- Send data to an AI model (egress).
- Confirm the egress is acceptable.
- Handle AI credentials as secrets.
- Have no access-control role.
- Configure the AI Tamper plugin.
- Handle AI tampering.
- Transform imports.
- Configure the plugin.
- Apply AI to feeds.
- Handle the integration.
- Clean feed data.
- Transform values.
- Secure credentials.
- Provide AI Tamper.
