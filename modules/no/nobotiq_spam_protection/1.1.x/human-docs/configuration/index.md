# Configuration

Configuring NoBotIQ has three parts: create a NoBotIQ account and get your
credentials, **store those credentials securely** (this guide uses environment
variables and the Key module rather than pasting secrets into the database), and
then choose which forms to protect and how.

The settings form lives at **Configuration → Web services → NoBotIQ Spam
Protection** (`/admin/config/services/spam-protection`).

## 1. Register with NoBotIQ

1. Create a free account at **nobotiq.com** — you receive 3,000 free credits on
   sign-up, no credit card required.
2. In your NoBotIQ account, open the **API Documentation** page and copy your
   API credentials: the **Client ID**, **Client Secret**, and your account
   **username / password**.

Remember that this is a paid, metered service — credits are consumed per API
call based on the length of the text checked, and unused credits do not expire.

## 2. Store the credentials securely (recommended)

The Client Secret (and the account password) are secrets, so keep them out of
version control and out of the database where you can. The cleanest pattern with
DDEV is to hold each value in an environment variable and reference it from a
**Key** entity.

1. Save the secret into DDEV's dotenv file (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --nobotiq-client-secret=<your-client-secret>
   ddev restart
   ```

   The flag `--nobotiq-client-secret` becomes the environment variable
   `NOBOTIQ_CLIENT_SECRET` inside the web container.

2. Confirm the variable is present **without printing its value**:

   ```bash
   ddev exec 'test -n "$NOBOTIQ_CLIENT_SECRET"'   # exit status 0 means it is set
   ```

3. Create a Key entity backed by that environment variable (the Key module is a
   dependency, so it's already enabled):

   ```bash
   ddev drush key:save nobotiq_client_secret \
     --label='NoBotIQ Client Secret' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"NOBOTIQ_CLIENT_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

On the module's settings form, select this **Key** for the corresponding
credential rather than typing the secret in directly. (Non-secret values such as
the Client ID can be entered on the form.)

## 3. Enter credentials and choose what to protect

Back on `/admin/config/services/spam-protection`:

1. Enter the **Client ID** and select the **Key(s)** holding your secret
   credentials, then save.
2. **Select which forms to protect** — contact forms, comment forms, user
   registration, and/or custom webforms.
3. For each protected form, choose the **check type**:
   - **Email-only** — validates the submitted email address (catches disposable,
     temporary, and spam-trap addresses).
   - **Text-only** — analyses the title/body text for spam patterns.
   - **Hybrid** — validates email and text together in a single API call, which
     is the most credit-efficient.
4. Choose the **response to spam** — silently block the submission, show a
   validation error, or log the attempt.

## Egress, privacy, and reliability

- **Disclose the egress.** Protected submissions (text, email, and possibly the
  visitor's IP) are sent to nobotiq.com. Note this in your privacy policy.
- **Use HTTPS** for your own site, and ensure outbound HTTPS to `nobotiq.com`
  is allowed from your server.
- **Decide fail-open vs fail-closed.** Consider what should happen if the API is
  slow or unreachable — accept submissions (fail-open) or block them
  (fail-closed) — and set the module's behaviour to match your risk tolerance.
- **Watch your credits.** Because billing is per-call, pairing NoBotIQ with a
  free first-pass filter such as **Honeypot** can reduce the number of API calls
  spent on obvious bots.

Once configured, the module runs invisibly: spam is blocked before processing and
legitimate submissions pass through without friction.
