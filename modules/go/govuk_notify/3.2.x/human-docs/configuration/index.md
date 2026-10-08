# Configuration

Open the module's settings page as a user with the **administer GOV.UK Notify**
permission (`administrator gov uk notify`). The central task is connecting your
site to Notify with an **API key**; templates and message content live in Notify
itself, not here.

## The API key — and why its scope matters

Enter the **Notify API key** for the account you want to send from. Notify issues
keys in three scopes, and choosing the right one is the single most important
decision on this page:

- **Test** — does not send real messages; used for development and automated
  testing.
- **Team‑only** — sends only to addresses/numbers on your Notify team, useful for
  safe end‑to‑end checks.
- **Live** — sends to anyone.

Use a **test or team‑only key in non‑production environments**. A **live key on a
staging or development site is how a test run sends real letters, texts or emails
to real people** — a recognisable and reportable incident in the public sector.
Keep environments pointed at the correct key.

## Store the key as a secret

The API key is a credential — never commit it to version control or paste it into
exported configuration. Provide it through the environment instead. With DDEV:

```bash
ddev dotenv set .ddev/.env --govuk-notify-api-key=<value>
ddev restart
```

(The flag `--govuk-notify-api-key` becomes the variable `GOVUK_NOTIFY_API_KEY`;
keep `.ddev/.env` out of version control.) If the module offers a **Key** entity
selector for the API key, point it at an environment‑provider Key referencing that
variable; otherwise reference the variable from `settings.php` via
`getenv('GOVUK_NOTIFY_API_KEY')` rather than typing the secret into the form and
saving it into config.

## Templates are the message

The wording of each email, SMS or letter is a **Notify template**, edited and
versioned in your Notify account by the people responsible for it. Your site does
**not** hold the message text — it selects a template and supplies the variables
it needs. When configuring or coding a send, reference the template and pass the
right **personalisation** values rather than hard‑coding any wording; hard‑coded
text defeats the reason Notify was adopted.

## Personalisation is real personal data

The personalisation you send — names, addresses, reference numbers, case details —
is personal data being processed through a third‑party platform. Treat the
integration as a **processing activity to record** in your information‑governance
documentation, not merely a technical connection.

## Save and test

Save the settings, then send a **test** message through a template and confirm it
in the Notify delivery report. Only switch to a live key once the test path works
end to end.
