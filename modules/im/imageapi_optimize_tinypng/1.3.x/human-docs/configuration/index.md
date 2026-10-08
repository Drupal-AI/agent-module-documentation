# Configuration

TinyPNG isn't a standalone settings page — it's a **processor** you add to an Image
Optimize pipeline (provided by the ImageAPI Optimize module), and then assign that
pipeline to your image styles.

## 1. Add the TinyPNG processor to a pipeline

1. Go to **Configuration → Media → Image Optimize pipelines**
   (`/admin/config/media/imageapi-optimize-pipelines`).
2. **Add a pipeline** (or edit an existing one) and give it a name.
3. Choose **Add a new processor** and select **TinyPNG**.
4. Enter your **TinyPNG API key** (get one at <https://tinypng.com>). The key is
   required, and it's validated live against TinyPNG when you save — if it's wrong,
   the form shows an error, so you'll know immediately.
5. If you like, add other processors to the same pipeline (for example a resize or
   WebP step); they run in order as steps of one pipeline.
6. **Save** the pipeline.

## 2. Assign the pipeline to image styles

Adding the processor does nothing on its own — the pipeline has to be attached to the
image styles you want optimized.

1. Go to **Configuration → Media → Image styles** and edit an image style.
2. Set its **optimize pipeline** to the pipeline you just built.
3. Save. From now on, every derivative that style generates is sent to TinyPNG,
   compressed, and written back over the derivative file. Your original uploaded
   images are left untouched.

> **Tip — control cost:** each derivative TinyPNG optimizes counts as one metered API
> call against your account. Rather than optimizing everything, scope the pipeline to
> the styles that benefit most — large hero and content images — to keep within your
> quota.

## Regenerating and monitoring

- **To (re)optimize existing images**, flush the image style so its derivatives
  regenerate through the pipeline: **Configuration → Development → Performance** has a
  cache clear, or use `drush image:flush <style>`.
- **If optimization fails** — for example you've hit your monthly quota or there's a
  network error — the module catches the error, logs it to the `imageapi_optimize`
  logger channel (see **Reports → Recent log messages**), and leaves the
  un‑optimized derivative in place so images still display.

## Keeping the API key out of committed config

The API key is stored in the pipeline's processor configuration, which means it can
end up in your exported configuration. To avoid committing a real key, override it
per‑environment from `settings.php` instead — Drupal lets you override any config
value there. For example, read the key from an environment variable:

```php
// settings.php — replace <pipeline_id> with your pipeline's machine name.
$config['imageapi_optimize.pipeline.<pipeline_id>']['processors']['<uuid>']['data']['api_key']
  = getenv('TINYPNG_API_KEY');
```

With DDEV you can store the value with
`ddev dotenv set .ddev/.env --tinypng-api-key=<value>` (never commit `.ddev/.env`),
then `ddev restart`. See the project `AGENTS.md` for the recommended secrets workflow.
Leave the form field blank (or with a placeholder) in the exported config so the real
key only exists in the environment.
