# Image CAPTCHA settings

Config object `image_captcha.settings` (schema `config/schema/image_captcha.settings.yml`),
form `Drupal\image_captcha\Form\ImageCaptchaSettingsForm` at
`/admin/config/people/captcha/image_captcha` (route `image_captcha.settings`). Rendering is
done by service `image_captcha.render_service` (`ImageCaptchaRenderService`) using GD + the
bundled fonts under `fonts/` (Tuffy, Tesox).

Key settings:

| Key | Meaning |
|---|---|
| `image_captcha_image_allowed_chars` | Characters that may appear in the code. |
| `image_captcha_code_length` | Number of characters shown. |
| `image_captcha_fonts` | TrueType font file paths to use. |
| `image_captcha_font_size` | Font size in pixels. |
| `image_captcha_character_spacing` | Spacing between characters. |
| `image_captcha_background_color` / `image_captcha_foreground_color` | Hex colours. |
| `image_captcha_foreground_color_randomness` | Randomise the text colour. |
| `image_captcha_distortion_amplitude` | Amount of warp distortion. |
| `image_captcha_dot_noise` / `image_captcha_line_noise` / `image_captcha_noise_level` | Anti-OCR noise controls. |
| `image_captcha_bilinear_interpolation` | Smooth distorted output. |
| `image_captcha_file_format` | PNG or JPEG output. |
| `image_captcha_rtl_support` | Right-to-left rendering. |

Extra routes: `image_captcha.generator` (renders the live image), `image_captcha.refresh`
(AJAX new image), `image_captcha.font_preview` (admin font preview). Read/write config with
`drush config:get image_captcha.settings`. Requires the PHP **GD** extension.
