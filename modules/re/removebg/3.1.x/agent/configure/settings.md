<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure remove.bg

## Settings
Route `removebg.settings.form` → `/admin/config/removebg` (permission `administer removebg`).
Stored in `removebg.settings`:
- **api_provider** — `removebg` (remove.bg) or `rembg` (rembg.com).
- **api_key** — provider API key (sent as `X-Api-Key` / `x-api-key` header).
- **output_format** — e.g. `png`.
The form calls the provider `/account` endpoint to display credits/status.

## Apply the effect
Edit an **image style** (Media → Image styles) and add the **remove.bg** effect
(`RemoveBgImageEffect`). When the style is built, the effect writes the source image to a temp
file and POSTs it multipart to the fixed provider endpoint, then replaces the derivative with the
returned image.

## Security notes
- Only the image under processing is sent (no user-supplied URL) → no SSRF.
- Fixed endpoints: `https://api.remove.bg/v1.0/removebg`, `https://api.rembg.com/rmbg`.
- Guzzle default TLS verification applies.
