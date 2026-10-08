# Configuration

Imgix needs to know two things: which **Imgix source** to serve your images
through, and (if you use signed transformations) the **secure URL token** that
proves a transformation request is legitimate. Both come from your Imgix dashboard.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Media** and open the **Imgix** settings form.

## The settings

- **Imgix source / domain** — the domain Imgix serves your images from (for
  example `your-source.imgix.net`, or a custom CNAME you configured in Imgix). This
  source is backed by your original images, so that Imgix can fetch and transform
  them. Enter the source exactly as it appears in your Imgix dashboard.
- **Secure URL token** — the secret Imgix uses to sign transformation URLs. When a
  token is set, the module signs every image URL, so only transformations your site
  generates are honored and outsiders cannot request arbitrary resizes of your
  images. Leave it empty only if your source is configured for unsigned URLs.
- **Mapping / other options** — depending on your source setup, the form lets you
  align how Drupal file paths map to the Imgix source so the correct original is
  fetched.

## Store the secure URL token as a secret

The secure URL token is a credential — anyone who has it can sign transformations
for your source. Keep it out of committed configuration and version control.

With DDEV, store it in an environment variable rather than typing it into a
committed file:

```bash
ddev dotenv set .ddev/.env --imgix-secure-url-token=<your-token>
ddev restart
```

That makes the value available inside the web container as
`IMGIX_SECURE_URL_TOKEN` (never commit `.ddev/.env`). Where the module accepts a
[Key](https://www.drupal.org/project/key) entity, create an env‑backed key and
select it; otherwise reference the environment variable from `settings.php` with
`getenv('IMGIX_SECURE_URL_TOKEN')` and feed it into the module's configuration.

## A note on egress and private images

Because Imgix fetches your originals and serves the results from its own CDN, your
site must be able to reach Imgix and Imgix must be able to reach your source. More
importantly, remember that anything served through the Imgix source travels over a
**public CDN** — do not route access‑restricted or private images through a public
Imgix source, since Imgix does not enforce Drupal's access controls.

## Use the Imgix formatter

Configuring the source does not by itself change how images render — you also pick
the Imgix formatter per field:

1. Go to **Structure → Content types → *(your type)* → Manage display** (or the
   Manage display of any entity with an image field).
2. Set the image field's **Format** to the **Imgix** formatter and configure its
   options (the Imgix preset/parameters to apply).
3. Save. Images in that display now render through your Imgix source.
