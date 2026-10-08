# image_captcha — agent start

CAPTCHA submodule that adds an **Image** challenge (distorted GD-rendered text). Requires
`captcha`. Implements `hook_captcha()` (`image_captcha_captcha()`), so once enabled the type
`image_captcha/Image` is selectable anywhere CAPTCHA challenges are chosen. Config UI:
`/admin/config/people/captcha/image_captcha` (route `image_captcha.settings`).

- Appearance & difficulty settings (chars, fonts, noise, colours, distortion) → [configure/settings.md](configure/settings.md)
