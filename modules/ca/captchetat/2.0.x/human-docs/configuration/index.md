# Configuration

CaptchEtat needs its API credentials before it can issue any challenge, so this step
is required.

## Open the settings form

1. Log in as an administrator (a user with **Administer site configuration** by
   default).
2. Go to the CaptchEtat settings form (route `captchetat.settings`).

## Enter your credentials

From your Piste Gouv application, obtain the **secret key** and **client key**, and
enter them on the settings form along with the CaptchEtat API endpoint. These
authenticate the connection to the CaptchEtat service; without them the challenge
cannot be issued or verified.

### Keep the credentials out of your codebase

Treat the secret and client keys as secrets — never commit them or hard-code them. On
DDEV, store each in an environment variable and load it through a **Key** entity
rather than typing it into configuration that gets exported:

```bash
ddev dotenv set .ddev/.env --captchetat-secret-key=<value>
ddev restart
```

That makes the value available as `CAPTCHETAT_SECRET_KEY` inside the container (keep
`.ddev/.env` out of version control). You can then reference it from a Key entity
using the environment provider and point the module's secret at that Key where it
supports one.

## Assign the challenge to forms

Once the keys are saved, go to the CAPTCHA module's administration pages and assign
the CaptchEtat challenge to the forms you want to protect (for example login,
registration, or contact forms).

## A note on legal requirements and availability

Make sure you have the necessary authorization to use CaptchEtat before deploying it.
Also bear in mind that challenge verification depends on the external CaptchEtat
service being reachable, so its availability affects the forms you protect with it.
