# Configuration

Configuring Polly has two parts: connecting to Amazon Web Services (handled by the
**AWS** module) and choosing Polly's own speech preferences.

## Part 1 — Connect to AWS

Polly talks to Amazon Polly through the contrib **AWS** module, so your AWS
credentials are configured there, not in Polly itself. You need an AWS access key ID
and secret access key for an IAM identity that is allowed to call Amazon Polly.

**Treat these as secrets — never hard-code them in settings or commit them to
version control.** Store them in environment variables and reference them from
Drupal.

### Store the credentials as secrets (DDEV example)

If you run the site under DDEV, save the values into DDEV's dotenv file and restart
so they are available in the container:

```bash
ddev dotenv set .ddev/.env --aws-access-key-id=<value> --aws-secret-access-key=<value>
ddev restart
```

The flags become the environment variables `AWS_ACCESS_KEY_ID` and
`AWS_SECRET_ACCESS_KEY`. Keep `.ddev/.env` out of version control.

Confirm the variables are present in the container **without printing their
values**:

```bash
ddev exec 'test -n "$AWS_ACCESS_KEY_ID" && test -n "$AWS_SECRET_ACCESS_KEY"'
```

An exit status of `0` means both are set.

### Reference them from Drupal

The AWS module supports supplying credentials through the environment (and, on real
AWS infrastructure, via an IAM instance/role profile — the recommended approach in
production, since no long-lived key is stored at all). Where the AWS module lets you
select a **Key** entity, use the **Key** module's environment provider so the secret
is read from the environment variable rather than stored in the database. Configure
this on the **AWS** module's settings page under **Configuration**, and pick the AWS
**region** in which you want to use Polly.

## Part 2 — Polly speech preferences

Once AWS is connected, set Polly's own preferences (found under **Configuration**):

- **Engine** — which Polly synthesis engine to use (for example the standard engine
  or the higher-quality neural engine). This affects voice quality and cost.
- **Voices** — the preferred voice(s) Polly uses to speak your text.
- **Countries / languages** — the languages/locales you want to support, which in
  turn determine the available voices.

Choose an engine and voices that match the languages of your content and your budget
(the neural engine sounds more natural but costs more per character).

## After configuring

Remember that the base module only provides the integration and these preferences —
it does not itself add a "listen to this page" button. Enable **Polly Synthesis
Task** and/or **Polly Media** (see [Installation](../installation/index.md)), or add
custom code, to actually synthesize and store audio. Because every synthesis sends
text to AWS and incurs charges, review what content you send and monitor your AWS
usage.
