<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TMGMT LanguageLine integrates the Translation Management Tool (TMGMT) with Capita LanguageLine Solutions, letting you send TMGMT translation jobs to LanguageLine and receive completed translations back. It is a TMGMT translator plugin configured under the translator collection (Configuration > Regional and language > Translation providers).

---

The CapitaTranslator plugin builds requests to the LanguageLine service (staging or production URL, chosen by an "environment" setting) over the core http_client (Guzzle), authenticating with HTTP Basic auth from the translator's username/password settings. Responses are parsed as JSON, and it uses tmgmt_file to package source content. Default Guzzle TLS verification applies (not disabled).

Use it when a site's translation workflow relies on LanguageLine as the language service provider. Credentials are stored in the translator entity's settings; there are no public callback routes — job status/results are handled through the standard TMGMT provider flow.

---

- Send TMGMT jobs to Capita LanguageLine.
- Receive completed human translations back.
- Configure a LanguageLine translation provider.
- Authenticate with Basic auth username/password.
- Switch between staging and production endpoints.
- Package source content via tmgmt_file.
- Parse JSON responses from the service.
- Manage credentials in the translator entity.
- Integrate LanguageLine into TMGMT workflows.
- Use Guzzle with default TLS verification.
- Drive translation through the TMGMT UI.
- Support enterprise human translation.
- Map languages to the provider's codes.
- Handle service errors as TMGMT exceptions.
- Fit multilingual content operations.
- Avoid custom API code for LanguageLine.
- Route jobs to a professional LSP.
- Keep provider config under Translation providers.
