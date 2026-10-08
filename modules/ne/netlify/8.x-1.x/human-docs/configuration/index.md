# Configuration

Netlify needs one essential piece of information — your **build-hook URL** — plus a
choice of what should trigger a rebuild.

## First, create a build hook in Netlify

In the Netlify dashboard, go to your site's **Site settings → Build & deploy →
Build hooks** and create a new build hook. Netlify gives you a URL of the form
`https://api.netlify.com/build_hooks/…`. This URL is what the module will POST to.

## Treat the build-hook URL as a secret

Anyone who has this URL can trigger builds of your site, so handle it like a
password:

- **Do not commit it** into version-controlled configuration.
- Prefer storing it in an **environment variable** and referencing it from
  `settings.php`, or store it with the **Key** module.
- It is already an HTTPS endpoint — keep it that way.

With DDEV you can set it as an environment variable without committing it:

```bash
ddev dotenv set .ddev/.env --netlify-build-hook-url=<value>
ddev restart
```

Then override the module's setting from `settings.php`:

```php
$config['netlify.settings']['build_hook_url'] = getenv('NETLIFY_BUILD_HOOK_URL');
```

Adjust the config key to match the module's actual setting, and keep `.ddev/.env`
out of version control.

## Configure the module

1. Open the module's settings form as a user who holds the Netlify permission.
2. Enter (or reference, per the secret-handling note above) your **build-hook
   URL**.
3. Choose **what triggers a build** — which content and/or configuration entity
   changes should cause a rebuild. Point this at the entities whose changes affect
   your Netlify front-end, such as content types powering listings or configuration
   objects that feed footer text or theme colors.
4. Save the form.

## Confirm builds fire

Save one of the entities you configured as a trigger, then check your Netlify
dashboard for a new deploy. If nothing happens, re-check the build-hook URL and
that the entity you edited is one of the configured triggers.

## Watch your build usage

Every triggered build consumes Netlify build minutes. On a site with frequent edits,
consider limiting triggers to the entity types that genuinely need a rebuild, so you
do not queue a build on every trivial save.
