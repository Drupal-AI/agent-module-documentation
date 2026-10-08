# Configuration

CaptchaFox needs your account keys before it can present or verify any challenge, so
this step is required.

## Enter your keys

1. Enable the CaptchaFox and CAPTCHA modules (`/admin/modules`).
2. Create an account on the CaptchaFox website and obtain your **site key** (public,
   shown to the browser) and **secret key** (private, used for server-side
   verification).
3. Go to the **CaptchaFox** tab on the CAPTCHA administration page at
   `/admin/config/people/captcha/captchafox`.
4. Enter the **site key** and the **secret key**, then save.

### Keep the secret key out of your codebase

The secret key is a credential. Never commit it or paste it into configuration that
gets exported. On DDEV, store it in an environment variable and load it through a
**Key** entity rather than typing it into plain configuration:

```bash
ddev dotenv set .ddev/.env --captchafox-secret-key=<value>
ddev restart
```

That makes the value available as `CAPTCHAFOX_SECRET_KEY` inside the container (keep
`.ddev/.env` out of version control). You can then reference it from a Key entity
using the environment provider and point the module's secret at that Key where it
supports one. Keep the site key and secret key distinct.

## Assign the challenge to forms

Go to the main CAPTCHA administration page (`/admin/config/people/captcha`) and set
where you want the CaptchaFox challenge to appear — for example on user registration,
login, or contact forms.

## A note on reliability

Because CaptchaFox is verified server-side against
`https://api.captchafox.com/siteverify`, make sure the verification **fails closed**
— that is, rejects the submission — if the service is unreachable, so an outage
cannot be used to bypass the challenge.
