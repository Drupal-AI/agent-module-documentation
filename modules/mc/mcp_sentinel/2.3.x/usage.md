<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MCP Sentinel provides enterprise governance for AI-agent access to Drupal.

---

MCP Sentinel **provides a governance layer for AI-agent access to Drupal** — enforcing policy profiles, field
redaction, data-loss-prevention (DLP), tamper-evident audit logging and reliable webhooks for agents that reach the
site over MCP (Model Context Protocol), JSON:API or GraphQL. It depends on Audit Chain, Tool, JSON:API, Key,
Simple OAuth, Consumers and Encrypt, and provides its own permissions.

Use it to control and audit what AI agents can do on the site. This is a **security-positive** control plane, and
it is built on the right primitives: **Simple OAuth/Consumers** for authenticated agent access, the **Key** module
for secrets and **Encrypt** for protecting data, plus **Audit Chain** for tamper-evident logging — so agent
requests are authenticated, sensitive fields can be **redacted/DLP-filtered** before reaching the agent, and every
action is logged immutably. As with any security control, its protection is only as good as its **policy
configuration**: define restrictive policy profiles, verify the redaction/DLP rules cover the fields you care
about, keep the OAuth clients/keys secured, and monitor the audit log. Configure the policies, OAuth clients and
keys.

---

- Govern AI-agent access to Drupal.
- Enforce policy profiles + field redaction + DLP.
- Provide tamper-evident audit logging + webhooks.
- Cover MCP / JSON:API / GraphQL access.
- Depend on Audit Chain, Key, Simple OAuth, Consumers, Encrypt.
- Provide its own permissions.
- BE security-positive (a control plane for agents).
- Authenticate agents via Simple OAuth/Consumers + protect data via Key/Encrypt.
- Log actions immutably via Audit Chain + redact/DLP sensitive fields.
- DEPEND on its policy configuration (define restrictive profiles, verify redaction coverage).
- Keep OAuth clients/keys secured + monitor the audit log.
- Configure the policies, clients and keys.
- Handle agent governance.
- Govern agents.
- Configure the policies.
- Redact fields.
- Handle the audit log.
- Control access.
- Secure the keys.
- Provide AI-agent governance.
