# Configuration

Martelus Companion connects your site to the Vectorly AI service, so the main task is
entering your **API credentials** — and doing so safely.

## Connect to Vectorly AI

1. Log in as an administrator (a user with permission to administer the module's
   configuration).
2. Open the module's settings form from the **Configuration** area.
3. Enter the **Martelus / Vectorly AI credentials** from your paid subscription (the
   API key or token issued to your account at
   [martelus.store](https://martelus.store)).
4. Save the form. With valid credentials and an active subscription, the AI features
   become available on your site.

## Store the credentials safely

The Martelus credentials are a secret. Keep them out of the database and out of
version control by storing them in an environment variable and referencing that from
Drupal.

With DDEV, store the value as an environment variable and load it into the
container:

```bash
ddev dotenv set .ddev/.env --martelus-api-key=YOUR_KEY_HERE
ddev restart
```

That makes it available inside the container as `MARTELUS_API_KEY` (keep
`.ddev/.env` out of version control). Confirm it is present *without* printing it:

```bash
ddev exec 'test -n "$MARTELUS_API_KEY" && echo set'
```

If your setup uses the **Key** module, create a Key backed by that environment
variable and reference it from the module's settings, rather than pasting the secret
into the form.

## Data egress and privacy

Martelus Companion sends data — including customer conversations and the business
information the AI works with — to the external Martelus service for processing. Be
deliberate about this:

- Confirm that sending this data to a third party is permitted for your use case, and
  review the Martelus [terms of service](https://martelus.store/terms-of-service).
- Where personal data is involved, disclose the processing in your privacy notice and
  obtain consent where your rules require it.
- Share only the data the feature needs.
