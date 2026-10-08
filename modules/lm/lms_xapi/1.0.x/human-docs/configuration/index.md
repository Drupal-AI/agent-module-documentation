# Configuration

The heart of configuring LMS XAPI is telling it **which Learning Record Store to
send statements to**, and authenticating to it. Learner activity data leaves your
site as part of this, so treat the setup as security- and privacy-sensitive.

## What you need to configure

To connect to a Learning Record Store, you provide:

- **The LRS endpoint URL** — the address of your Learning Record Store's xAPI
  endpoint. If you are using the bundled `lrs_xapi` submodule as your store, you
  point the module at that instead of an external service.
- **The LRS credentials** — the authentication details (typically a key/secret or
  Basic Auth credentials) that let the module post statements to the LRS.

Exactly where these fields appear depends on the submodules you enabled and your
LRS choice, so follow the settings the module exposes after installation.

## Store the credentials as secrets

The LRS credentials authenticate write access to your learning-records store, so
handle them like any other secret:

- Keep them in an **environment variable** and/or a **Key entity** rather than
  hard-coding them or committing them to your repository.
- On DDEV, you can store a value with
  `ddev dotenv set .ddev/.env --lrs-secret=<value>` and reference it from Drupal.

## Privacy and data egress

Every emitted statement records **who did what** and is sent to the LRS endpoint.
That means:

- **Personal data leaves your site.** Learner identities and their activity are
  transmitted to the LRS, which may be operated by a third party. Make sure this
  is compatible with your privacy policy and any consent you rely on.
- **Send only what you need.** Enable the tracking submodules (`lms_xapi_activity`,
  `lms_xapi_lesson`) that match what you actually need to report on, rather than
  emitting everything by default.
- **Trust the endpoint.** Only configure an LRS endpoint you control or trust, and
  prefer an HTTPS endpoint so statements are encrypted in transit.

## Permissions

LMS XAPI provides its own permissions — review them under **People → Permissions**
and grant them deliberately, since they govern the xAPI integration.

## Verify it worked

After saving the connection, have a test learner complete a tracked activity or
lesson and confirm the corresponding xAPI statement is received by your LRS.
