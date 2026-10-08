# Configuration

New Fangled Insight Engine needs a token and an environment before it will report
anything. Configuration is done on the module's settings form.

## Open the settings form

1. Log in as an administrator.
2. Open the module's settings — from the **Extend** page
   (`/admin/modules`), click **Configure** next to *New Fangled Insight Engine*, or
   find its entry under **Configuration**.

## Generate and enter your token

1. **Log in to the Insight Engine and generate your token.** This is the credential
   that authenticates your site to the service.
2. Back on the Drupal settings form, **paste the token** into the token field.

## Options

- **Environment** — choose **Sandbox** while testing your integration, or
  **Production** for live reporting. Start in Sandbox and switch to Production only
  once you have confirmed data is arriving correctly.
- **Debug mode** — enable this temporarily to troubleshoot the integration; leave
  it off in normal operation.

Webform conversion tracking works automatically when the Webform module is present;
entity‑reference fields (such as taxonomy terms) are reported to the Insight Engine
as terms.

## Store the token as a secret

The Insight Engine token authenticates your site to the external service, so it must
**never** be committed to version control or pasted into exported configuration.
Keep it in an environment variable and reference it through Drupal.

1. **Store the value in a DDEV environment variable** (do not commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --insight-engine-token=<value>
   ddev restart
   ```

   The flag `--insight-engine-token` becomes the variable `INSIGHT_ENGINE_TOKEN`.

2. **Confirm it is present in the container without printing it:**

   ```bash
   ddev exec 'test -n "$INSIGHT_ENGINE_TOKEN"'   # exit status 0 means set
   ```

3. **Expose it to Drupal via a Key entity** (install the Key module if needed —
   `ddev composer require drupal/key && ddev drush en key -y`):

   ```bash
   ddev drush key:save insight_engine_token --label='Insight Engine token' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"INSIGHT_ENGINE_TOKEN","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

   Reference that Key on the settings form where it accepts one; otherwise read the
   value in settings.php via `getenv('INSIGHT_ENGINE_TOKEN')`.

## Privacy and egress note

This module **sends site and usage data to the external Insight Engine service**,
which may include personal data — disclose this in your site's privacy policy as
appropriate, and only enable the tracking you actually need. If your environment
restricts outbound traffic, allow HTTPS egress to the Insight Engine hosts, and
ensure all communication runs over HTTPS.
