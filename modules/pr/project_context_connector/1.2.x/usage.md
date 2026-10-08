<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Project Context Connector exposes sanitized read-only project-context JSON endpoints (and a Drush command) for Slack/Teams prompt building.

---

Project Context Connector **exposes sanitized, read-only project context** — JSON endpoints (and a Drush
command) that report Drupal project context (for building Slack/Teams AI prompts), designed to be read-only and
sanitized. It depends on the Tool and MCP Server modules, and provides its own permissions, in the Development
package.

Use it to feed project context to chat/AI tooling. It is a developer/integration feature, and it is built with
access controls: the snapshot endpoint is gated by an **`access project context snapshot` permission**, a separate
**signed** endpoint uses a **signature access check** (for automated callers), and admin config needs `administer
project context connector`. Security notes: the exposed context is effectively **project/infra metadata** (even if
sanitized), so keep the snapshot permission to trusted users, **secure the signing secret** for the signed
endpoint, and verify the "sanitized" output doesn't include secrets/sensitive config for your setup. It has this
gated role only. Configure the connector and signing secret.

---

- Expose sanitized project context.
- Provide read-only JSON endpoints + a Drush command.
- Build Slack/Teams AI prompts.
- Depend on Tool + MCP Server.
- Provide its own permissions.
- Serve development/integration.
- Gate the snapshot by 'access project context snapshot' + a signed endpoint by signature check.
- Keep the snapshot permission to trusted users.
- Secure the signing secret + verify sanitized output has no secrets.
- Have this gated role only.
- Configure the connector + signing secret.
- Handle project context.
- Expose context.
- Configure the endpoints.
- Report context.
- Handle the integration.
- Serve JSON.
- Feed AI prompts.
- Secure the secret.
- Provide project-context endpoints.
