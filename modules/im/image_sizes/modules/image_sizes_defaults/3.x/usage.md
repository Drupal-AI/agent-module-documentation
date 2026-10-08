Installs ready-made Image Sizes presets (Default, Landscape, Portrait) and their image styles so container-responsive images work immediately without hand-building styles.

---

`image_sizes_defaults` is an optional submodule of **Image Sizes**. It ships no PHP code — it is a
config-only module whose `config/install/` folder imports three `image_sizes_preset_entity` presets
(`default`, `landscape`, `portrait`) plus a full set of core image styles for each: a scale ladder
from 100px to 1400px in 100px steps, and a blurred 15px `*_preload` placeholder style. `Default`
uses plain `image_scale` styles; `Landscape` and `Portrait` use `image_scale_and_crop` at fixed
aspect ratios (e.g. `Landscape_800` = 800×600, center-center). Every style also appends an
`image_convert` effect to **WebP**, and each preload style adds an `image_effects_gaussian_blur` —
which is why the submodule depends on **`image_effects`** in addition to `image_sizes`. After
enabling, the presets appear at `/admin/config/media/image_sizes_preset_entity` and can be selected
in the "Image sizes presets" field formatter. There is no separate configuration UI, permission,
route, or service of its own; it is governed entirely by the parent module.

---

- Get a working container-responsive image setup in one `drush en image_sizes_defaults` instead of running the `isg` generator.
- Import a `Default` preset with a 100–1400px scale ladder and a blurred preload placeholder.
- Import a `Landscape` preset using 4:3-style `image_scale_and_crop` derivatives (e.g. 800×600).
- Import a `Portrait` preset using portrait-oriented scale-and-crop derivatives.
- Provide editors ready-made presets to choose in the "Image sizes presets" formatter with no setup.
- Serve all default derivatives as WebP out of the box (each style has an `image_convert` effect).
- Show a lightweight blurred placeholder before the full image loads (`*_preload` styles).
- Use as a reference/example of how to structure your own `image_sizes` presets and styles.
- Clone and rename an imported preset to build a project-specific variant quickly.
- Seed a new site's media configuration with sensible responsive image styles.
- Combine the imported presets with the parent's lazy-loading JS behavior automatically.
- Enable only when you want the sample content; keep disabled if you build presets by hand.
- Rely on `image_effects` (a hard dependency) for the gaussian-blur thumbnail effect.
- Delete presets/styles you do not need after install to trim the config.
- Standardize responsive image handling across a multisite by enabling the same submodule everywhere.
- Test the parent module's rendering pipeline end-to-end using known-good presets.
