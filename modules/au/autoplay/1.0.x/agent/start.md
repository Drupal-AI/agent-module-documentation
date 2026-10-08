<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AutoPlay Auto Integration (autoplay) — agent index

**Sends Webform submissions to the AutoPlay automotive lead API via SOAP.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 · **Depends:** webform
- **Config route:** `autoplay.settings` → `/admin/config/system/autoplay` (`administer autoplay settings`).
- **Key classes:** `Plugin/WebformHandler/AutoplayHandler`, `Plugin/QueueWorker/AutoplaySubmissionHandler`, `AutoplayBase` (SoapClient).

**Security:** admin config route permission-gated; lead delivery uses PHP SoapClient over the configured WSDL (no explicit TLS-disable). No inbound/anonymous endpoints. See [configure/autoplay.md](configure/autoplay.md).
