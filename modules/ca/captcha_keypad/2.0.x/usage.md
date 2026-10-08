Captcha Keypad protects Drupal forms from spam by asking visitors to click a short numeric code on an on-screen keypad instead of typing distorted text.

---

Captcha Keypad is a privacy-friendly, self-hosted CAPTCHA: no third-party service is contacted and no visitor data leaves the site. A visitor is shown a short numeric code (1–16 digits) and must click it key-by-key on a rendered keypad; typing into the field is rejected and the keypad buttons can be shuffled on every page load. It runs in two modes. Standalone, `hook_form_alter()` adds the keypad to a configured set of core forms (user register/login/login-block/password-reset, contact, comment, forum, and per-node-type forms) and validates via the module's own controller. When the contrib CAPTCHA module is installed, Captcha Keypad instead registers a challenge type named "Keypad" (`hook_captcha()`) and you place it through CAPTCHA points; the standalone form list is then hidden. Settings live at `/admin/config/system/captcha_keypad` behind the `administer captcha keypad` permission, and user 1 or holders of that permission can be exempted. Because the challenge requires clicking, it is not suitable as the only challenge on forms that must be usable by keyboard-only or screen-reader users.

---

- Add a no-JavaScript-service, GDPR-friendly CAPTCHA to a user registration form to cut down bot signups.
- Protect the anonymous contact form (`contact_message_*_form`) from automated spam submissions.
- Add a keypad challenge to comment forms so anonymous commenters must complete it before posting.
- Challenge forum topic/comment submissions (`comment_comment_forum_form`) on community sites.
- Protect the password-reset form (`user_pass`) against automated account-enumeration attempts.
- Add the keypad to the login form or login block to slow credential-stuffing bots.
- Protect specific content-type node forms (e.g. `node_article_form`) that anonymous or low-trust users can submit.
- Replace Google reCAPTCHA with a self-hosted alternative to avoid sending visitor data to a third party.
- Configure a longer code (up to 16 digits) on high-value forms to raise the effort bar.
- Enable "Shuffle keypad" so button positions randomize on each page load.
- Choose a keypad theme (Plain, Horizontal, Vertical) to fit the form's layout or a narrow sidebar.
- Exempt administrators (user 1 and holders of `administer captcha keypad`) so site builders are never locked out while testing.
- Use it together with the contrib CAPTCHA module to centralize placement via CAPTCHA points across many forms.
- Offer a non-audio, non-text CAPTCHA on mobile-first sites where tapping numbers is easier than reading distorted glyphs.
- Provide a lightweight challenge that adds no external HTTP requests and no cookies from third parties.
- Add the keypad to a webform-style or custom form by enabling the CAPTCHA module and assigning the Keypad challenge to that form_id.
- Localize the challenge automatically, since all strings pass through Drupal's translation system.
- Style the challenge with the shipped CSS themes or override the `captcha-keypad-buttons` Twig templates for custom markup.
- Set a short default code (e.g. 3–4 digits) on low-risk forms to minimize friction for legitimate users.
- Combine with server-side moderation so flagged submissions are still reviewed even after the challenge is passed.
- Use on staging to demonstrate a privacy-first anti-spam stack without configuring API keys.
