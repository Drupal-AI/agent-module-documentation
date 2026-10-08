<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Generative Summary adds a "Generate Summary" button to summary fields.

---

Generative Summary adds a **"Generate Summary" button** to a summary/text field — calling **OpenAI** to
draft a summary from the field content, which the editor can accept/edit. It depends on core Field, in the
OpenAI package.

Use it to auto-draft content summaries. It is an AI/content-editing feature. Security/data handling: it **sends
the field content to OpenAI** (external data egress — confirm acceptable for the content), authenticates with
an **OpenAI API key** (store as a **secret** — env/Key — over HTTPS), and the button should be available only
to trusted editors (to control API usage/cost). It has no access-control role. Configure the OpenAI credentials
and the target field.

---

- Add a Generate Summary button.
- Draft a summary via OpenAI.
- Let editors accept/edit the draft.
- Depend on core Field.
- Send field content to OpenAI (egress).
- Confirm the egress is acceptable.
- Store the OpenAI API key as a secret.
- Use HTTPS.
- Limit the button to trusted editors.
- Have no access-control role.
- Configure the OpenAI credentials.
- Handle summary generation.
- Generate summaries.
- Configure the field.
- Draft summaries.
- Handle the integration.
- Summarize content.
- Call OpenAI.
- Secure the key.
- Provide generative summaries.
