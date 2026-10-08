# Configuration

To use Bunny Optimizer you connect Drupal to your **Bunny.net** account so images
can be served through Bunny's Optimizer. You supply your Bunny.net details — the
**pull zone** that fronts your images and the **API key / token** for your account
— in the module's settings.

> **A note on scope of these docs:** the reference material available for this
> module is thin and does not pin down the exact settings-form path or every
> field. The guidance below focuses on what you need to provide and, importantly,
> how to handle the credentials safely. Check the module's own README and its
> settings form for the precise field names on your version.

## What you need from Bunny.net

- A **pull zone** configured for your site's image URLs.
- Your Bunny.net **API key / token** (and any zone-specific value the settings
  form asks for).

## Handle the credentials as secrets

Your Bunny.net API key is a secret. **Do not hard-code it and do not commit it to
version control or into exported configuration.** The recommended pattern on this
project is to keep the value in an environment variable rather than in tracked
config:

1. Store the secret with DDEV's dotenv helper (the flag name becomes the
   environment variable, and `.ddev/.env` must stay out of version control):

   ```bash
   ddev dotenv set .ddev/.env --bunny-api-key=<your-key>
   ddev restart
   ```

   This makes the value available as `BUNNY_API_KEY` inside the web container.

2. Confirm the variable is present **without printing its value**:

   ```bash
   ddev exec 'test -n "$BUNNY_API_KEY"'   # exit status 0 means it is set
   ```

3. Reference it from `settings.php` with `getenv('BUNNY_API_KEY')` (or, where a
   [Key](https://www.drupal.org/project/key) entity is supported, create a Key
   using the environment provider) rather than typing the secret into a config
   form that gets exported.

If you must enter the key directly in the settings form, keep the resulting
configuration out of any committed or publicly shared config export, and restrict
who can administer the module's settings.

## Point images at Bunny

Once the credentials and pull zone are set, the module renders Drupal images
through Bunny Optimizer — image URLs resolve to Bunny's edge, where they are
optimized and served. Always use **HTTPS** for the Bunny endpoints.

## Remember what a CDN does and doesn't do

Serving images through Bunny.net does **not** add access control: images delivered
via the CDN are as public as their source files. Don't rely on the Optimizer to
protect private images — use Drupal's own access mechanisms for that, and only
route genuinely public images through the CDN.
