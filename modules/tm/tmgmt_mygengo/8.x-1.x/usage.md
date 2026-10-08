<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gengo Translator integrates TMGMT with the Gengo (formerly myGengo) crowd-sourced human translation service, submitting translation jobs to Gengo and retrieving completed translations. It provides a translator plugin plus an inbound callback route Gengo uses to push job updates.

---

The GengoConnector wraps Gengo's REST API over the core http_client, submitting jobs and polling status/comments; API public/private keys are stored in the translator settings and Gengo's request signing (api_sig) is used on outbound calls. An inbound route /tmgmt_mygengo_callback (MyGengoController::callback) receives job/comment notifications and writes returned translations onto the local job via saveTranslation().

Security note: the callback route is _access: 'TRUE' (anonymous) and the controller does NOT verify Gengo's request signature — it trusts the POSTed `job`/`comment` payload, resolves the local job from custom_data, and stores the supplied translated text. See the campaign security report for the unverified-webhook finding. Operationally, use it for professional/crowd human translation through the TMGMT UI; credentials live in the translator settings.

---

- Submit TMGMT jobs to Gengo for human translation.
- Retrieve completed translations from Gengo.
- Poll job status and comments.
- Store Gengo public/private API keys in settings.
- Sign outbound API calls with api_sig.
- Receive job updates on a callback route.
- Map remote Gengo jobs to local job items.
- Handle translation comments/notifications.
- Support crowd-sourced human translation.
- Configure via the Translation providers UI.
- Use tiers and word counts from Gengo.
- Drive translation through the TMGMT flow.
- Deduplicate identical source strings.
- Package content for the Gengo service.
- Fit multilingual editorial workflows.
- Integrate a professional LSP crowd network.
- Track credits and unit counts per job.
- Save returned translations onto job items.
