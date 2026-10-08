Image CAPTCHA is a submodule of CAPTCHA that adds an "Image" challenge type: a dynamically generated, distorted image of random characters the user must read and retype.

---

Image CAPTCHA plugs into the base CAPTCHA module's `hook_captcha()` API to provide an image-based challenge as an alternative to the default Math question. It renders random characters into a PNG/JPEG using PHP's GD library and bundled TrueType fonts (Tuffy, Tesox), then asks the user to type what they see. A settings form exposes extensive control over appearance and difficulty: character set and code length, fonts, font size and spacing, foreground/background colours and colour randomness, distortion amplitude, dot and line noise, bilinear interpolation smoothing, file format, and optional right-to-left support. A refresh control lets users request a new image via AJAX, and a font-preview endpoint helps admins choose fonts. Because it only adds a challenge type, you use it exactly like any other CAPTCHA — set it as the default challenge or select it on individual CAPTCHA points. It requires the GD image library and the parent CAPTCHA module.

---

- Use a distorted-text image challenge instead of the default math question.
- Set Image CAPTCHA as the site-wide default challenge type.
- Apply the image challenge to the login form via a CAPTCHA point.
- Protect the registration form with a harder-to-OCR image challenge.
- Increase difficulty by raising distortion amplitude.
- Add line noise to defeat automated OCR bots.
- Add dot (speckle) noise to obscure characters.
- Restrict the allowed character set (e.g. digits only, no ambiguous letters).
- Set the code length (number of characters) shown in the image.
- Choose custom TrueType fonts for the rendered text.
- Adjust font size and inter-character spacing.
- Set custom foreground and background hex colours to match a theme.
- Randomise foreground colour to further hinder segmentation.
- Smooth rendering with bilinear interpolation for legibility.
- Output the challenge as PNG or JPEG.
- Enable right-to-left rendering for RTL languages.
- Let users fetch a fresh image with the AJAX refresh button.
- Preview available fonts before selecting them in the admin UI.
- Provide an accessible alternative image challenge alongside other CAPTCHA types.
- Reduce comment and contact-form spam without any third-party API key.
