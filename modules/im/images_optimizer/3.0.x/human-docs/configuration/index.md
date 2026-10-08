# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Media → Images Optimizer**, or navigate directly to
   `/admin/config/media/images-optimizer`.

## Choose which optimizers to use

The form lists the optimizers registered on your site. Two come with the module —
one for **JPEG** and one for **PNG** — and any custom optimizer a developer has
added will appear here too. Tick the optimizers you want active. Only the ones
you enable will run when an image is uploaded.

Remember that the built-in optimizers depend on the `jpegoptim` and `pngquant`
command-line tools being installed on the server (see
[Installation](../installation/index.md)). Enabling an optimizer whose tool is
missing will simply have no effect.

## Configure each optimizer's options

Each enabled optimizer exposes its own options (for example the quality/
compression level it should apply). Set these to balance file size against visual
quality — more aggressive compression produces smaller files but can introduce
visible artefacts, so it is worth testing on representative images.

## Save

Click **Save configuration**. From then on:

- Every newly uploaded image whose type matches an enabled optimizer is
  compressed on upload, and **the original file is replaced** by the optimized
  version.
- If you use image styles, the derivative images they generate are optimized too.

> **Test before going live.** Because optimization overwrites the original upload,
> confirm your chosen settings look right on a few sample images before applying
> the module to production uploads.

## Going beyond the built-ins

If the two provided optimizers do not fit your needs, a developer can register a
custom optimizer by adding a service that implements the module's
`OptimizerInterface` and tagging it with `images_optimizer.optimizer`. Once
registered, it appears in the list on this form alongside the built-ins.
