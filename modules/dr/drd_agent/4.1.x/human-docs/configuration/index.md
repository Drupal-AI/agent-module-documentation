<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

DRD Agent has very little to configure locally — the real "configuration" is
authorizing your dashboard. Note that the agent stores its settings in Drupal's
**State** system, not in configuration objects, so these values are not part of a
config export.

## The settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → DRD Agent**, or navigate directly to
   `/admin/config/system/drd`.

The form has exactly one field:

- **Debug mode** *(off by default)* — turns on extra diagnostics, useful when you
  are troubleshooting a connection to the dashboard. Leave it off in normal
  operation.

You can also toggle it from Drush:

```bash
drush state:get drd_agent.debug_mode
drush state:set drd_agent.debug_mode 1
```

## Authorizing your DRD dashboard

For the dashboard to manage the site, it must be authorized. There are two ways:

1. **From the DRD portal** — add the site in DRD, which calls the agent's authorize
   endpoints (`/drd-agent-authorize`, `/drd-agent-authorize-secret`) to complete a
   secure handshake.
2. **From the command line** — when you add the site in the DRD portal it generates
   a token (a base64/JSON-encoded bundle of everything DRD needs to talk to this
   site). Run:

   ```bash
   drush drd:agent:setup <token>
   # the alias is:
   drush drd-agent-setup <token>
   ```

   The command sets up the connection and then logs a portal URL you must open
   (while authenticated) to finish adding the agent. This is the CLI equivalent of
   the authorize form and is handy for headless or automated provisioning.

Once authorization succeeds, the dashboard's credentials are appended to the
agent's authorized list (State key `drd_agent.authorised`), and DRD can start
running actions. All requests between the dashboard and the agent are encrypted
(OpenSSL or TLS) and authenticated (shared secret or username/password).

## Hosting-provider connections

If your sites are hosted on **Acquia**, **Pantheon**, or **Platform.sh**, DRD can
reach them through the matching built-in provider-authentication plugin — no extra
local configuration is needed on the agent side. Developers can add support for
other hosts by implementing a `drd_pi_auth` plugin (see the
[`agent/`](../agent/start.md) docs).

## Permissions

DRD Agent defines no permissions of its own. The settings and authorize forms use
core's **Administer site configuration** permission.
