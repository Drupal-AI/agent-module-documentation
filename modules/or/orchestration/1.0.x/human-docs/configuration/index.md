# Configuration

Orchestration bridges Drupal and an external automation platform, so configuring it
is mostly about **connecting that platform securely**, **enabling the right
submodules**, and **restricting who can set up orchestrations**. Because an
orchestration is executable automation with external reach — running with the site's
own privileges — treat its configuration as sensitive.

## 1. Enable only the submodules you need

Each capability is a separate submodule (see [Installation](../installation/index.md)).
Enable only the ones you actually use — AI agents, AI functions, ECA, tools — since
each one widens what external platforms can trigger inside your site. Review what each
submodule exposes before turning it on.

## 2. Store platform credentials as secrets

Connecting to an external platform (such as Activepieces) uses credentials — an API
key or token. Never hard‑code these or commit them to version control.

If you are working in **DDEV**, save the value as an environment variable:

```bash
ddev dotenv set .ddev/.env --orchestration-api-key=<value>
ddev restart
```

The flag `--orchestration-api-key` becomes the environment variable
`ORCHESTRATION_API_KEY` inside the web container. Keep `.ddev/.env` out of version
control.

Where the connection accepts a **Key entity** for the credential, prefer that. Make
sure the Key module is installed (`ddev composer require drupal/key` and
`ddev drush en key -y`), confirm the variable is present in the container **without
printing its value**:

```bash
ddev exec 'test -n "$ORCHESTRATION_API_KEY"'   # exit status 0 means it is set
```

then create a Key that reads from the environment variable:

```bash
ddev drush key:save orchestration_api_key \
  --label='Orchestration API Key' \
  --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"ORCHESTRATION_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Where a Key entity does not apply, reference the environment variable directly (for
example via `getenv('ORCHESTRATION_API_KEY')` in `settings.php`) rather than storing
the secret in exported configuration. Always connect over **HTTPS** so credentials
and payloads are never sent in cleartext.

## 3. Restrict who can configure orchestrations

Orchestration provides its own permission. Because an orchestration executes
automation with the site's privileges and can reach external systems, grant that
permission — under **People → Permissions** (`/admin/people/permissions`) — only to
**trusted administrators**. Do not extend it to general content or editorial roles.

## 4. Mind the data that leaves the site

Some capabilities send data outward. In particular, **AI functions can send data to
external LLMs**, and any orchestration can push Drupal event data to the connected
platform. Review each enabled submodule and each orchestration to be sure the data it
sends out is appropriate to share, and that the receiving platform is one you trust.

## 5. Connect and test

With the submodules enabled, the credentials stored, and the permission locked down,
connect your Drupal site to the external platform and run a simple end‑to‑end test —
for example, trigger a Drupal workflow from the platform, and fire a Drupal event that
the platform is set to respond to — to confirm the two‑way integration works before
relying on it.
