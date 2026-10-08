<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure LinkedIn Insights Tag

Route `linkedin_insights_tag.admin_settings_form` → **`/admin/config/system/linkedin-insights`**,
permission **`administer linkedin insights`** (`linkedin_insights_tag.permissions.yml`). Form
`LinkedinInsightsAdminSettingsForm` (a `ConfigFormBase`) edits config object
`linkedin_insights_tag.settings`.

## Config keys

| Key | Type | Default (install) | Meaning |
|---|---|---|---|
| `partner_id` | string | empty | LinkedIn Partner ID. Nothing loads until set. |
| `user_role_roles` | sequence of role ids | `[anonymous]` | The tag/JS loads only for users holding one of these roles. |
| `image_only` | bool | `false` | If true, skip the JS library and only emit the image pixel (never wrapped in `<noscript>`). |

The form's "Partner ID" field has `#maxlength 50`, `#required`. The roles checkboxes are filtered to
the non-empty selections on validate.

## How the tag is emitted

- `linkedin_insights_tag_page_attachments(&$page)`: when `image_only` is empty **and** the current
  user's roles intersect `user_role_roles`, it sets
  `$page['#attached']['drupalSettings']['linkedin_insights_tag']['partner_id']` and attaches libraries
  `linkedin_insights_tag/linkedin_insights_tag_variables` and `.../linkedin_insights_tag`. The library
  pulls the remote script `//snap.licdn.com/li.lms-analytics/insight.min.js` (declared `type: external`).
- `linkedin_insights_tag_page_bottom(&$page_bottom)`: when `partner_id` is set, appends an
  `html_tag` `<img>` (1×1, `display:none`) with
  `src = https://dc.ads.linkedin.com/collect/?pid=<partner_id>&fmt=gif`, validated by
  `UrlHelper::isValid($img_src, TRUE)`. `#noscript` is true unless `image_only` is on.

## Set via Drush

```
drush cset linkedin_insights_tag.settings partner_id 123456 -y
drush cset linkedin_insights_tag.settings image_only 0 -y
# user_role_roles is a sequence keyed by role id, e.g.:
drush cset linkedin_insights_tag.settings user_role_roles.0 anonymous -y
```

Note: the front-end helper JS (`js/linkedin_insights_tag.js`) assigns
`_linkedin_data_partner_id = drupalSettings.linkedin_insights_tag.partner_id`.
