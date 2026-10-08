<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Image Filename renames uploaded images to descriptive, SEO-friendly filenames using an AI vision model.

---

AI Image Filename replaces meaningless upload names like `IMG_1234.jpg` with short, descriptive, hyphenated names derived from the image content, such as `golden-retriever-catching-frisbee-in-park.jpg`. It subscribes to Drupal core's `FileUploadSanitizeNameEvent` at priority 10 (before the default sanitizer), so on every image upload it sends the file's bytes to a Chat-with-Image-Vision model through the Drupal AI module, sanitizes the model's answer to a safe lowercase hyphenated stem, and sets that as the filename before the file is stored. It requires the AI module with a vision-capable provider (e.g. OpenAI); a single settings page lets you toggle it, edit the prompt, and pick the model. It targets `jpg`, `jpeg`, `png`, `gif`, and `webp`.

---

- Give uploaded photos human-readable, descriptive filenames automatically.
- Improve image SEO by putting real keywords in the filename.
- Replace camera names like `DSC00021.jpg` with meaningful names.
- Rename media-library image uploads on the fly.
- Rename image-field uploads on node/entity forms.
- Produce consistent lowercase-hyphenated filenames site-wide.
- Describe the primary subject, action, and setting in the name.
- Restrict AI renaming to real image types (jpg/jpeg/png/gif/webp).
- Let editors upload straight from a phone without cleaning up names.
- Toggle AI renaming on or off without uninstalling the module.
- Customize the prompt that instructs the model how to name files.
- Choose which vision-capable AI provider/model does the naming.
- Fall back to the site's default Image Vision model when none is chosen.
- Reuse an existing Drupal AI provider configuration (no separate key here).
- Keep the file extension intact while renaming the stem.
- Cap generated names to a safe length automatically.
- Improve accessibility workflows that start from good filenames.
- Standardize asset naming across a content team.
- Speed up digital-asset organization for large image libraries.
- Skip non-image uploads so documents keep their original names.
