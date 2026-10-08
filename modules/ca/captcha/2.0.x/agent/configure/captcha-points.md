# CAPTCHA points — attach a challenge to a form

The CAPTCHA points list at `/admin/config/people/captcha/captcha-points` (shipped points for the
login, register, password and personal-contact forms):
![CAPTCHA points list](../../../../../../../screenshots/captcha/2.0.x/captcha-points.png)

A **CAPTCHA point** maps a form ID to a challenge type. It is a config entity
`captcha_point` (`src/Entity/CaptchaPoint.php`, schema `captcha.captcha_point.*`),
exportable as `captcha.captcha_point.<form_id>.yml`.

Manage in the UI at `/admin/config/people/captcha/captcha-points` (route
`captcha_point.list`); add/edit/enable/disable/delete forms are the other
`entity.captcha_point.*` routes. Ships enabled points for `user_login_form`,
`user_register_form`, `user_pass`, and `contact_message_personal_form`.

Config entity fields:

| Field | Meaning |
|---|---|
| `formId` | The Drupal form ID to protect (e.g. `comment_comment_form`). |
| `captchaType` | Challenge as `module/type`, e.g. `captcha/Math`, `image_captcha/Image`, or `default`. |
| `label` | Human label. |

Example export:
```yaml
# captcha.captcha_point.user_login_form.yml
langcode: en
status: true
id: user_login_form
formId: user_login_form
captchaType: default
```

In code, `captcha_set_form_id_setting($form_id, $captcha_type)` and
`captcha_get_form_id_setting($form_id)` (in `captcha.inc`) create/read a point.
Find a form's ID by enabling **administration mode** (settings) — links appear on each form.
