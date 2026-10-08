# Configuration

Setting up Preview Site is a two‑step flow: first define a **strategy** (how
previews are generated and where they're deployed), then create and deploy a
**build** (the actual content you want to preview).

## Step 1 — Create a preview‑site strategy

1. Go to **Structure → Preview site → Strategies**
   (`/admin/structure/preview-site/strategies`) and add a new strategy.
2. Configure its two plugins:
   - **Generation strategy** — choose the **Tome Static** generator (shipped by
     default). This is what turns your selected content into static HTML and assets.
   - **Deployment strategy** — choose where the artefacts go. If you enabled the
     **Preview Site S3** submodule, pick the S3 deployment and fill in the bucket
     details. If you didn't, you'll need a custom deployment plugin.
3. Save the strategy.

### Storing S3 credentials safely

The S3 deployment needs credentials (an access key and secret) to write to your
bucket. **Do not paste secrets into configuration that gets exported and committed.**
Store them in an environment variable — with DDEV, for example:

```bash
ddev dotenv set .ddev/.env --aws-access-key-id=<value> --aws-secret-access-key=<value>
ddev restart
```

Then reference them through a **Key** entity (install the Key module if needed) or
via `getenv()` in settings, following your site's usual secret‑handling pattern.
Keep `.ddev/.env` out of version control.

## Step 2 — Create and deploy a build

1. Go to **Structure → Preview site → Builds**
   (`/admin/structure/preview-site/builds`) and add a new build.
2. Add the **entities you want to preview** (the draft content), and choose the
   strategy you created above.
3. Save the build, then click **Build and Deploy**. The module runs the generator
   to produce the static artefacts and the deployment plugin to push them to the
   destination.
4. When processing completes, the provided link takes you to the built preview.

## Secure the destination

Because a preview contains **unpublished / draft content**, the destination must
not be publicly guessable or open:

- **Do not use a public S3 bucket** for previews — that exposes drafts to anyone
  with the URL. Restrict access to the preview.
- Note the S3 serving caveats from the project: by default S3 won't serve
  `index.html` from inside a folder (which is how Tome Static structures output),
  and Tome generates relative links assuming the site is served from a relative
  URL. You may need extra S3/CloudFront/Lambda configuration (or the *Relative Path
  to Absolute URLs* module) to serve the preview correctly. That routing setup is
  left to the site owner.

## Who can generate previews

Preview Site provides its own **permissions** — grant them (via **People →
Permissions**) only to the editors who should be allowed to build and deploy
previews, since a preview publishes draft content to an external location.
