<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTML Lang Override (html_lang_override) — agent index

**Overrides the `<html>` `lang` attribute globally, per path, or per node via a response subscriber — independent of the interface language.**

- **Version:** 1.0.x (1.0.7)
- **Core:** ^9 || ^10 || ^11
- **Configure:** `html_lang_override.settings` → `/admin/config/regional/html-lang-override`
- **Permissions:** `Override HTML lang attribute` (settings form + per-node field); `Administer HTML lang override settings` (global toggle/default fields)
- **Service:** `html_lang_override.manager` (`HtmlLangManager`); subscriber `html_lang_override.subscriber` on `KernelEvents::RESPONSE`
- **Storage:** table `html_lang_override_node` (nid→lang); path map + global default in config
- **Resolution order:** node override → path override → global/default language.

**Security posture:** Admin config route permission-gated; node value entered via node form. Submitted lang codes are `Html::escape()`-ed (maxlength 10) before storage and before being written into the `lang="..."` attribute, so no attribute breakout/XSS; DB access is parameterized (`merge`/`select`/`delete`). The per-node `Override HTML lang attribute` permission is not `restrict access`, but escaping keeps risk low. Note: the subscriber runs a `preg_replace` over every HTML response body (perf cost). See [configure/overrides.md](configure/overrides.md). No security findings.
